param([switch]$Force)

# install.ps1 - registers the git-ai-attribution hooks in Antigravity's
# ~/.gemini/config/hooks.json (merges with any existing hooks and backs up
# the previous file first).

$ErrorActionPreference = 'Stop'
$bridge = Split-Path -Parent $MyInvocation.MyCommand.Path

$hookCmd  = Join-Path $bridge 'agy-hook.cmd'
$cfgPath  = Join-Path $bridge 'config.json'
$hooksPath = Join-Path $env:USERPROFILE '.gemini\config\hooks.json'
$hooksDir  = Split-Path $hooksPath -Parent

if (-not (Test-Path $hookCmd)) {
    Write-Error "Missing $hookCmd - re-download the package."
}

New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null

if (-not (Test-Path $cfgPath)) {
    $cfg = @{ preToolUseDecisions = @{ write_to_file = 'allow'; replace_file_content = 'allow'; multi_replace_file_content = 'allow'; run_command = 'ask' } }
    [System.IO.File]::WriteAllText($cfgPath, ($cfg | ConvertTo-Json -Depth 5), (New-Object System.Text.UTF8Encoding($false)))
}

$matcher = 'write_to_file|replace_file_content|multi_replace_file_content|run_command'
$hookDef = @{
    PreToolUse  = @( @{ matcher = $matcher; hooks = @( @{ type = 'command'; command = $hookCmd; timeout = 30 } ) } )
    PostToolUse = @( @{ matcher = $matcher; hooks = @( @{ type = 'command'; command = $hookCmd; timeout = 30 } ) } )
}

$existing = $null
if (Test-Path $hooksPath) {
    try { $existing = Get-Content $hooksPath -Raw | ConvertFrom-Json } catch {
        Write-Error "Could not parse $hooksPath : $($_.Exception.Message)"
    }
}
if (-not $existing) { $existing = New-Object PSObject }

if ($existing.'git-ai-attribution' -and -not $Force) {
    Write-Output "git-ai-attribution hooks are already installed."
    Write-Output "Re-run with -Force to overwrite. Config: $hooksPath"
    exit 0
}

if (Test-Path $hooksPath) {
    $backup = "$hooksPath.bak-$(Get-Date -Format 'yyyyMMddHHmmss')"
    Copy-Item $hooksPath $backup -Force
    Write-Output "Backup of previous hooks.json: $backup"
}

$existing | Add-Member -NotePropertyName 'git-ai-attribution' -NotePropertyValue $hookDef -Force

[System.IO.File]::WriteAllText($hooksPath, ($existing | ConvertTo-Json -Depth 12), (New-Object System.Text.UTF8Encoding($false)))

Write-Output ""
Write-Output "Installed git-ai-attribution hooks at:"
Write-Output "  $hooksPath"
Write-Output ""
Write-Output (Get-Content $hooksPath -Raw)
Write-Output ""
Write-Output "Next:"
Write-Output "  1. Make an edit in Antigravity (a write/replace file edit or command)."
Write-Output "  2. From inside your git repo, run:  bridge\verify-attribution.cmd"
