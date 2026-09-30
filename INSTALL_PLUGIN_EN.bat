@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\install_plugin.ps1" -Language en
echo.
echo Press any key to close...
pause >nul
