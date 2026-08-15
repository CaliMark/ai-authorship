$ErrorActionPreference = 'SilentlyContinue'
$gitAi = 'C:\Users\calim\.git-ai\bin\git-ai.exe'
$stdin = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($stdin)) { exit 0 }

function Get-DevinSessionModel([string]$sessionId) {
    if ([string]::IsNullOrWhiteSpace($sessionId)) { return $null }
    $db = Join-Path $env:APPDATA 'Devin\cli\sessions.db'
    if (-not (Test-Path -LiteralPath $db)) { return $null }
    $py = @"
import sqlite3, sys
try:
    c = sqlite3.connect(r"$($db.Replace('\','\\'))")
    r = c.execute("SELECT model FROM sessions WHERE id=?", (sys.argv[1],)).fetchone()
    print(r[0] if r else "")
except Exception:
    pass
"@
    $pyPath = Join-Path $env:TEMP 'devin-model-query.py'
    [System.IO.File]::WriteAllText($pyPath, $py)
    $out = & python $pyPath $sessionId 2>&1
    return ($out | Select-Object -First 1)
}

function Get-DevinFilePath([object]$payload) {
    $ti = $payload.tool_input
    if ($null -eq $ti) { return $null }
    $p = $ti.file_path
    if (-not $p) { $p = $ti.path }
    if (-not $p) { $p = $ti.notebook_path }
    if ($p -and -not [System.IO.Path]::IsPathRooted($p)) {
        $cwd = $payload.cwd
        if (-not $cwd) { $cwd = $env:DEVIN_PROJECT_DIR }
        if ($cwd) { $p = [System.IO.Path]::GetFullPath((Join-Path $cwd $p)) }
    }
    return $p
}

function Invoke-GitAiCheckpoint([string]$json) {
    $json | & $gitAi checkpoint agent-v1 --hook-input stdin 2>&1 | Out-Null
}

$payload = $null
try { $payload = $stdin | ConvertFrom-Json } catch { }

try {
    if ($null -ne $payload) {
        $cwd = $payload.cwd
        if (-not $cwd) { $cwd = $env:DEVIN_PROJECT_DIR }
        if (-not $cwd) { $cwd = (Get-Location).Path }
        $payload | Add-Member -MemberType NoteProperty -Name 'cwd' -Value $cwd -Force

        $filePath = Get-DevinFilePath $payload
        $filePaths = @()
        if ($filePath) { $filePaths = @($filePath) }
        $filePathsJson = '[]'
        if ($filePaths.Count -gt 0) {
            $escaped = @($filePaths | ForEach-Object { $_.Replace('\', '\\') })
            $filePathsJson = '["' + ($escaped -join '","') + '"]'
        }

        $isPre = ($payload.hook_event_name -eq 'PreToolUse')
        if ($isPre) {
            $body = '{"type":"human","repo_working_dir":"' + $cwd.Replace('\','\\') + '","will_edit_filepaths":' + $filePathsJson + '}'
        } else {
            $sessionId = $payload.session_id
            $model = $null
            try {
                $model = Get-DevinSessionModel $sessionId
            } catch { }
            if (-not $model) { $model = 'unknown' }
            $ts = [DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ss.fffZ')
            $body = '{"type":"ai_agent","repo_working_dir":"' + $cwd.Replace('\','\\') +
                '","agent_name":"devin","model":"' + $model + '","conversation_id":"' + $sessionId +
                '","edited_filepaths":' + $filePathsJson +
                ',"transcript":{"messages":[{"type":"user","text":"devin edit","timestamp":"' + $ts + '"}]}}'
        }
        Invoke-GitAiCheckpoint $body
    } else {
        Invoke-GitAiCheckpoint $stdin
    }
} catch {
    Invoke-GitAiCheckpoint $stdin
}
exit 0
