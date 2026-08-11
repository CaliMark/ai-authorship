@echo off
rem Verify Antigravity -> git-ai attribution.
rem Run from inside the git repo Antigravity edited:
rem   cd C:\path\to\your\repo
rem   "%~dp0verify-attribution.cmd" [options]
rem Options: -Message "msg"   commit message
rem          -Paths a.txt,b.txt   commit only these files
rem          -SkipCommit          don't commit, just show status/log
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0verify-attribution.ps1" %*
set EXIT=%errorlevel%
if not "%EXIT%"=="0" pause
exit /b %EXIT%
