$ErrorActionPreference = 'Stop'

# uninstall.ps1 - removes the git-ai-attribution key from Antigravity's
# ~/.gemini/config/hooks.json. Removes hooks.json entirely if it becomes empty.

$hooksPath = Join-Path $env:USERPROFILE '.gemini\config\hooks.json'

if (-not (Test-Path $hooksPath)) {
    Write-Output 'No hooks.json found; nothing to uninstall.'
    exit 0
}

$existing = Get-Content $hooksPath -Raw | ConvertFrom-Json
if ($existing.'git-ai-attribution') {
    $existing.PSObject.Properties.Remove('git-ai-attribution')
}

$names = @($existing.PSObject.Properties.Name)
if ($names.Count -eq 0) {
    Remove-Item $hooksPath -Force
    Write-Output 'Removed empty hooks.json.'
} else {
    [System.IO.File]::WriteAllText($hooksPath, ($existing | ConvertTo-Json -Depth 12), (New-Object System.Text.UTF8Encoding($false)))
    Write-Output 'Removed git-ai-attribution hook. Remaining hooks.json:'
    Write-Output (Get-Content $hooksPath -Raw)
}
