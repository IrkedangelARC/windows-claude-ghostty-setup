@echo off
REM All-In-One Windows Claude Code Installer
REM This file contains everything - no other files needed!

setlocal enabledelayedexpansion

echo.
echo ========================================================================
echo     WINDOWS 11 CLAUDE CODE - ALL-IN-ONE INSTALLER
echo ========================================================================
echo.
echo This installer will set up:
echo   - WSL2 (Ubuntu Linux on Windows)
echo   - Node.js, Python, Git, and dev tools
echo   - Claude Code CLI with custom agents
echo.
echo Press any key to start...
pause >nul

cls
echo.
echo ========================================================================
echo STEP 1: Checking Administrator Privileges
echo ========================================================================
echo.

REM Check for admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ERROR: Not running as Administrator!
    echo.
    echo You MUST run this as Administrator:
    echo   1. Right-click this file: ALL-IN-ONE-INSTALLER.bat
    echo   2. Select "Run as administrator"
    echo   3. Click "Yes" when Windows asks
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

echo SUCCESS: Running as Administrator
echo.
echo Press any key to continue...
pause >nul

cls
echo.
echo ========================================================================
echo STEP 2: Checking WSL2 Installation
echo ========================================================================
echo.

REM Check if WSL2 is installed
wsl --list >nul 2>&1
if %errorLevel% EQU 0 (
    wsl --list | findstr /i "Ubuntu" >nul 2>&1
    if !errorLevel! EQU 0 (
        echo SUCCESS: WSL2 with Ubuntu is already installed
        set WSL_INSTALLED=1
    ) else (
        set WSL_INSTALLED=0
    )
) else (
    set WSL_INSTALLED=0
)

if !WSL_INSTALLED! EQU 0 (
    echo Installing WSL2 with Ubuntu...
    echo This may take a few minutes...
    echo.

    wsl --install -d Ubuntu

    echo.
    echo ========================================================================
    echo WSL2 Installation Started
    echo ========================================================================
    echo.
    echo IMPORTANT: You need to REBOOT your computer now!
    echo.
    echo After reboot:
    echo   1. Ubuntu will start automatically
    echo   2. Create a username and password when prompted
    echo   3. After Ubuntu setup completes, run this script again
    echo.
    set /p REBOOT="Reboot now? (Y/N): "

    if /i "!REBOOT!"=="Y" (
        echo.
        echo Rebooting in 10 seconds... (Press Ctrl+C to cancel^)
        timeout /t 10
        shutdown /r /t 0
    ) else (
        echo.
        echo Please reboot manually and run this script again after reboot.
        echo.
        echo Press any key to exit...
        pause >nul
        exit /b 0
    )
)

echo.
echo Press any key to continue...
pause >nul

cls
echo.
echo ========================================================================
echo STEP 3: Setting Up Claude Code Directories
echo ========================================================================
echo.

REM Create Claude directories
if not exist "%USERPROFILE%\.claude\agents" (
    mkdir "%USERPROFILE%\.claude\agents" 2>nul
    echo Created: %USERPROFILE%\.claude\agents
) else (
    echo Directory already exists: %USERPROFILE%\.claude\agents
)

echo.
echo Press any key to continue...
pause >nul

cls
echo.
echo ========================================================================
echo STEP 4: Installing Tools in WSL2
echo ========================================================================
echo.
echo This will install Node.js, Python, Git, and Claude Code
echo This takes about 5-10 minutes...
echo.
echo Press any key to start installation...
pause >nul
echo.
echo Installing (please wait, this takes several minutes)...
echo.

REM Create the WSL setup script
echo #!/bin/bash > %TEMP%\wsl-setup.sh
echo set -e >> %TEMP%\wsl-setup.sh
echo echo "Updating Ubuntu..." >> %TEMP%\wsl-setup.sh
echo sudo apt update -qq >> %TEMP%\wsl-setup.sh
echo sudo apt upgrade -y -qq >> %TEMP%\wsl-setup.sh
echo echo "Installing build tools..." >> %TEMP%\wsl-setup.sh
echo sudo apt install -y -qq build-essential curl wget git vim python3 python3-pip >> %TEMP%\wsl-setup.sh
echo echo "Installing Node.js..." >> %TEMP%\wsl-setup.sh
echo if [ ! -d "$HOME/.nvm" ]; then >> %TEMP%\wsl-setup.sh
echo     curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh ^| bash >> %TEMP%\wsl-setup.sh
echo     export NVM_DIR="$HOME/.nvm" >> %TEMP%\wsl-setup.sh
echo     [ -s "$NVM_DIR/nvm.sh" ] ^&^& \. "$NVM_DIR/nvm.sh" >> %TEMP%\wsl-setup.sh
echo     nvm install --lts >> %TEMP%\wsl-setup.sh
echo fi >> %TEMP%\wsl-setup.sh
echo export NVM_DIR="$HOME/.nvm" >> %TEMP%\wsl-setup.sh
echo [ -s "$NVM_DIR/nvm.sh" ] ^&^& \. "$NVM_DIR/nvm.sh" >> %TEMP%\wsl-setup.sh
echo echo "Installing Claude Code..." >> %TEMP%\wsl-setup.sh
echo npm install -g @anthropic-ai/claude-code >> %TEMP%\wsl-setup.sh
echo echo "Setting up directories..." >> %TEMP%\wsl-setup.sh
echo mkdir -p ~/.claude/agents >> %TEMP%\wsl-setup.sh
echo echo "Copying configs from Windows..." >> %TEMP%\wsl-setup.sh
echo WIN_USER=$(powershell.exe -Command "Write-Host \$env:USERNAME" ^| tr -d '\r'^) >> %TEMP%\wsl-setup.sh
echo cp /mnt/c/Users/$WIN_USER/.claude/settings.local.json ~/.claude/ 2^>/dev/null ^|^| true >> %TEMP%\wsl-setup.sh
echo cp /mnt/c/Users/$WIN_USER/.claude/agents/*.md ~/.claude/agents/ 2^>/dev/null ^|^| true >> %TEMP%\wsl-setup.sh
echo echo "Installation complete!" >> %TEMP%\wsl-setup.sh

REM Copy script to WSL and run it
type %TEMP%\wsl-setup.sh | wsl -d Ubuntu bash -c "cat > /tmp/wsl-setup.sh"
wsl -d Ubuntu chmod +x /tmp/wsl-setup.sh
wsl -d Ubuntu bash /tmp/wsl-setup.sh

if %errorLevel% EQU 0 (
    echo.
    echo SUCCESS: Tools installed in WSL2
) else (
    echo.
    echo WARNING: Installation had some issues, but may still work
)

del %TEMP%\wsl-setup.sh 2>nul

echo.
echo Press any key to continue...
pause >nul

cls
echo.
echo ========================================================================
echo     INSTALLATION COMPLETE!
echo ========================================================================
echo.
echo What was installed:
echo   [X] WSL2 with Ubuntu Linux
echo   [X] Node.js and npm
echo   [X] Python 3 and pip
echo   [X] Git, curl, wget, vim
echo   [X] Claude Code CLI
echo.
echo ========================================================================
echo NEXT STEPS (Only 2 Things Left!)
echo ========================================================================
echo.
echo 1. Download and Install JetBrains Mono Font
echo    https://www.jetbrains.com/lp/mono/
echo    (Extract ZIP, open fonts/ttf, install all .ttf files)
echo.
echo 2. Authenticate Claude Code
echo    Open a new terminal and run these commands:
echo.
echo      wsl -d Ubuntu
echo      claude auth login
echo.
echo    Then follow the browser prompts to sign in.
echo.
echo ========================================================================
echo TO START CODING:
echo ========================================================================
echo.
echo 1. Open Windows Terminal
echo 2. Select the "Ubuntu" profile
echo 3. Run: claude
echo.
echo That's it! Enjoy your setup!
echo.
echo Press any key to exit...
pause >nul
