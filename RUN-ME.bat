@echo off
REM Windows Claude Code Installer Launcher
REM This batch file keeps the window open and launches the PowerShell script

echo.
echo ========================================================================
echo     WINDOWS CLAUDE CODE INSTALLER
echo ========================================================================
echo.
echo This will install Claude Code with WSL2 on your Windows 11 machine.
echo.
echo Press any key to start the installation...
pause >nul

echo.
echo Checking for Administrator privileges...
echo.

REM Check if running as admin
net session >nul 2>&1
if %errorLevel% == 0 (
    echo SUCCESS: Running as Administrator
    echo.
    echo Starting PowerShell installer...
    echo.

    REM Run the PowerShell script and keep window open
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0SIMPLE-INSTALLER.ps1"

    echo.
    echo ========================================================================
    echo Installation script completed.
    echo ========================================================================
    echo.
) else (
    echo ERROR: Not running as Administrator!
    echo.
    echo How to run as Administrator:
    echo   1. Right-click this file: RUN-ME.bat
    echo   2. Select "Run as administrator"
    echo   3. Click "Yes" when Windows asks for permission
    echo.
)

echo.
echo Press any key to close this window...
pause >nul
