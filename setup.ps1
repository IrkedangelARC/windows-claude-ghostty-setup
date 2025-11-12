# ============================================================================
# Windows 11 - Windows Terminal & Claude Code Setup Script
# ============================================================================
# Run this script in PowerShell with Administrator privileges
# ============================================================================

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Windows Terminal & Claude Code Setup         " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if running as Administrator
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check for admin privileges
if (-not (Test-Administrator)) {
    Write-Host "⚠ WARNING: This script should be run as Administrator" -ForegroundColor Yellow
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne 'y') {
        exit
    }
}

# ============================================================================
# Step 1: Create Directory Structure
# ============================================================================

Write-Host "[1/4] Creating directory structure..." -ForegroundColor Green

try {
    # Claude config directories
    $claudePath = "$env:USERPROFILE\.claude"
    $claudeAgentsPath = "$claudePath\agents"
    New-Item -ItemType Directory -Force -Path $claudePath | Out-Null
    New-Item -ItemType Directory -Force -Path $claudeAgentsPath | Out-Null
    Write-Host "  ✓ Created: $claudePath" -ForegroundColor Gray
    Write-Host "  ✓ Created: $claudeAgentsPath" -ForegroundColor Gray

    Write-Host ""
} catch {
    Write-Host "  ✗ Error creating directories: $_" -ForegroundColor Red
    exit 1
}

# ============================================================================
# Step 2: Copy Windows Terminal Configuration
# ============================================================================

Write-Host "[2/4] Copying Windows Terminal configuration..." -ForegroundColor Green

try {
    $wtSettingsSource = ".\windows-terminal\settings.json"
    $wtSettingsDest = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

    if (Test-Path $wtSettingsSource) {
        # Check if Windows Terminal is installed
        $wtPackagePath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"

        if (Test-Path $wtPackagePath) {
            # Backup existing settings if they exist
            if (Test-Path $wtSettingsDest) {
                $backupPath = "$wtSettingsDest.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
                Copy-Item $wtSettingsDest $backupPath -Force
                Write-Host "  ✓ Backed up existing settings to: $(Split-Path $backupPath -Leaf)" -ForegroundColor Gray
            }

            Copy-Item $wtSettingsSource $wtSettingsDest -Force
            Write-Host "  ✓ Windows Terminal config copied successfully" -ForegroundColor Gray
            Write-Host "    Close and reopen Windows Terminal to see the changes" -ForegroundColor Yellow
        } else {
            Write-Host "  ⚠ Windows Terminal not found" -ForegroundColor Yellow
            Write-Host "    Install from Microsoft Store: https://aka.ms/terminal" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ⚠ Windows Terminal config not found at: $wtSettingsSource" -ForegroundColor Yellow
    }
    Write-Host ""
} catch {
    Write-Host "  ✗ Error copying Windows Terminal config: $_" -ForegroundColor Red
}

# ============================================================================
# Step 3: Copy Claude Settings
# ============================================================================

Write-Host "[3/4] Copying Claude Code settings..." -ForegroundColor Green

try {
    $claudeSettings = ".\claude\settings\settings.local.json"
    if (Test-Path $claudeSettings) {
        Copy-Item $claudeSettings "$env:USERPROFILE\.claude\settings.local.json" -Force
        Write-Host "  ✓ Claude settings copied successfully" -ForegroundColor Gray
    } else {
        Write-Host "  ⚠ Claude settings not found at: $claudeSettings" -ForegroundColor Yellow
    }
    Write-Host ""
} catch {
    Write-Host "  ✗ Error copying Claude settings: $_" -ForegroundColor Red
}

# ============================================================================
# Step 4: Copy Custom Agents
# ============================================================================

Write-Host "[4/4] Copying custom Claude agents..." -ForegroundColor Green

try {
    $agentsPath = ".\claude\agents"
    if (Test-Path $agentsPath) {
        $agentFiles = Get-ChildItem "$agentsPath\*.md"
        $agentCount = 0

        foreach ($agent in $agentFiles) {
            Copy-Item $agent.FullName "$env:USERPROFILE\.claude\agents\" -Force
            Write-Host "  ✓ Copied: $($agent.Name)" -ForegroundColor Gray
            $agentCount++
        }

        Write-Host ""
        Write-Host "  Total agents installed: $agentCount" -ForegroundColor Cyan
    } else {
        Write-Host "  ⚠ Agents directory not found at: $agentsPath" -ForegroundColor Yellow
    }
    Write-Host ""
} catch {
    Write-Host "  ✗ Error copying agents: $_" -ForegroundColor Red
}

# ============================================================================
# Summary & Next Steps
# ============================================================================

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!                              " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Configuration files have been copied to:" -ForegroundColor Green
Write-Host "  • Windows Terminal: $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -ForegroundColor White
Write-Host "  • Claude:  $env:USERPROFILE\.claude\" -ForegroundColor White
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Install JetBrains Mono Font" -ForegroundColor White
Write-Host "   Download from: https://www.jetbrains.com/lp/mono/" -ForegroundColor Gray
Write-Host "   Right-click all .ttf files → Install for all users" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Install Claude Code CLI" -ForegroundColor White
Write-Host "   Run: npm install -g @anthropic-ai/claude-code" -ForegroundColor Gray
Write-Host "   (Requires Node.js: https://nodejs.org/)" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Authenticate Claude Code" -ForegroundColor White
Write-Host "   Run: claude auth login" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Restart Windows Terminal" -ForegroundColor White
Write-Host "   Close all Windows Terminal windows and reopen to see the new theme" -ForegroundColor Gray
Write-Host ""
Write-Host "5. Launch Claude Code" -ForegroundColor White
Write-Host "   Open Windows Terminal and run: claude" -ForegroundColor Gray
Write-Host ""

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  For detailed instructions, see README.md     " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Optional: Open README
$openReadme = Read-Host "Open README.md now? (y/n)"
if ($openReadme -eq 'y') {
    if (Test-Path ".\README.md") {
        Start-Process ".\README.md"
    }
}

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
