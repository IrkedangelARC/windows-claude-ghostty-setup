# ============================================================================
# Windows 11 - Ghostty & Claude Code Setup Script
# ============================================================================
# Run this script in PowerShell with Administrator privileges
# ============================================================================

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Ghostty & Claude Code Configuration Setup    " -ForegroundColor Cyan
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
    # Ghostty config directory
    $ghosttyPath = "$env:APPDATA\ghostty"
    New-Item -ItemType Directory -Force -Path $ghosttyPath | Out-Null
    Write-Host "  ✓ Created: $ghosttyPath" -ForegroundColor Gray

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
# Step 2: Copy Ghostty Configuration
# ============================================================================

Write-Host "[2/4] Copying Ghostty configuration..." -ForegroundColor Green

try {
    $ghosttyConfig = ".\ghostty\config"
    if (Test-Path $ghosttyConfig) {
        Copy-Item $ghosttyConfig "$env:APPDATA\ghostty\config" -Force
        Write-Host "  ✓ Ghostty config copied successfully" -ForegroundColor Gray
    } else {
        Write-Host "  ⚠ Ghostty config not found at: $ghosttyConfig" -ForegroundColor Yellow
    }
    Write-Host ""
} catch {
    Write-Host "  ✗ Error copying Ghostty config: $_" -ForegroundColor Red
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
Write-Host "  • Ghostty: $env:APPDATA\ghostty\config" -ForegroundColor White
Write-Host "  • Claude:  $env:USERPROFILE\.claude\" -ForegroundColor White
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Install Ghostty Terminal" -ForegroundColor White
Write-Host "   Download from: https://github.com/ghostty-org/ghostty/releases" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Install JetBrains Mono Font" -ForegroundColor White
Write-Host "   Download from: https://www.jetbrains.com/lp/mono/" -ForegroundColor Gray
Write-Host "   Right-click all .ttf files → Install for all users" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Install Claude Code CLI" -ForegroundColor White
Write-Host "   Run: npm install -g @anthropic-ai/claude-code" -ForegroundColor Gray
Write-Host "   (Requires Node.js: https://nodejs.org/)" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Authenticate Claude Code" -ForegroundColor White
Write-Host "   Run: claude auth login" -ForegroundColor Gray
Write-Host ""
Write-Host "5. Launch Ghostty and run: claude" -ForegroundColor White
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
