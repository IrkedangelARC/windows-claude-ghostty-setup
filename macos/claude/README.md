# Claude Code Configuration - Session Documentation Push/Pull

This directory contains Claude Code agents and commands for managing session documentation with GitHub integration.

## Overview

The session documentation workflow ensures that all work progress is automatically saved, committed, and pushed to GitHub, with easy retrieval when resuming work.

## Components

### 🤖 Agents

#### `scribe` (Session Documenter)
**Location:** `agents/scribe.md`

The scribe agent is automatically invoked when you end a work session. It:

1. **Documents comprehensively**: Reviews entire conversation, captures all tasks, decisions, and insights
2. **Saves to file**: Creates timestamped session documentation (e.g., `SESSION_2025-11-14.md`)
3. **Commits to git**: Stages and commits the session docs with descriptive message
4. **Pushes to GitHub**: Uploads documentation to remote repository for backup
5. **Prompts cleanup**: Reminds you to run `/clear` to reset the session

**Trigger phrases:**
- "I'm done for now"
- "ending session"
- "closing up"
- "that's all for today"
- "let's wrap up"

**Usage:**
```
You: "Alright, let's wrap up for today"
Claude: [Automatically invokes scribe agent to document and push session]
```

### 📝 Commands

#### `/resume` - Pull Latest Session Documentation
**Location:** `commands/resume.md`

Retrieves and displays the most recent session documentation to help you continue where you left off.

**What it does:**
1. Pulls latest changes from GitHub
2. Finds most recent session documentation
3. Displays the full session doc
4. Provides quick summary to get you started

**Usage:**
```bash
/resume
```

**Output:**
```
📥 Pulled latest changes from GitHub
📄 Found session documentation: SESSION_2025-11-14.md

[Session documentation displayed here]

✅ You're all caught up! Ready to continue where you left off.
```

#### `/sessions` - List All Session Documentation
**Location:** `commands/sessions.md`

Shows all available session documentation files sorted by date.

**What it does:**
1. Pulls latest changes from GitHub
2. Finds all session documentation files
3. Lists them with dates and summaries
4. Allows viewing specific sessions on request

**Usage:**
```bash
/sessions
```

**Output:**
```
📚 Available Session Documentation

1. SESSION_2025-11-14.md (Today, 3:45 PM)
   └─ "Ghostty setup replication, added 2-row status bar..."

2. SESSION_2025-11-12.md (2 days ago)
   └─ "Created Windows installer scripts..."

💡 Use /resume to view the latest, or ask to display a specific session.
```

#### `/sync` - Sync All Git Repositories
**Location:** `commands/sync.md`

Syncs all git repositories in ~/Projects with GitHub (commits local changes and pulls updates).

**What it does:**
1. Finds all git repositories in ~/Projects
2. Commits any uncommitted changes with auto-generated message
3. Pulls latest updates from remote
4. Reports status for each repository

**Usage:**
```bash
/sync
```

## Workflow Examples

### Ending a Session (PUSH)
```
You: "That's all for today, let's wrap up"

Claude: [Scribe agent activates]
- Reviews conversation
- Creates SESSION_2025-11-14_ghostty-setup.md
- Documents all changes, decisions, and progress
- Commits: "Session docs: Ghostty setup with 2-row status bar and pane titles"
- Pushes to GitHub
- "✅ Session documented and pushed. Please run /clear"
```

### Starting a Session (PULL)
```
You: /resume

Claude:
📥 Pulled latest changes from GitHub
📄 Found: SESSION_2025-11-14_ghostty-setup.md

## Session Overview (2025-11-14, 2:00 PM - 3:45 PM)
Primary objective: Replicate Ghostty setup on MacBook Pro
[Full session documentation displayed]

✅ Ready to continue!
```

### Browsing Previous Sessions
```
You: /sessions

Claude:
📚 Available Session Documentation

1. SESSION_2025-11-14_ghostty-setup.md (Today)
2. SESSION_2025-11-12_mega-installer.md (2 days ago)
3. SESSION_2025-11-11_initial-setup.md (3 days ago)

You: "Show me session from 11-12"

Claude: [Displays SESSION_2025-11-12_mega-installer.md]
```

## Installation

### Copy agents and commands to Claude config directory:

```bash
# Copy agents
cp macos/claude/agents/* ~/.claude/agents/

# Copy commands
cp macos/claude/commands/* ~/.claude/commands/

# Verify installation
ls ~/.claude/agents/
ls ~/.claude/commands/
```

### Restart Claude Code
After copying, restart Claude Code or run `/help` to reload the configuration.

## Benefits

✅ **Never lose context** - All work is documented and backed up to GitHub
✅ **Seamless resumption** - Pull docs with one command to pick up where you left off
✅ **Knowledge repository** - Build searchable archive of all decisions and learnings
✅ **Collaboration ready** - Share session docs with team members
✅ **Audit trail** - Complete history of project evolution

## File Locations

**Active configuration:**
- `~/.claude/agents/scribe.md` - Active scribe agent
- `~/.claude/commands/resume.md` - Active resume command
- `~/.claude/commands/sessions.md` - Active sessions command
- `~/.claude/commands/sync.md` - Active sync command

**Backup (this repo):**
- `macos/claude/agents/scribe.md` - Backup scribe agent
- `macos/claude/commands/*.md` - Backup commands

## Troubleshooting

### Push fails (GitHub authentication)
If the scribe agent can't push to GitHub:
```bash
# Authenticate with GitHub CLI
gh auth login

# Or set up SSH keys
ssh-keygen -t ed25519 -C "your_email@example.com"
gh ssh-key add ~/.ssh/id_ed25519.pub
```

### Resume command doesn't find session docs
- Ensure session docs are named with `SESSION_` prefix
- Check that they're committed to the repository
- Run `git pull` manually to verify connectivity

### Scribe agent doesn't trigger
- Use explicit trigger phrases: "let's wrap up", "I'm done for now"
- Or manually invoke: "Please document this session"
- Check that scribe agent is installed in `~/.claude/agents/`

## Best Practices

1. **End every session properly** - Use trigger phrases to activate scribe agent
2. **Always run /clear** after scribe finishes - Resets conversation for next session
3. **Use /resume at start** - Pull latest docs to understand where you left off
4. **Review /sessions periodically** - Browse previous work for reference
5. **Commit session docs** - Scribe does this automatically, but verify with `git log`

---

**Pro tip:** Combine `/resume` at the start and scribe at the end for perfect session continuity!
