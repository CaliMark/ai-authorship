@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0agy-hook.ps1"
exit /b %errorlevel%
