$ErrorActionPreference = 'SilentlyContinue'
$gitAi = 'C:\Users\calim\.git-ai\bin\git-ai.exe'
$stdin = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($stdin)) { exit 0 }

$payload = $null
try { $payload = $stdin | ConvertFrom-Json } catch { }

function Invoke-GitAiCheckpoint([string]$json) {
    $json | & $gitAi checkpoint cline --hook-input stdin 2>&1 | Out-Null
}

function Add-ModelInfo([object]$p) {
    if ($null -eq $p.model) {
        $cfgPath = Join-Path $env:USERPROFILE '.cline\data\settings\providers.json'
        if (Test-Path -LiteralPath $cfgPath) {
            $cfg = Get-Content -LiteralPath $cfgPath -Raw | ConvertFrom-Json
            $providerId = $cfg.lastUsedProvider
            $model = $cfg.providers.$providerId.settings.model
            if ($model) {
                $parts = @($model -split '/', 2)
                $p | Add-Member -MemberType NoteProperty -Name 'model' -Value @{ provider = $parts[0]; slug = $parts[-1] }
            }
        }
    }
}

function Resolve-ToolPath([object]$p, [string]$toolName) {
    $params = $p.preToolUse.parameters
    $path = $null
    if ($null -ne $params) {
        if ($params.path) { $path = $params.path } elseif ($params.file_path) { $path = $params.file_path }
    }
    if (-not $path) {
        $ti = $p.tool_call.input
        if ($null -ne $ti) {
            if ($ti.path) { $path = $ti.path } elseif ($ti.file_path) { $path = $ti.file_path }
        }
    }
    if ($path -and -not [System.IO.Path]::IsPathRooted($path)) {
        $path = [System.IO.Path]::GetFullPath((Join-Path $PWD $path))
    }
    $path
}

function Get-PostEditContent([object]$p, [string]$toolName, [string]$path) {
    $params = $p.preToolUse.parameters
    if ($null -eq $params) { $params = $p.tool_call.input }
    $content = $null
    if ($toolName -in @('write_to_file', 'write')) {
        $content = $params.content
    } else {
        $oldText = $params.old_text
        $newText = $params.new_text
        if ($oldText -and $newText) {
            $text = [System.IO.File]::ReadAllText($path)
            if ($text.Contains($oldText)) {
                $content = $text.Replace($oldText, $newText)
            }
        }
    }
    $content
}

$path = $null
$restore = $null
try {
    if ($null -ne $payload) {
        $toolName = $payload.tool_call.name
        if ([string]::IsNullOrEmpty($toolName)) { $toolName = $payload.preToolUse.toolName }
        $editTools = @('editor', 'write_to_file', 'apply_patch', 'edit', 'write')
        if ($editTools -contains $toolName -and $null -ne $payload.preToolUse) {
            $path = Resolve-ToolPath $payload $toolName
            $postContent = Get-PostEditContent $payload $toolName $path
            if ($path -and $null -ne $postContent -and (Test-Path -LiteralPath $path)) {
                $orig = [System.IO.File]::ReadAllBytes($path)
                if ($null -ne $orig) {
                    $hasBom = ($orig.Length -ge 3 -and $orig[0] -eq 0xEF -and $orig[1] -eq 0xBB -and $orig[2] -eq 0xBF)
                    $utf8 = New-Object System.Text.UTF8Encoding($hasBom)
                    [System.IO.File]::WriteAllText($path, $postContent, $utf8)
                    $restore = $orig
                }
            }
            $payload | Add-Member -MemberType NoteProperty -Name 'postToolUse' -Value $payload.preToolUse
            $payload.PSObject.Properties.Remove('preToolUse')
            $payload.hookName = 'PostToolUse'
        } else {
            $payload.hookName = 'PreToolUse'
        }
        Add-ModelInfo $payload
        $out = $payload | ConvertTo-Json -Compress -Depth 30
        Invoke-GitAiCheckpoint $out
        if ($null -ne $restore) {
            Start-Sleep -Milliseconds 1500
            [System.IO.File]::WriteAllBytes($path, $restore)
            $restore = $null
        }
    } else {
        Invoke-GitAiCheckpoint $stdin
    }
} catch {
    if ($null -ne $restore -and $path -and (Test-Path -LiteralPath $path)) {
        [System.IO.File]::WriteAllBytes($path, $restore)
    }
    Invoke-GitAiCheckpoint $stdin
}
exit 0
