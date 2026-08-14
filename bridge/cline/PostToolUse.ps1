$ErrorActionPreference = 'SilentlyContinue'
$gitAi = 'C:\Users\calim\.git-ai\bin\git-ai.exe'
$stdin = [Console]::In.ReadToEnd()

if (-not [string]::IsNullOrWhiteSpace($stdin)) {
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

    if ($null -ne $payload) {
        Add-ModelInfo $payload
        $out = $payload | ConvertTo-Json -Compress -Depth 30
        Invoke-GitAiCheckpoint $out
    } else {
        Invoke-GitAiCheckpoint $stdin
    }
}

Write-Output '{"cancel":false}'
exit 0
