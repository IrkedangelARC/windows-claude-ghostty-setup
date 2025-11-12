# START HERE - Windows Terminal & Claude Code Setup

## Step-by-Step Instructions

### Step 1: Open PowerShell as Administrator

1. Press `Windows Key` (on your keyboard)
2. Type: `powershell`
3. Right-click on "Windows PowerShell"
4. Click "Run as Administrator"
5. Click "Yes" if prompted by User Account Control

---

### Step 2: Navigate to This Folder

**If you extracted to Downloads:**
```powershell
cd "$env:USERPROFILE\Downloads\windows-claude-ghostty-setup"
```

**If you copied from USB to Desktop:**
```powershell
cd "$env:USERPROFILE\Desktop\windows-claude-ghostty-setup"
```

**If you're running directly from USB drive:**
```powershell
# Replace D: with your USB drive letter (might be E: or F:)
cd "D:\windows-claude-ghostty-setup"
```

**Verify you're in the right place:**
```powershell
Get-ChildItem
```
You should see files like: setup.ps1, README.md, QUICK_START.md

---

### Step 3: Enable PowerShell Scripts (One-Time Setup)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

When prompted, type `Y` and press Enter.

---

### Step 4: Run the Setup Script

```powershell
.\setup.ps1
```

The script will:
- Create necessary directories
- Copy Windows Terminal settings (with Catppuccin Mocha theme)
- Copy Claude Code settings
- Copy 6 custom Claude agents

---

### Step 5: Install JetBrains Mono Font

1. Download from: https://www.jetbrains.com/lp/mono/
2. Extract the ZIP file
3. Open the `fonts/ttf` folder
4. Select all `.ttf` files
5. Right-click → "Install for all users"

---

### Step 6: Install Node.js (if not already installed)

1. Download from: https://nodejs.org/ (get the LTS version)
2. Run the installer
3. Follow the prompts (use default settings)
4. Restart PowerShell after installation

---

### Step 7: Install Claude Code

In PowerShell, run:
```powershell
npm install -g @anthropic-ai/claude-code
```

Then authenticate:
```powershell
claude auth login
```

Follow the browser prompts to sign in.

---

### Step 8: Restart Windows Terminal

1. Close ALL Windows Terminal windows
2. Check Task Manager (Ctrl+Shift+Esc) and end any "Windows Terminal" processes
3. Reopen Windows Terminal

You should now see the beautiful Catppuccin Mocha theme! 🎨

---

### Step 9: Test Claude Code

In Windows Terminal:
```powershell
claude
```

Try asking:
```
Hello! Can you list the custom agents available?
```

You should see 6 custom agents:
- session-documenter
- gmail-assistant
- av-integration-engineer
- ghostty-config-specialist
- gworkspace-python-dev
- arcninja

---

## Troubleshooting

**Script won't run?** See TROUBLESHOOTING.md

**Quick questions?** See QUICK_START.md

**Detailed info?** See README.md

---

## That's It! 🚀

Your Windows Terminal is now configured with:
- ✅ Catppuccin Mocha theme (dark, beautiful)
- ✅ JetBrains Mono font
- ✅ 95% opacity with blur effects
- ✅ Copy-on-select enabled

Your Claude Code has:
- ✅ Pre-approved permissions (no constant prompts)
- ✅ 6 specialized custom agents

**Enjoy your setup!**
