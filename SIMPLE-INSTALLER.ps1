<#
.SYNOPSIS
    SIMPLE Windows Claude Code Installer - Works From Any Location

.DESCRIPTION
    This version works no matter where you run it from.
    Just right-click this file and Run with PowerShell.
    The window will stay open so you can see what's happening.

.NOTES
    Author: Claude Code
    Date: 2025-01-12
#>

# Keep PowerShell window open
$ErrorActionPreference = "Continue"

# Clear screen
Clear-Host

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "    SIMPLE WINDOWS CLAUDE CODE INSTALLER                               " -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "⚠️  NOT RUNNING AS ADMINISTRATOR" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "This script needs Administrator privileges to install WSL2." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "How to run as Administrator:" -ForegroundColor Cyan
    Write-Host "  1. Right-click this file: SIMPLE-INSTALLER.ps1" -ForegroundColor White
    Write-Host "  2. Select 'Run with PowerShell' (should prompt for admin)" -ForegroundColor White
    Write-Host ""
    Write-Host "OR:" -ForegroundColor Cyan
    Write-Host "  1. Search for 'PowerShell' in Start menu" -ForegroundColor White
    Write-Host "  2. Right-click 'Windows PowerShell'" -ForegroundColor White
    Write-Host "  3. Select 'Run as administrator'" -ForegroundColor White
    Write-Host "  4. Navigate to this folder and run: .\SIMPLE-INSTALLER.ps1" -ForegroundColor White
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "✓ Running as Administrator" -ForegroundColor Green
Write-Host ""

# Step 1: Check WSL2
Write-Host "━━━ STEP 1: Checking WSL2 Installation ━━━" -ForegroundColor Cyan
Write-Host ""

$wslInstalled = $false
try {
    $wslList = wsl --list 2>&1
    if ($wslList -match "Ubuntu" -or $wslList -match "WslRegisterDistribution") {
        $wslInstalled = $true
    }
} catch {
    $wslInstalled = $false
}

if ($wslInstalled) {
    Write-Host "✓ WSL2 is already installed" -ForegroundColor Green
} else {
    Write-Host "Installing WSL2 with Ubuntu..." -ForegroundColor Yellow
    Write-Host ""

    try {
        wsl --install -d Ubuntu
        Write-Host ""
        Write-Host "✓ WSL2 installation started" -ForegroundColor Green
        Write-Host ""
        Write-Host "⚠️  IMPORTANT: REBOOT REQUIRED!" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "After reboot:" -ForegroundColor Cyan
        Write-Host "  1. Ubuntu will auto-start and ask you to create a username/password" -ForegroundColor White
        Write-Host "  2. After that completes, run this script again" -ForegroundColor White
        Write-Host ""

        $reboot = Read-Host "Reboot now? (y/n)"
        if ($reboot -eq "y") {
            Write-Host ""
            Write-Host "Rebooting in 5 seconds..." -ForegroundColor Yellow
            Start-Sleep -Seconds 5
            Restart-Computer -Force
        } else {
            Write-Host ""
            Write-Host "Please reboot manually and run this script again after reboot." -ForegroundColor Yellow
        }

        Write-Host ""
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 0
    } catch {
        Write-Host "✗ Failed to install WSL2: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Try manually: wsl --install" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

Write-Host ""

# Step 2: Claude Code directories
Write-Host "━━━ STEP 2: Setting Up Claude Code Directories ━━━" -ForegroundColor Cyan
Write-Host ""

$claudeDir = "$env:USERPROFILE\.claude"
$agentsDir = "$claudeDir\agents"

try {
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
    Write-Host "✓ Created $agentsDir" -ForegroundColor Green
} catch {
    Write-Host "⚠ Directory creation failed (may already exist)" -ForegroundColor Yellow
}

Write-Host ""

# Step 3: Find and copy config files (if available)
Write-Host "━━━ STEP 3: Looking for Configuration Files ━━━" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Check for claude settings
$claudeSettings = Join-Path $scriptDir "claude\settings\settings.local.json"
if (Test-Path $claudeSettings) {
    Copy-Item $claudeSettings "$claudeDir\settings.local.json" -Force
    Write-Host "✓ Installed Claude Code settings" -ForegroundColor Green
} else {
    Write-Host "⚠ Claude settings not found (skip)" -ForegroundColor Yellow
}

# Check for claude agents
$claudeAgents = Join-Path $scriptDir "claude\agents"
if (Test-Path "$claudeAgents\*.md") {
    $agents = Get-ChildItem "$claudeAgents\*.md"
    Copy-Item "$claudeAgents\*.md" $agentsDir -Force
    Write-Host "✓ Installed $($agents.Count) Claude agents" -ForegroundColor Green
} else {
    Write-Host "⚠ Claude agents not found (skip)" -ForegroundColor Yellow
}

Write-Host ""

# Step 4: Windows Terminal theme (if available)
Write-Host "━━━ STEP 4: Checking Windows Terminal Theme ━━━" -ForegroundColor Cyan
Write-Host ""

$wtSettings = Join-Path $scriptDir "windows-terminal\settings.json"
$wtPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $wtSettings) {
    if (Test-Path $wtPath) {
        Copy-Item $wtPath "$wtPath.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')" -Force
    }
    Copy-Item $wtSettings $wtPath -Force
    Write-Host "✓ Installed Windows Terminal theme" -ForegroundColor Green
} else {
    Write-Host "⚠ Windows Terminal settings not found (skip)" -ForegroundColor Yellow
}

Write-Host ""

# Step 5: WSL2 Setup
Write-Host "━━━ STEP 5: Installing Tools in WSL2 ━━━" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will take 5-10 minutes. Installing:" -ForegroundColor Yellow
Write-Host "  • Node.js (for Claude Code)" -ForegroundColor Gray
Write-Host "  • Python 3 and pip" -ForegroundColor Gray
Write-Host "  • Git, curl, wget, vim" -ForegroundColor Gray
Write-Host "  • Claude Code CLI" -ForegroundColor Gray
Write-Host ""

$wslScript = @'
#!/bin/bash
set -e

echo "━━━ Updating Ubuntu ━━━"
sudo apt update -qq
sudo apt upgrade -y -qq

echo ""
echo "━━━ Installing dev tools ━━━"
sudo apt install -y -qq build-essential curl wget git vim python3 python3-pip python3-venv

echo ""
echo "━━━ Installing Node.js ━━━"
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
else
    echo "✓ nvm already installed"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo ""
echo "━━━ Installing Claude Code ━━━"
npm install -g @anthropic-ai/claude-code

echo ""
echo "━━━ Setting up directories ━━━"
mkdir -p ~/.claude/agents

echo ""
echo "━━━ Copying configs from Windows ━━━"
WIN_USER=$(powershell.exe -Command "Write-Host \$env:USERNAME" | tr -d '\r')
WIN_CLAUDE_PATH="/mnt/c/Users/$WIN_USER/.claude"

if [ -f "$WIN_CLAUDE_PATH/settings.local.json" ]; then
    cp "$WIN_CLAUDE_PATH/settings.local.json" ~/.claude/
    echo "✓ Copied Claude settings"
fi

if [ -d "$WIN_CLAUDE_PATH/agents" ]; then
    cp "$WIN_CLAUDE_PATH/agents"/*.md ~/.claude/agents/ 2>/dev/null || true
    AGENT_COUNT=$(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)
    echo "✓ Copied $AGENT_COUNT Claude agents"
fi

echo ""
echo "✅ WSL2 setup complete!"
'@

$wslScriptPath = "$env:TEMP\wsl-setup-$(Get-Date -Format 'yyyyMMddHHmmss').sh"
$wslScript | Out-File -FilePath $wslScriptPath -Encoding utf8 -NoNewline

try {
    # Copy to WSL
    $wslTempPath = "/tmp/wsl-setup.sh"
    Get-Content $wslScriptPath | wsl -d Ubuntu bash -c "cat > $wslTempPath"
    wsl -d Ubuntu chmod +x $wslTempPath

    # Run setup
    Write-Host "Installing (this may take 5-10 minutes)..." -ForegroundColor Yellow
    wsl -d Ubuntu bash $wslTempPath

    Write-Host ""
    Write-Host "✓ WSL2 tools installed successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ WSL2 setup encountered an error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "You can run setup manually later:" -ForegroundColor Yellow
    Write-Host "  wsl -d Ubuntu" -ForegroundColor White
    Write-Host "  Then inside Ubuntu, run the commands to install tools" -ForegroundColor White
}

# Clean up
Remove-Item $wslScriptPath -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host ""

# Final Instructions
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "✅ INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""

Write-Host "📝 Manual Steps (Only 2!):" -ForegroundColor Yellow
Write-Host ""
Write-Host "1️⃣  Install JetBrains Mono Font:" -ForegroundColor Yellow
Write-Host "   Download: https://www.jetbrains.com/lp/mono/" -ForegroundColor White
Write-Host "   Extract ZIP → Open fonts/ttf folder" -ForegroundColor White
Write-Host "   Select all .ttf files → Right-click → Install for all users" -ForegroundColor White
Write-Host ""

Write-Host "2️⃣  Authenticate Claude Code:" -ForegroundColor Yellow
Write-Host "   Run these commands in order:" -ForegroundColor White
Write-Host ""
Write-Host "   > wsl -d Ubuntu" -ForegroundColor Cyan
Write-Host "   > claude auth login" -ForegroundColor Cyan
Write-Host ""
Write-Host "   Follow the browser prompts to sign in" -ForegroundColor White
Write-Host ""

Write-Host "🚀 To Start Coding:" -ForegroundColor Cyan
Write-Host "   1. Open Windows Terminal" -ForegroundColor White
Write-Host "   2. Select 'Ubuntu' profile" -ForegroundColor White
Write-Host "   3. Run: claude" -ForegroundColor Cyan
Write-Host ""

Write-Host "That's it! Enjoy your setup! 🎉" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
