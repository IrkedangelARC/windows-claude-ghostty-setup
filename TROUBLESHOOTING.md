# Troubleshooting Guide - Windows Terminal & Claude Code Setup

## PowerShell Script Execution Issues

### Error: "cannot be loaded because running scripts is disabled"

This is a Windows security feature that prevents PowerShell scripts from running by default.

**Solution 1: Enable for Current User (Recommended)**
1. Navigate to the setup folder first:
   ```powershell
   cd "C:\Users\YourUsername\Downloads\windows-claude-ghostty-setup"
   # Or wherever you extracted/copied the files
   ```

2. Enable scripts:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. Run the setup script:
   ```powershell
   .\setup.ps1
   ```

**Solution 2: Run Script with Bypass (One-time)**
```powershell
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

**Solution 3: Manual Setup (If scripts still won't run)**

Run these commands manually in PowerShell (Admin):

```powershell
# Create directories
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\agents"

# Copy Windows Terminal settings
Copy-Item ".\windows-terminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force

# Copy Claude settings
Copy-Item ".\claude\settings\settings.local.json" "$env:USERPROFILE\.claude\settings.local.json"

# Copy Claude agents
Copy-Item ".\claude\agents\*.md" "$env:USERPROFILE\.claude\agents\"

Write-Host "✓ Setup complete! Close and reopen Windows Terminal, then run: claude"
```

---

## Windows Terminal Issues

### Theme Not Applying

**Problem:** Windows Terminal still shows default colors after setup

**Solutions:**
1. Close ALL Windows Terminal windows completely
   - Check Task Manager (Ctrl+Shift+Esc) → End all "Windows Terminal" tasks
2. Relaunch Windows Terminal
3. If still not working, verify settings file location:
   ```powershell
   Get-Content "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" | Select-String "Catppuccin"
   ```
   You should see "Catppuccin Mocha" in the output

### Font Not Rendering

**Problem:** JetBrains Mono font not displaying

**Solutions:**
1. Verify font is installed:
   - Open Settings → Personalization → Fonts
   - Search for "JetBrains Mono"
2. If not found, reinstall:
   - Download: https://www.jetbrains.com/lp/mono/
   - Right-click all .ttf files → "Install for all users"
3. Restart Windows Terminal

### Transparency Not Working

**Problem:** Background is solid, not transparent

**Solutions:**
1. Windows 11 only - Acrylic effects require Windows 11
2. Check Windows Settings:
   - Settings → Personalization → Colors
   - Enable "Transparency effects"
3. If on Windows 10, edit settings.json:
   ```json
   "useAcrylic": false,
   "opacity": 95
   ```

### Settings File Backup

**Problem:** Settings were overwritten and I want my old config back

**Solution:**
The setup script creates automatic backups. Look for:
```powershell
Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json.backup-*"
```
Restore a backup:
```powershell
Copy-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json.backup-YYYYMMDD-HHMMSS" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
```

---

## Claude Code Issues

### Command Not Found

**Problem:** `claude` command not recognized

**Solutions:**
1. Verify installation:
   ```powershell
   npm list -g @anthropic-ai/claude-code
   ```
2. If not installed:
   ```powershell
   npm install -g @anthropic-ai/claude-code
   ```
3. Restart PowerShell (or close and reopen Windows Terminal)
4. Check PATH:
   ```powershell
   $env:PATH -split ';' | Select-String "npm"
   ```

### Authentication Issues

**Problem:** Claude won't authenticate or keeps asking for login

**Solutions:**
1. Run authentication:
   ```powershell
   claude auth login
   ```
2. Follow the browser prompts
3. If it fails, try clearing auth:
   ```powershell
   claude auth logout
   claude auth login
   ```

### Custom Agents Not Loading

**Problem:** Claude doesn't recognize custom agents

**Solutions:**
1. Verify agents directory exists:
   ```powershell
   Get-ChildItem "$env:USERPROFILE\.claude\agents"
   ```
2. Should show 6 .md files
3. If missing, re-run agent copy:
   ```powershell
   Copy-Item ".\claude\agents\*.md" "$env:USERPROFILE\.claude\agents\"
   ```
4. Restart Claude Code

### Permissions Keep Being Asked

**Problem:** Claude keeps asking for permissions despite settings

**Solutions:**
1. Verify settings file exists:
   ```powershell
   Test-Path "$env:USERPROFILE\.claude\settings.local.json"
   ```
2. Should return "True"
3. If False, copy it again:
   ```powershell
   Copy-Item ".\claude\settings\settings.local.json" "$env:USERPROFILE\.claude\settings.local.json"
   ```
4. Check contents:
   ```powershell
   Get-Content "$env:USERPROFILE\.claude\settings.local.json"
   ```

---

## Node.js / npm Issues

### npm Not Found

**Problem:** `npm` command not recognized

**Solutions:**
1. Install Node.js from: https://nodejs.org/
2. Download the LTS (Long Term Support) version
3. Run the installer
4. Restart PowerShell
5. Verify:
   ```powershell
   node --version
   npm --version
   ```

### npm Install Fails

**Problem:** `npm install -g @anthropic-ai/claude-code` fails

**Solutions:**
1. Run PowerShell as Administrator
2. Clear npm cache:
   ```powershell
   npm cache clean --force
   ```
3. Try again:
   ```powershell
   npm install -g @anthropic-ai/claude-code
   ```
4. If still failing, check internet connection and firewall

---

## General Windows Issues

### Administrator Rights

**Problem:** "Access Denied" errors

**Solution:**
1. Right-click Windows Terminal
2. Select "Run as Administrator"
3. Navigate to setup folder
4. Run setup script

### Error: ".\setup.ps1 is not recognized as the name of a cmdlet..."

**Problem:** You're not in the correct directory

**Solution:**
Navigate to the setup folder first:

```powershell
# Find where you saved/extracted the files
# Common locations:

# If in Downloads:
cd "$env:USERPROFILE\Downloads\windows-claude-ghostty-setup"

# If on USB drive (D: is common, might be E: or F:):
cd "D:\windows-claude-ghostty-setup"

# If on Desktop:
cd "$env:USERPROFILE\Desktop\windows-claude-ghostty-setup"

# Verify you're in the right place:
Get-ChildItem  # Should show setup.ps1, README.md, etc.

# Now run the setup:
.\setup.ps1
```

### Path Issues

**Problem:** Setup script can't find files

**Solution:**
Make sure you're in the correct directory:
```powershell
cd "path\to\windows-claude-ghostty-setup"
Get-ChildItem  # Should show setup.ps1 and other files
```

### Antivirus Blocking

**Problem:** Antivirus blocks script execution

**Solutions:**
1. Temporarily disable antivirus (not recommended)
2. Add exception for the setup folder
3. Use manual setup commands (see top of this document)

---

## Getting Help

### Check Logs

Windows Terminal settings location:
```
%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```

Claude Code config location:
```
%USERPROFILE%\.claude\
```

### Reset Everything

If all else fails, start fresh:

```powershell
# Remove Claude config (backup first if needed)
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude"

# Re-run setup
.\setup.ps1
```

### Still Having Issues?

1. Check README.md for detailed setup instructions
2. Review QUICK_START.md for condensed steps
3. Verify all prerequisites are installed:
   - Windows 11
   - Windows Terminal (pre-installed)
   - JetBrains Mono font
   - Node.js
   - Claude Code CLI

---

## Quick Reference Commands

**Check if Windows Terminal is installed:**
```powershell
Get-AppxPackage Microsoft.WindowsTerminal
```

**Find Windows Terminal settings:**
```powershell
explorer "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
```

**Check Claude Code installation:**
```powershell
claude --version
```

**List custom agents:**
```powershell
Get-ChildItem "$env:USERPROFILE\.claude\agents"
```

**Re-authenticate Claude:**
```powershell
claude auth logout
claude auth login
```

---

**Last Updated:** November 2025
