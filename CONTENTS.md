# Package Contents

This package contains everything needed to replicate your macOS terminal + Claude Code setup on Windows 11 using Windows Terminal.

## File Structure

```
windows-claude-ghostty-setup/
│
├── README.md                              # Complete setup instructions
├── QUICK_START.md                         # 5-minute quick start guide
├── CONTENTS.md                            # This file
├── CLAUDE_INITIALIZATION_PROMPT.md        # First-run prompt for Claude Code
├── setup.ps1                              # Automated PowerShell setup script
│
├── windows-terminal/
│   └── settings.json                      # Windows Terminal configuration
│                                          # Target: %LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
│
└── claude/
    ├── settings/
    │   └── settings.local.json            # Claude Code permissions
    │                                      # Target: %USERPROFILE%\.claude\settings.local.json
    │
    └── agents/                            # Custom Claude Code agents
        ├── arcninja.md                    # Target: %USERPROFILE%\.claude\agents\
        ├── av-integration-engineer.md
        ├── ghostty-config-specialist.md
        ├── gmail-assistant.md
        ├── gworkspace-python-dev.md
        └── session-documenter.md
```

## What's Included

### Configuration Files

#### Windows Terminal Config (`windows-terminal/settings.json`)
- **Theme:** Catppuccin Mocha (dark theme with purple accents)
- **Font:** JetBrains Mono, size 12
- **Visual:** 95% opacity, acrylic blur, enhanced selection colors
- **Features:** Auto-copy on select, clipboard integration (OSC 52)
- **Cursor:** Blinking block style in Catppuccin blue
- **Adapted for Windows:** Native Windows Terminal JSON configuration format

#### Claude Settings (`claude/settings/settings.local.json`)
- **Pre-approved permissions:**
  - Bash (PowerShell on Windows)
  - Read, Write, Edit operations
  - Glob and Grep for searching
  - Task delegation
  - Notebook editing

### Custom Agents

#### 1. arcninja.md
Project-specific automation and workflows for Arc Events Productions.

#### 2. av-integration-engineer.md
- Technical AV (audio/visual) programming
- Google API integration (Calendar, Drive, etc.)
- Python automation scripts for AV systems
- Serial communication and device control

#### 3. ghostty-config-specialist.md
- Configures Ghostty terminal settings
- Multi-pane layouts
- Startup behavior and automation
- Troubleshoots configuration issues

#### 4. gmail-assistant.md
- Read, write, compose emails
- Gmail API integration
- Inbox management
- Uses info@arceventproductions.com account

#### 5. gworkspace-python-dev.md
- Google Workspace API development
- Authentication setup (OAuth, service accounts)
- API integration patterns
- Error handling and debugging

#### 6. session-documenter.md (scribe)
- Creates comprehensive session documentation
- Captures progress, decisions, and context
- Useful for handoffs between work sessions
- Auto-triggers at natural stopping points

## Setup Methods

### Method 1: Automated (Recommended)
Run `setup.ps1` in Administrator PowerShell - handles all file copying automatically.

### Method 2: Manual
Follow step-by-step instructions in `README.md` to copy files manually.

### Method 3: Quick Start
Use `QUICK_START.md` for a condensed 5-minute setup guide.

## External Dependencies

These need to be installed separately (links provided in README.md):

1. **Windows Terminal** - Pre-installed on Windows 11 (or get from Microsoft Store)
2. **JetBrains Mono Font** - Required by the Windows Terminal config
3. **Node.js** - Required for Claude Code CLI
4. **Claude Code CLI** - The main tool (`npm install -g @anthropic-ai/claude-code`)

## After Installation

1. Launch Windows Terminal - should display with Catppuccin Mocha theme
2. Run `claude` in terminal
3. Use the prompt from `CLAUDE_INITIALIZATION_PROMPT.md` for first interaction
4. Test custom agents with relevant queries

## Version Information

- **Created:** November 2025
- **Source System:** macOS (Sonoma/Sequoia)
- **Target System:** Windows 11
- **Ghostty Version:** Compatible with latest releases
- **Claude Code Version:** Latest (as of creation)

## Notes

- All paths are Windows-compatible
- PowerShell syntax used throughout
- Custom agents are cross-platform (work identically on macOS/Windows/Linux)
- Configuration files are text-based and easily editable
- No sensitive information included (no API keys, credentials, etc.)

## Support

For issues or questions:
1. Check `README.md` troubleshooting section
2. Verify file locations match the structure above
3. Ensure all prerequisites are installed
4. Run setup script as Administrator

---

**Total Files:** 12 (4 documentation + 1 script + 1 config + 1 settings + 6 agents)

**Package Size:** ~150 KB (mostly markdown documentation)

**Setup Time:** 5-15 minutes (depending on download speeds for dependencies)
