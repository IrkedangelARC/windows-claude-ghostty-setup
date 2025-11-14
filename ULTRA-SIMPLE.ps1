# Ultra-Simple Windows Claude Code Installer
# This version has minimal dependencies and maximum visibility

# IMMEDIATE PAUSE - so window doesn't close
Write-Host ""
Write-Host "Windows Claude Code Installer Started..." -ForegroundColor Green
Write-Host "Press any key to continue (this proves the script is running)..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Clear-Host

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "    WINDOWS 11 CLAUDE CODE INSTALLER (ULTRA-SIMPLE VERSION)      " -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Check Admin
Write-Host "Checking Administrator privileges..." -ForegroundColor Yellow
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host ""
    Write-Host "ERROR: Not running as Administrator!" -ForegroundColor Red
    Write-Host ""
    Write-Host "You MUST run this as Administrator." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Two ways to do this:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "METHOD 1 - Use the BAT file:" -ForegroundColor White
    Write-Host "  1. Close this window" -ForegroundColor Gray
    Write-Host "  2. Find the file: RUN-ME.bat" -ForegroundColor Gray
    Write-Host "  3. Right-click RUN-ME.bat" -ForegroundColor Gray
    Write-Host "  4. Select 'Run as administrator'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "METHOD 2 - Manual PowerShell:" -ForegroundColor White
    Write-Host "  1. Search 'PowerShell' in Start menu" -ForegroundColor Gray
    Write-Host "  2. Right-click 'Windows PowerShell'" -ForegroundColor Gray
    Write-Host "  3. Select 'Run as administrator'" -ForegroundColor Gray
    Write-Host "  4. Navigate to where you downloaded these files" -ForegroundColor Gray
    Write-Host "  5. Run: .\ULTRA-SIMPLE.ps1" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "✓ Running as Administrator" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to start installation..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host ""

# WSL2 Installation
Write-Host "━━━ INSTALLING WSL2 (Ubuntu Linux) ━━━" -ForegroundColor Cyan
Write-Host ""

$wslCheck = $null
try {
    $wslCheck = wsl --list 2>&1 | Out-String
} catch {
    $wslCheck = $null
}

if ($wslCheck -match "Ubuntu") {
    Write-Host "✓ WSL2 with Ubuntu is already installed" -ForegroundColor Green
} else {
    Write-Host "Installing WSL2 with Ubuntu Linux..." -ForegroundColor Yellow
    Write-Host "This may take a few minutes..." -ForegroundColor Gray
    Write-Host ""

    try {
        wsl --install -d Ubuntu
        Write-Host ""
        Write-Host "✓ WSL2 installation command executed" -ForegroundColor Green
        Write-Host ""
        Write-Host "⚠️  REBOOT REQUIRED!" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host ""
        Write-Host "What happens next:" -ForegroundColor Cyan
        Write-Host "  1. Your computer needs to reboot" -ForegroundColor White
        Write-Host "  2. After reboot, Ubuntu will auto-start" -ForegroundColor White
        Write-Host "  3. Ubuntu will ask you to create a username and password" -ForegroundColor White
        Write-Host "  4. After that, run this script again to finish setup" -ForegroundColor White
        Write-Host ""

        $doReboot = Read-Host "Reboot now? (y/n)"
        if ($doReboot -eq "y" -or $doReboot -eq "Y") {
            Write-Host ""
            Write-Host "Rebooting in 10 seconds... (Press Ctrl+C to cancel)" -ForegroundColor Yellow
            Start-Sleep -Seconds 10
            Restart-Computer -Force
        } else {
            Write-Host ""
            Write-Host "OK - Please reboot manually." -ForegroundColor Yellow
            Write-Host "After reboot, run this script again." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Press any key to exit..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            exit 0
        }
    } catch {
        Write-Host ""
        Write-Host "✗ Error installing WSL2: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        Write-Host "Try manually in PowerShell (as admin):" -ForegroundColor Yellow
        Write-Host "  wsl --install" -ForegroundColor White
        Write-Host ""
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

Write-Host ""

# Claude Code Setup
Write-Host "━━━ SETTING UP CLAUDE CODE ━━━" -ForegroundColor Cyan
Write-Host ""

$claudeDir = "$env:USERPROFILE\.claude"
$agentsDir = "$claudeDir\agents"

Write-Host "Creating Claude directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
Write-Host "✓ Created: $agentsDir" -ForegroundColor Green

Write-Host ""

# WSL2 Tool Installation
Write-Host "━━━ INSTALLING TOOLS IN WSL2 ━━━" -ForegroundColor Cyan
Write-Host ""
Write-Host "This installs Node.js, Python, Git, and Claude Code" -ForegroundColor Yellow
Write-Host "Takes about 5 minutes..." -ForegroundColor Gray
Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host ""

$wslScript = @'
#!/bin/bash
echo "Updating Ubuntu..."
sudo apt update -qq
sudo apt upgrade -y -qq

echo "Installing tools..."
sudo apt install -y -qq build-essential curl wget git vim python3 python3-pip

echo "Installing Node.js..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo "Setting up directories..."
mkdir -p ~/.claude/agents

echo "Copying configs..."
WIN_USER=$(powershell.exe -Command "Write-Host \$env:USERNAME" | tr -d '\r')
cp /mnt/c/Users/$WIN_USER/.claude/settings.local.json ~/.claude/ 2>/dev/null || echo "No settings to copy"
cp /mnt/c/Users/$WIN_USER/.claude/agents/*.md ~/.claude/agents/ 2>/dev/null || echo "No agents to copy"

echo "DONE!"
'@

try {
    $wslScript | wsl -d Ubuntu bash
    Write-Host ""
    Write-Host "✓ Tools installed in WSL2" -ForegroundColor Green
} catch {
    Write-Host ""
    Write-Host "⚠ WSL2 setup had issues (you can do this manually later)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host ""

# Final Instructions
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "✅ INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""

Write-Host "🎯 NEXT STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Download & Install JetBrains Mono Font" -ForegroundColor White
Write-Host "   https://www.jetbrains.com/lp/mono/" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Authenticate Claude Code" -ForegroundColor White
Write-Host "   Run these commands:" -ForegroundColor Gray
Write-Host "     wsl -d Ubuntu" -ForegroundColor Cyan
Write-Host "     claude auth login" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Start coding!" -ForegroundColor White
Write-Host "   In Windows Terminal (Ubuntu profile):" -ForegroundColor Gray
Write-Host "     claude" -ForegroundColor Cyan
Write-Host ""

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
