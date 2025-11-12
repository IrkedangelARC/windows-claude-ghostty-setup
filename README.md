# Windows 11 Setup - Windows Terminal & Claude Code

This package contains all configuration files needed to replicate your macOS terminal and Claude Code setup on Windows 11 using **Windows Terminal** with the Catppuccin Mocha theme.

## Prerequisites

Before starting, ensure you have:
- **Windows 11** with PowerShell 5.1 or later (or PowerShell 7+)
- **Administrator access** (you mentioned you have admin PowerShell running)
- **Internet connection** for downloading tools

---

## Part 1: Configure Windows Terminal

### Step 1: Verify Windows Terminal is Installed
Windows Terminal comes pre-installed on Windows 11. Verify by searching for "Windows Terminal" in the Start menu.

If not installed, download from Microsoft Store:
https://www.microsoft.com/store/productId/9N0DX20HK701

### Step 2: Install JetBrains Mono Font
The config uses JetBrains Mono font. Install it:
1. Download from: https://www.jetbrains.com/lp/mono/
2. Extract the ZIP file
3. Open the `fonts/ttf` folder
4. Select all `.ttf` files, right-click, and choose "Install for all users"

### Step 3: Configure Windows Terminal
1. Copy the settings file:
   ```powershell
   Copy-Item ".\windows-terminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
   ```

2. Launch Windows Terminal - it should now use the Catppuccin Mocha theme!

**Note:** This will replace your existing Windows Terminal settings. If you have custom configurations, back them up first.

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

### Test Windows Terminal
1. Launch Windows Terminal
2. Verify the Catppuccin Mocha theme is applied (dark background, purple/blue accents)
3. Check that JetBrains Mono font rendering looks correct
4. Test transparency (background should be slightly transparent)
5. Select text - it should highlight with purple color

### Test Claude Code
1. Open Windows Terminal
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
4. **ghostty-config-specialist** - Configures terminal settings (works for Windows Terminal too!)
5. **gworkspace-python-dev** - Google Workspace API development
6. **arcninja** - Project-specific automation and workflows

---

## Quick Setup Script

### IMPORTANT: Navigate to Folder and Enable Scripts First

1. **Open PowerShell as Administrator**
   - Search for "PowerShell" in Start menu
   - Right-click "Windows PowerShell"
   - Select "Run as Administrator"

2. **Navigate to the setup folder:**
   ```powershell
   # If you extracted to Downloads:
   cd "$env:USERPROFILE\Downloads\windows-claude-ghostty-setup"

   # Or if on USB drive (change D: to your drive letter):
   cd "D:\windows-claude-ghostty-setup"

   # Verify you're in the right place:
   Get-ChildItem  # Should show setup.ps1 and other files
   ```

3. **Enable script execution (only needed once):**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

4. **Run the setup script:**
   ```powershell
   .\setup.ps1
   ```

### Script Contents

For convenience, here's a PowerShell script that does everything:

```powershell
# Run this in Administrator PowerShell

# Create directories
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\agents"

# Copy Windows Terminal settings
Copy-Item ".\windows-terminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force

# Copy Claude settings
Copy-Item ".\claude\settings\settings.local.json" "$env:USERPROFILE\.claude\settings.local.json"

# Copy Claude agents
Copy-Item ".\claude\agents\*.md" "$env:USERPROFILE\.claude\agents\"

Write-Host "✓ Configuration files copied successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Install JetBrains Mono font from: https://www.jetbrains.com/lp/mono/"
Write-Host "2. Install Claude Code: npm install -g @anthropic-ai/claude-code"
Write-Host "3. Authenticate: claude auth login"
Write-Host "4. Restart Windows Terminal to see the new theme"
```

Save this as `setup.ps1` and run it!

---

## Troubleshooting

### Windows Terminal Issues

**Problem:** Settings not applying
- **Solution:** Make sure Windows Terminal is completely closed (check Task Manager), then relaunch

**Problem:** Font not rendering correctly
- **Solution:** Ensure JetBrains Mono is installed for all users and restart Windows Terminal

**Problem:** Theme colors wrong
- **Solution:** Verify settings.json was copied to the correct location:
  `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`

**Problem:** Transparency not working
- **Solution:** Acrylic effects require Windows 11. On Windows 10, set `"useAcrylic": false` in settings.json

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
%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\
└── settings.json                   # Windows Terminal configuration

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

### Adjust for Your Preferences

1. **Font Size**: Edit Windows Terminal settings.json:
   ```json
   "font": {
     "face": "JetBrains Mono",
     "size": 14  // Adjust as needed
   }
   ```

2. **Opacity**: Change background transparency:
   ```json
   "opacity": 90,  // 0-100, where 100 is opaque
   "acrylicOpacity": 0.90
   ```

3. **Different Shell**: Change default profile to use WSL, cmd, or PowerShell 7

4. **Keybindings**: Customize shortcuts in the "actions" section of settings.json

---

## Support & Resources

- **Windows Terminal Documentation**: https://docs.microsoft.com/windows/terminal/
- **Claude Code Documentation**: https://docs.claude.com/claude-code
- **JetBrains Mono Font**: https://www.jetbrains.com/lp/mono/
- **Catppuccin Theme**: https://github.com/catppuccin/windows-terminal

---

## Notes

- This setup uses Windows Terminal instead of Ghostty (which doesn't have a Windows version)
- Windows Terminal is pre-installed on Windows 11 - no separate download needed!
- The Catppuccin Mocha theme provides the same beautiful dark theme as Ghostty
- All custom agents are cross-platform and work identically on Windows
- Make sure to run PowerShell as Administrator for initial setup

Enjoy your Windows setup! 🚀
