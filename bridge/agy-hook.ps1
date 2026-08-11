$ErrorActionPreference = 'SilentlyContinue'

# agy-hook.ps1 - Antigravity IDE -> git-ai attribution bridge hook.
# Fired by ~/.gemini/config/hooks.json on every edit/command tool call. It
# forwards a git-ai "checkpoint" payload to the git-ai CLI and answers the
# permission prompt according to bridge/config.json.

$bridge = Split-Path -Parent $MyInvocation.MyCommand.Path
$logPath = Join-Path $bridge 'bridge.log'
$stubDir = Join-Path $bridge 'stubs'
$configPath = Join-Path $bridge 'config.json'

# --- Locate git-ai (env override > PATH > default install dir) ---
$gitAiPath = ''
$envBin = [string]$env:GIT_AI_BIN
if (-not [string]::IsNullOrWhiteSpace($envBin) -and (Test-Path $envBin)) { $gitAiPath = $envBin }
if ([string]::IsNullOrWhiteSpace($gitAiPath)) {
    $cmd = Get-Command git-ai -ErrorAction SilentlyContinue
    if ($cmd) { $gitAiPath = $cmd.Source }
}
if ([string]::IsNullOrWhiteSpace($gitAiPath)) {
    $fallback = Join-Path $env:USERPROFILE '.git-ai\bin\git-ai.exe'
    if (Test-Path $fallback) { $gitAiPath = $fallback }
}

$defaultDecisions = @{ 'write_to_file'='allow'; 'replace_file_content'='allow'; 'multi_replace_file_content'='allow'; 'run_command'='ask' }
$decisions = $defaultDecisions
if (Test-Path $configPath) {
    try {
        $cfg = Get-Content $configPath -Raw | ConvertFrom-Json
        if ($cfg.preToolUseDecisions) { $decisions = $cfg.preToolUseDecisions }
    } catch {}
}
$toolMap = @{ 'write_to_file'='write_file'; 'replace_file_content'='replace'; 'multi_replace_file_content'='replace'; 'run_command'='run_shell_command' }

function Write-Log([string]$m) {
    try { [System.IO.File]::AppendAllText($logPath, (Get-Date).ToString('s') + ' ' + $m + [Environment]::NewLine, [System.Text.Encoding]::UTF8) } catch {}
}

function Write-NoBom([string]$path, [string]$content) {
    try { [System.IO.File]::WriteAllText($path, $content, (New-Object System.Text.UTF8Encoding($false))) } catch {}
}

function Write-GeminiTranscript {
    param([string]$conv, [string]$model, [string]$cwd, [string]$evt, [string]$tool)
    if ([string]::IsNullOrWhiteSpace($conv)) { return }
    if ([string]::IsNullOrWhiteSpace($cwd)) { return }
    $tmpRoot = Join-Path $env:USERPROFILE '.gemini\tmp'
    try { New-Item -ItemType Directory -Path $tmpRoot -Force | Out-Null } catch {}
    $projName = Split-Path $cwd -Leaf
    if ([string]::IsNullOrWhiteSpace($projName)) { $projName = 'antigravity-bridge' }
    $projName = $projName -replace '[<>:"/\\|?*]', '_'
    $projDir = Join-Path $tmpRoot $projName
    $chatsDir = Join-Path $projDir 'chats'
    try { New-Item -ItemType Directory -Path $chatsDir -Force | Out-Null } catch {}
    $rootFile = Join-Path $projDir '.project_root'
    if (-not (Test-Path $rootFile)) {
        try { [System.IO.File]::WriteAllText($rootFile, $cwd, (New-Object System.Text.UTF8Encoding($false))) } catch {}
    }
    $safeConv = $conv -replace '[<>:"/\\|?*]', '_'
    $sessionFile = Join-Path $chatsDir ('session-' + $safeConv + '.jsonl')
    $enc = New-Object System.Text.UTF8Encoding($false)
    $ts = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $uuid = [guid]::NewGuid().ToString()
    if ($evt -eq 'PreToolUse') {
        $turn = @{ id = $uuid; type = 'turn'; content = 'Working on the requested change.'; prompt = 'Working on the requested change.'; hidden = $false; timestamp = $ts; model = $model; metadata = @{}; config = 'gcloud'; usage = @{} } | ConvertTo-Json -Compress -Depth 4
        try { [System.IO.File]::AppendAllText($sessionFile, $turn + [Environment]::NewLine, $enc) } catch {}
    } else {
        $toolLine = @{ id = [guid]::NewGuid().ToString(); type = 'tool'; name = 'local_edit_file'; state = 'success'; content = ''; prompt = $tool; timestamp = $ts; toolUseId = $uuid; config = 'gcloud'; usage = @{} } | ConvertTo-Json -Compress -Depth 4
        try { [System.IO.File]::AppendAllText($sessionFile, $toolLine + [Environment]::NewLine, $enc) } catch {}
    }
    $script:realTranscriptPath = $sessionFile
    Write-Log ("TRANSCRIPT " + $sessionFile)
}

$raw = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($raw)) { exit 0 }
if ($raw.Length -gt 2000) { Write-Log ("RAW " + $raw.Substring(0, 2000)) } else { Write-Log ("RAW " + $raw) }

try { $p = $raw | ConvertFrom-Json } catch { Write-Output '{}'; exit 0 }

$evt = [string]$p.hookEventName
$ideFormat = [string]::IsNullOrWhiteSpace($evt)
if ($ideFormat) {
    if ($p.toolCall) {
        $evt = 'PostToolUse'
    } else {
        $evt = 'PreToolUse'
    }
}
if (-not $evt) { exit 0 }

$conv = [string]$p.conversationId
$model = [string]$p.modelName
if ([string]::IsNullOrWhiteSpace($model)) { $model = 'gemini-3.6-flash-medium' }
$stubPath = ''
$script:realTranscriptPath = ''
if (-not [string]::IsNullOrWhiteSpace($conv)) {
    try { New-Item -ItemType Directory -Path $stubDir -Force | Out-Null } catch {}
    $stubPath = Join-Path $stubDir ($conv + '.jsonl')
    if (-not [string]::IsNullOrWhiteSpace($model)) {
        $esc = $model.Replace('\', '\\').Replace('"', '\"')
        Write-NoBom $stubPath ('{"model":"' + $esc + '"}')
    }
}

function Send-Checkpoint($o) {
    $json = $o | ConvertTo-Json -Compress -Depth 6
    if ([string]::IsNullOrWhiteSpace($gitAiPath)) {
        Write-Log ("SKIP checkpoint (git-ai not found): " + $json)
        return
    }
    Write-Log ("SEND " + $json)
    $out = $json | & $gitAiPath checkpoint gemini --hook-input stdin 2>&1 | Out-String
    if (-not [string]::IsNullOrWhiteSpace($out)) { Write-Log ("GITAI " + $out.Trim()) }
    Write-Log ("EXIT " + $LASTEXITCODE)
}

if ($evt -eq 'PreToolUse') {
    if (-not $p.toolCall) {
        if ($ideFormat) { Write-Output '{"decision":"allow"}' } else { Write-Output '{"decision":"ask"}' }
        exit 0
    }
    $tool = [string]$p.toolCall.name
    if ($toolMap.ContainsKey($tool)) {
        $ti = @{}
        if ($tool -eq 'run_command') {
            if ($p.toolCall.args.CommandLine) { $ti.command = [string]$p.toolCall.args.CommandLine }
        } elseif ($p.toolCall.args.TargetFile) {
            $ti.file_path = [string]$p.toolCall.args.TargetFile
            try { $ti.file_path = [System.IO.Path]::GetFullPath($ti.file_path) } catch {}
        }
        $cwd = ''
        if ($p.workspacePaths -and $p.workspacePaths.Count -gt 0) { $cwd = [string]$p.workspacePaths[0] }
        if ([string]::IsNullOrWhiteSpace($cwd)) { $cwd = [string]$p.toolCall.args.Cwd }
        if (-not [string]::IsNullOrWhiteSpace($cwd)) { try { $cwd = [System.IO.Path]::GetFullPath($cwd) } catch {} }
        Write-GeminiTranscript -conv $conv -model $model -cwd $cwd -evt $evt -tool $tool
        $trPath = $script:realTranscriptPath
        if ([string]::IsNullOrWhiteSpace($trPath)) { $trPath = $stubPath }
        if (-not (Test-Path $trPath)) { $trPath = [string]$p.transcriptPath }
        $o = @{ session_id = $conv; transcript_path = $trPath; hook_event_name = $evt; tool_use_id = [string]$p.stepIdx; tool_name = $toolMap[$tool]; cwd = $cwd }
        if ($ti.Count -gt 0) { $o.tool_input = $ti }
        Send-Checkpoint $o
    } else {
        Write-Log ("SKIP " + $tool)
    }
    $decision = 'ask'
    if ($ideFormat) { $decision = 'allow' }
    if ($decisions -and $decisions.$tool) { $decision = [string]$decisions.$tool }
    $resp = @{ decision = $decision } | ConvertTo-Json -Compress
    Write-Output $resp
    exit 0
}

if ($evt -eq 'PostToolUse') {
    if ($p.error -and -not [string]::IsNullOrWhiteSpace([string]$p.error)) {
        if ($ideFormat) { Write-Output '{"decision":"allow"}' } else { Write-Output '{}' }
        exit 0
    }
    if ($p.toolCall) {
        $tool = [string]$p.toolCall.name
        if ($toolMap.ContainsKey($tool)) {
            $ti = @{}
            if ($tool -eq 'run_command') {
                if ($p.toolCall.args.CommandLine) { $ti.command = [string]$p.toolCall.args.CommandLine }
            } elseif ($p.toolCall.args.TargetFile) {
                $ti.file_path = [string]$p.toolCall.args.TargetFile
                try { $ti.file_path = [System.IO.Path]::GetFullPath($ti.file_path) } catch {}
            }
            $cwd = ''
            if ($p.workspacePaths -and $p.workspacePaths.Count -gt 0) { $cwd = [string]$p.workspacePaths[0] }
            if ([string]::IsNullOrWhiteSpace($cwd)) { $cwd = [string]$p.toolCall.args.Cwd }
            if (-not [string]::IsNullOrWhiteSpace($cwd)) { try { $cwd = [System.IO.Path]::GetFullPath($cwd) } catch {} }
            Write-GeminiTranscript -conv $conv -model $model -cwd $cwd -evt $evt -tool $tool
            $trPath = $script:realTranscriptPath
            if ([string]::IsNullOrWhiteSpace($trPath)) { $trPath = $stubPath }
            if (-not (Test-Path $trPath)) { $trPath = [string]$p.transcriptPath }
            $o = @{ session_id = $conv; transcript_path = $trPath; hook_event_name = $evt; tool_use_id = [string]$p.stepIdx; tool_name = $toolMap[$tool]; cwd = $cwd }
            if ($ti.Count -gt 0) { $o.tool_input = $ti }
            Send-Checkpoint $o
        }
    }
    if ($ideFormat) { Write-Output '{"decision":"allow"}' } else { Write-Output '{}' }
    exit 0
}

exit 0
