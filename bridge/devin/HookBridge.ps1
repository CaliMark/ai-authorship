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

function New-DevinTranscriptLine([string]$sessionId, [string]$model) {
    if ([string]::IsNullOrWhiteSpace($model)) { $model = 'unknown' }
    $ts = [DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ss.fffZ')
    $line = '{"type":"assistant","message":{"id":"msg_dev","type":"message","role":"assistant","model":"' + $model +
        '","content":[{"type":"text","text":"devin edit"}],"stop_reason":null,"usage":{"input_tokens":0,"output_tokens":0}},"requestId":"req_dev","sessionId":"s_dev","parentUuid":null,"ts":"' + $ts + '","uuid":"u_dev"}' + "`n"
    return $line
}

function Invoke-GitAiCheckpoint([string]$json) {
    $json | & $gitAi checkpoint claude --hook-input stdin 2>&1 | Out-Null
}

$payload = $null
try { $payload = $stdin | ConvertFrom-Json } catch { }

try {
    if ($null -ne $payload) {
        $toolName = $payload.tool_name
        if ($toolName -in @('edit', 'write', 'multi_edit', 'apply_patch', 'notebook')) {
            $toolName = switch ($toolName) {
                'edit' { 'Edit' }
                'write' { 'Write' }
                'multi_edit' { 'MultiEdit' }
                'apply_patch' { 'MultiEdit' }
                'notebook' { 'Edit' }
            }
            $payload.tool_name = $toolName
        }

        if (-not $payload.cwd) {
            $cwd = $env:DEVIN_PROJECT_DIR
            if (-not $cwd) { $cwd = (Get-Location).Path }
            $payload | Add-Member -MemberType NoteProperty -Name 'cwd' -Value $cwd
        }

        if (-not $payload.transcript_path) {
            $sessionId = $payload.session_id
            $model = $null
            try {
                $model = Get-DevinSessionModel $sessionId
            } catch { }
            $t = Join-Path $env:TEMP 'devin-transcript.jsonl'
            $line = New-DevinTranscriptLine $sessionId $model
            [System.IO.File]::WriteAllText($t, $line)
            $payload | Add-Member -MemberType NoteProperty -Name 'transcript_path' -Value $t
        }

        if ($payload.hook_event_name -notin @('PreToolUse', 'PostToolUse')) {
            $payload.hook_event_name = 'PostToolUse'
        }

        $out = $payload | ConvertTo-Json -Compress -Depth 30
        Invoke-GitAiCheckpoint $out
    } else {
        Invoke-GitAiCheckpoint $stdin
    }
} catch {
    Invoke-GitAiCheckpoint $stdin
}
exit 0
