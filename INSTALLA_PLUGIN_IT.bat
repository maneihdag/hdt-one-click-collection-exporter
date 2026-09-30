@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\install_plugin.ps1" -Language it
echo.
echo Premi un tasto per chiudere...
pause >nul
