# Quick Start Guide

## TL;DR - Get Up and Running Fast

### Prerequisites
- Windows 11
- PowerShell (Administrator)
- Internet connection

### 5-Minute Setup

1. **Run the setup script:**
   ```powershell
   .\setup.ps1
   ```

2. **Install Ghostty:**
   - Download: https://github.com/ghostty-org/ghostty/releases
   - Run installer

3. **Install JetBrains Mono Font:**
   - Download: https://www.jetbrains.com/lp/mono/
   - Install all .ttf files (right-click → Install for all users)

4. **Install Claude Code:**
   ```powershell
   npm install -g @anthropic-ai/claude-code
   claude auth login
   ```

5. **Launch and Test:**
   ```powershell
   ghostty
   claude
   ```

### That's it! 🎉

For detailed information, see [README.md](README.md)

For first-time Claude Code usage, see [CLAUDE_INITIALIZATION_PROMPT.md](CLAUDE_INITIALIZATION_PROMPT.md)

---

## What You Get

### Ghostty Terminal
- Catppuccin Mocha theme (dark, beautiful)
- JetBrains Mono font (coding-optimized)
- Auto-copy on select
- Semi-transparent background with blur
- Optimized for productivity

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

**Q: Ghostty config not applying**

A: Verify file location: `%APPDATA%\ghostty\config`

**Q: Claude agents not found**

A: Check: `%USERPROFILE%\.claude\agents\` contains .md files

---

## Support

Having issues? Check [README.md](README.md) for detailed troubleshooting or open an issue on GitHub.
