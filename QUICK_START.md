# Quick Start Guide

## TL;DR - Get Up and Running Fast

### Prerequisites
- Windows 11
- PowerShell (Administrator)
- Internet connection

### 5-Minute Setup

1. **Navigate to the setup folder and run:**
   ```powershell
   # Navigate to the setup folder (adjust path as needed)
   cd "C:\Users\YourUsername\Downloads\windows-claude-ghostty-setup"

   # Or if on USB drive:
   # cd "D:\windows-claude-ghostty-setup"

   # Enable script execution (only needed once)
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

   # Run the setup script
   .\setup.ps1
   ```

2. **Install JetBrains Mono Font:**
   - Download: https://www.jetbrains.com/lp/mono/
   - Install all .ttf files (right-click → Install for all users)

3. **Install Claude Code:**
   ```powershell
   npm install -g @anthropic-ai/claude-code
   claude auth login
   ```

4. **Launch and Test:**
   ```powershell
   # Close and reopen Windows Terminal
   claude
   ```

### That's it! 🎉

For detailed information, see [README.md](README.md)

For first-time Claude Code usage, see [CLAUDE_INITIALIZATION_PROMPT.md](CLAUDE_INITIALIZATION_PROMPT.md)

---

## What You Get

### Windows Terminal
- Catppuccin Mocha theme (dark, beautiful)
- JetBrains Mono font (coding-optimized)
- Semi-transparent background with acrylic blur
- Copy-on-select clipboard integration
- Optimized for productivity

**Note:** Windows Terminal comes pre-installed on Windows 11!

### Claude Code
- Pre-configured permissions (no constant prompts)
- 6 custom specialized agents:
  - session-documenter
  - gmail-assistant
  - av-integration-engineer
  - ghostty-config-specialist
  - gworkspace-python-dev
  - arcninja

---

## Troubleshooting

**Q: "setup.ps1 cannot be loaded because running scripts is disabled"**

A: Run this first:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Q: Windows Terminal theme not applying**

A: Close Windows Terminal completely (check Task Manager), then reopen it

**Q: Claude agents not found**

A: Check: `%USERPROFILE%\.claude\agents\` contains .md files

---

## Important Notes

- **Windows Terminal** is used instead of Ghostty (Ghostty doesn't have a Windows version)
- Windows Terminal is already installed on Windows 11 - nothing to download!
- The Catppuccin Mocha theme looks just as beautiful as the Ghostty version
- All custom agents work identically on Windows

---

## Support

Having issues? Check [README.md](README.md) for detailed troubleshooting or open an issue on GitHub.
