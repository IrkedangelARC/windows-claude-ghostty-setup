# MEGA-INSTALLER - One Command Setup

## TL;DR - Zero Typing Installation

### Step 1: Download
Go to: **https://drive.google.com/drive/folders/1wIpBD6Ch9qNdXDkMqzzBvGnmn4ZZK8WD**

Download: `MEGA-INSTALLER.ps1`

### Step 2: Run
Right-click `MEGA-INSTALLER.ps1` → **Run with PowerShell (Administrator)**

### Step 3: Done!
Walk away for 15 minutes. Come back to a fully configured machine.

---

## What It Does

This **ONE script** installs and configures EVERYTHING:

✅ **WSL2 (Ubuntu Linux)** - Full Linux environment on Windows
✅ **Node.js & npm** - JavaScript runtime
✅ **Python 3** - Latest Python with pip and venv
✅ **Git** - Version control
✅ **Claude Code CLI** - AI coding assistant
✅ **Windows Terminal** - Beautiful Catppuccin Mocha theme
✅ **All dev tools** - build-essential, curl, wget, vim, tmux
✅ **Your Mac configs** - All settings automatically copied
✅ **6 Custom Claude agents** - Ready to use immediately

---

## Installation Time

- **Active time:** 2 minutes (download + run script)
- **Total time:** 15 minutes (mostly automated installations)
- **Your effort:** Practically zero

---

## After Installation

### Quick Start:
```powershell
# Open Windows Terminal
# Select "Ubuntu" profile
claude auth login
claude
```

### Test It:
```
Hello Claude! List my custom agents.
```

You should see:
- session-documenter
- gmail-assistant
- av-integration-engineer
- ghostty-config-specialist
- gworkspace-python-dev
- arcninja

---

## Manual Steps (Only 2!)

The script handles 99% of setup. You only need to:

### 1. Install JetBrains Mono Font
Download: https://www.jetbrains.com/lp/mono/
Extract → Open fonts/ttf → Select all → Right-click → "Install for all users"

### 2. Authenticate Claude Code
```bash
wsl -d Ubuntu
claude auth login
```

That's it!

---

## What You Get

### WSL2 + Ubuntu
- Real Linux kernel running on Windows
- All Unix tools (grep, sed, awk, ssh, etc.)
- Native Python development (no Windows quirks!)
- Your Mac bash configs work as-is

### Windows Terminal
- Beautiful Catppuccin Mocha theme
- JetBrains Mono font
- 95% opacity with blur effects
- Multiple profiles (PowerShell, Ubuntu, etc.)

### Claude Code
- Pre-configured permissions (no prompts)
- 6 specialized custom agents
- Identical to your Mac setup

---

## Troubleshooting

### "Script can't be loaded"
Run this first:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Reboot Required"
WSL2 needs a reboot. After reboot, run the script again—it will continue where it left off.

### Still Having Issues?
Check the full README.md in the deployment folder for detailed troubleshooting.

---

## Why This Works

Traditional setup requires:
- ❌ Installing 10+ tools manually
- ❌ Copying configs one by one
- ❌ Figuring out Windows vs Mac differences
- ❌ Hours of dependency hunting
- ❌ Tons of typing

MEGA-INSTALLER:
- ✅ ONE command
- ✅ 15 minutes total
- ✅ Everything automated
- ✅ Zero thinking required

---

## Google Drive Folder

All files available at:
**https://drive.google.com/drive/folders/1wIpBD6Ch9qNdXDkMqzzBvGnmn4ZZK8WD**

Contents:
- `MEGA-INSTALLER.ps1` - The one-command installer
- `windows-claude-ghostty-setup.zip` - Complete package
- `README.md` - Full documentation
- `QUICK_START.md` - Fast reference
- `START_HERE.md` - Original instructions

---

## For Future Machines

1. Save the Google Drive link
2. Download MEGA-INSTALLER.ps1
3. Run it
4. Done

No more hours of setup. No more dependency hunting. No more typing commands.

**One script. One command. Zero effort.**

---

**Questions?** Check README.md in the deployment folder for complete documentation.
