param(
    [string]$Message = 'antigravity attribution test',
    [string[]]$Paths = @(),
    [switch]$SkipCommit
)

# verify-attribution.ps1 - end-to-end check that Antigravity edits were
# attributed to the gemini session, not to a live opencode session.
# Run from inside the git repo that Antigravity edited.

$ErrorActionPreference = 'Stop'
$bridge = Split-Path -Parent $MyInvocation.MyCommand.Path

# --- Locate git-ai (env override > PATH > default install dir) ---
$gitAi = $env:GIT_AI_BIN
if (-not $gitAi -or -not (Test-Path $gitAi)) {
    $cand = Get-Command git-ai -ErrorAction SilentlyContinue
    if ($cand) { $gitAi = $cand.Source }
}
if (-not $gitAi -or -not (Test-Path $gitAi)) {
    $fallback = Join-Path $env:USERPROFILE '.git-ai\bin\git-ai.exe'
    if (Test-Path $fallback) { $gitAi = $fallback }
}
if (-not $gitAi) {
    Write-Host 'ERROR: git-ai binary not found.'
    Write-Host 'Install git-ai, add it to PATH, or set GIT_AI_BIN to the git-ai.exe path.'
    exit 1
}

$repo = (Get-Location).Path
$repoName = Split-Path $repo -Leaf
$resultFile = Join-Path $bridge 'attribution-result.txt'
$out = New-Object System.Collections.Generic.List[string]

function Say([string]$t) {
    Write-Host $t
    $out.Add($t)
}

Say "== Antigravity attribution verification =="
Say "Repo : $repo"
Say ""

if (-not (Test-Path (Join-Path $repo '.git'))) {
    Say "ERROR: this is not a git repository."
    Say "Run this script from inside the git repo that Antigravity edited:"
    Say "    cd C:\path\to\your\repo"
    Say "    $(Join-Path $bridge 'verify-attribution.cmd')"
    Say ""
    Say "Any git repo works. (Tip: use a scratch repo first if you don't want a"
    Say "test commit in your real project.)"
    [System.IO.File]::WriteAllLines($resultFile, $out)
    exit 1
}

$oc = @(Get-Process -Name 'opencode' -ErrorAction SilentlyContinue)
if ($oc.Count -gt 0) {
    Say "WARNING: opencode.exe is RUNNING ($($oc.Count) instance(s))."
    Say "A live opencode session claims attribution as 'opencode' instead of 'gemini'."
    Say "Close VSCode (and any terminal running opencode), wait ~15 seconds, then re-run."
    Say ""
} else {
    Say "OK: no opencode process detected."
    Say ""
}

Say "== git-ai status (pending checkpoints) =="
$st = & $gitAi status --json 2>&1 | Out-String
Say $st.Trim()
Say ""

Say "== git status --short =="
$gs = git status --short 2>&1 | Out-String
Say $gs.Trim()
Say ""

if ($SkipCommit) {
    Say "Skipping commit (-SkipCommit)."
} else {
    Say "== Pre-sweep: registering the Antigravity gemini session =="
    $trigger = Join-Path $env:TEMP 'git-ai-sweep-trigger'
    if (-not (Test-Path (Join-Path $trigger '.git'))) {
        New-Item -ItemType Directory -Path $trigger -Force | Out-Null
        git -C $trigger init -q
        git -C $trigger config user.email trigger@git-ai.local
        git -C $trigger config user.name trigger
    }
    Add-Content -Path (Join-Path $trigger 'trigger.txt') -Value ("sweep " + (Get-Date -Format o))
    git -C $trigger add -A
    git -C $trigger commit -qm "sweep trigger"
    & $gitAi await --timeout 30 | Out-Null
    Say "done."
    Say ""

    Say "== Committing changes =="
    if ($Paths.Count -gt 0) {
        Say "Staging: $($Paths -join ', ')"
        git add -- $Paths
    } else {
        Say "Staging all changes (git add -A)"
        git add -A
    }
    if ($LASTEXITCODE -ne 0) { exit 1 }
    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Say "WARNING: nothing is staged. Did Antigravity actually edit files in this repo?"
        Say "Run an Antigravity session first (a write/replace file edit), then re-run this script."
        Say ""
        [System.IO.File]::WriteAllLines($resultFile, $out)
        exit 1
    }
    git commit -m $Message
    Say "Committed."
    Say ""

    Say "== Waiting for attribution processing =="
    & $gitAi await --timeout 30 | Out-Null
    Say "done."
    Say ""

    Say "== Pushing git-ai notes (refs/notes/ai) =="
    $notesOut = & git push origin refs/notes/ai 2>&1
    $notesCode = $LASTEXITCODE
    foreach ($line in $notesOut) { Say ($line | Out-String).Trim() }
    if ($notesCode -ne 0) {
        Say "NOTE: could not push refs/notes/ai - the remote authorship report will not show"
        Say "this commit's attribution. Push manually: git push origin refs/notes/ai"
    }
    Say ""
}

Say "== git-ai log --raw -1 (authorship note) =="
$log = (& $gitAi log --raw -1 2>&1 | Out-String)
Say $log.Trim()
Say ""

$note = $log
$hasGemini = $note -match 'tool"\s*:\s*"gemini"'
$hasOpencode = $note -match 'tool"\s*:\s*"opencode"'

Say "== RESULT =="
if ($hasGemini -and -not $hasOpencode) {
    Say "PASS - attribution went to the gemini (Antigravity) session."
} elseif ($hasGemini -and $hasOpencode) {
    Say "MIXED - some lines attributed to gemini, some to opencode. An opencode"
    Say "session was active during part of the work."
} elseif ($hasOpencode) {
    Say "FAIL - attributed to 'opencode', not gemini. A live opencode session was"
    Say "active. Close VSCode, wait ~15s, then make another small commit and re-run."
    Say "The gemini session is now registered, so the next commit should be correct."
} else {
    Say "UNKNOWN - no agent tool found in the note. The lines may be attributed as"
    Say "'human'/'untracked'. Check bridge.log for RAW payloads from Antigravity:"
    Say "    $(Join-Path $bridge 'bridge.log')"
    Say "If no RAW lines exist, Antigravity's hooks aren't firing or the payload"
    Say "uses different field names than the bridge expects - send me bridge.log."
}
Say ""

Say "== Where the data lives (for debugging) =="
$bridgeLog = Join-Path $bridge 'bridge.log'
$gemTmp = Join-Path $env:USERPROFILE ".gemini\tmp\$repoName"
$daemonLogs = Join-Path $env:USERPROFILE '.git-ai\internal\daemon\logs'
Say "bridge.log (raw Antigravity payloads) : $bridgeLog"
Say "gemini session transcripts             : $gemTmp"
Say "git-ai daemon logs (checkpoints/sweeps): $daemonLogs"
Say "This result file                       : $resultFile"
Say ""
Say "If the result is FAIL/UNKNOWN, paste me:"
Say "  1) $resultFile"
Say "  2) the last ~30 lines of $bridgeLog"
Say "  3) the last ~15 'sweep item'/'checkpoint' lines from the newest file in $daemonLogs"
[System.IO.File]::WriteAllLines($resultFile, $out, (New-Object System.Text.UTF8Encoding($false)))
