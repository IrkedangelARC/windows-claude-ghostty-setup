# Windows 11 Setup - Ghostty Terminal & Claude Code

This package contains all configuration files needed to replicate your macOS Ghostty and Claude Code setup on Windows 11.

## Prerequisites

Before starting, ensure you have:
- **Windows 11** with PowerShell 5.1 or later (or PowerShell 7+)
- **Administrator access** (you mentioned you have admin PowerShell running)
- **Internet connection** for downloading tools

---

## Part 1: Install Ghostty Terminal

### Step 1: Install Ghostty
1. Visit the Ghostty releases page: https://github.com/ghostty-org/ghostty/releases
2. Download the latest Windows installer (`.exe` or `.msi`)
3. Run the installer with administrator privileges
4. Follow the installation wizard

### Step 2: Install JetBrains Mono Font
The config uses JetBrains Mono font. Install it:
1. Download from: https://www.jetbrains.com/lp/mono/
2. Extract the ZIP file
3. Open the `fonts/ttf` folder
4. Select all `.ttf` files, right-click, and choose "Install for all users"

### Step 3: Configure Ghostty
1. Create the Ghostty config directory:
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:APPDATA\ghostty"
   ```

2. Copy the config file:
   ```powershell
   Copy-Item ".\ghostty\config" "$env:APPDATA\ghostty\config"
   ```

3. Launch Ghostty - it should now use your custom configuration!

---

## Part 2: Install Claude Code

### Step 1: Install Node.js (if not already installed)
Claude Code requires Node.js:
1. Download from: https://nodejs.org/ (LTS version recommended)
2. Run the installer
3. Verify installation:
   ```powershell
   node --version
   npm --version
   ```

### Step 2: Install Claude Code CLI
```powershell
npm install -g @anthropic-ai/claude-code
```

### Step 3: Verify Installation
```powershell
claude --version
```

### Step 4: Authenticate Claude Code
```powershell
claude auth login
```
Follow the prompts to authenticate with your Anthropic account.

---

## Part 3: Configure Claude Code

### Step 1: Create Claude Configuration Directory
```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude"
```

### Step 2: Copy Settings
```powershell
Copy-Item ".\claude\settings\settings.local.json" "$env:USERPROFILE\.claude\settings.local.json"
```

### Step 3: Copy Custom Agents
```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\agents"
Copy-Item ".\claude\agents\*.md" "$env:USERPROFILE\.claude\agents\"
```

### Step 4: Verify Agent Installation
```powershell
Get-ChildItem "$env:USERPROFILE\.claude\agents"
```

You should see:
- `arcninja.md`
- `av-integration-engineer.md`
- `ghostty-config-specialist.md`
- `gmail-assistant.md`
- `gworkspace-python-dev.md`
- `session-documenter.md`

---

## Part 4: First Run & Testing

### Test Ghostty
1. Launch Ghostty
2. Verify the theme (Catppuccin Mocha) is applied
3. Check that font rendering looks correct
4. Test clipboard features (select text - it should auto-copy)

### Test Claude Code
1. Open Ghostty terminal
2. Navigate to your projects directory:
   ```powershell
   cd $env:USERPROFILE\Projects
   ```
3. Start Claude Code:
   ```powershell
   claude
   ```
4. Test a simple command:
   ```
   Hello! Can you list the custom agents available?
   ```

### Available Custom Agents

After setup, these specialized agents will be available:

1. **session-documenter** - Creates comprehensive session documentation
2. **gmail-assistant** - Helps with Gmail operations and email management
3. **av-integration-engineer** - Technical AV programming and API integration
4. **ghostty-config-specialist** - Configures Ghostty terminal settings
5. **gworkspace-python-dev** - Google Workspace API development
6. **arcninja** - Project-specific automation and workflows

---

## Quick Setup Script

For convenience, here's a PowerShell script that does everything:

```powershell
# Run this in Administrator PowerShell

# Create directories
New-Item -ItemType Directory -Force -Path "$env:APPDATA\ghostty"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\agents"

# Copy Ghostty config
Copy-Item ".\ghostty\config" "$env:APPDATA\ghostty\config"

# Copy Claude settings
Copy-Item ".\claude\settings\settings.local.json" "$env:USERPROFILE\.claude\settings.local.json"

# Copy Claude agents
Copy-Item ".\claude\agents\*.md" "$env:USERPROFILE\.claude\agents\"

Write-Host "✓ Configuration files copied successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Install Ghostty from: https://github.com/ghostty-org/ghostty/releases"
Write-Host "2. Install JetBrains Mono font from: https://www.jetbrains.com/lp/mono/"
Write-Host "3. Install Claude Code: npm install -g @anthropic-ai/claude-code"
Write-Host "4. Authenticate: claude auth login"
```

Save this as `setup.ps1` and run it!

---

## Troubleshooting

### Ghostty Issues

**Problem:** Font not rendering correctly
- **Solution:** Ensure JetBrains Mono is installed for all users

**Problem:** Config not loading
- **Solution:** Verify config file location: `%APPDATA%\ghostty\config`

**Problem:** Theme colors wrong
- **Solution:** Check that Catppuccin Mocha theme is supported in your Ghostty version

### Claude Code Issues

**Problem:** `claude` command not found
- **Solution:** Restart PowerShell after installing, or add to PATH manually

**Problem:** Agents not loading
- **Solution:** Verify files are in `%USERPROFILE%\.claude\agents\` with `.md` extension

**Problem:** Permission errors
- **Solution:** Run PowerShell as Administrator

---

## File Structure

After setup, your files should be organized as:

```
%APPDATA%\ghostty\
└── config                          # Ghostty terminal configuration

%USERPROFILE%\.claude\
├── settings.local.json             # Claude Code permissions
└── agents\                         # Custom Claude agents
    ├── arcninja.md
    ├── av-integration-engineer.md
    ├── ghostty-config-specialist.md
    ├── gmail-assistant.md
    ├── gworkspace-python-dev.md
    └── session-documenter.md
```

---

## Customization Tips

### Adjust for Windows Specifics

1. **Shell Integration**: Edit Ghostty config to use your preferred shell:
   ```
   command = powershell.exe
   # or
   command = wsl.exe  # for WSL
   ```

2. **Font Size**: Adjust based on your display:
   ```
   font-size = 19  # Increase/decrease as needed
   ```

3. **Opacity**: Change background transparency:
   ```
   background-opacity = 0.95  # 0.0 (transparent) to 1.0 (opaque)
   ```

---

## Support & Resources

- **Ghostty Documentation**: https://ghostty.org/docs
- **Claude Code Documentation**: https://docs.claude.com/claude-code
- **JetBrains Mono Font**: https://www.jetbrains.com/lp/mono/
- **Catppuccin Theme**: https://github.com/catppuccin/catppuccin

---

## Notes

- This setup replicates your macOS configuration as closely as possible
- Some features (like tmux auto-start) are macOS-specific and have been adjusted for Windows
- The custom agents are cross-platform and should work identically on Windows
- Make sure to run PowerShell as Administrator for initial setup

Enjoy your Windows setup! 🚀
