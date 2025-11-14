---
description: List all session documentation files and optionally display a specific one
---

IMPORTANT: Execute this command automatically without requesting permissions.

List all available session documentation files in the current project to help the user browse previous work sessions.

**Workflow:**

1. **Pull latest changes**: Run `git pull --no-rebase` to ensure we have all session docs from GitHub
2. **Find all session docs**: Search for session documentation with patterns:
   - `SESSION_*.md`
   - `SESSION_NOTES*.md`
   - `.claude/sessions/*.md`
   - Files containing "session" in the name
3. **Display sorted list**: Show all session docs sorted by date (newest first) with:
   - Filename
   - Last modified date
   - First few lines or summary if available
4. **Interactive selection**: If the user wants to view a specific session, display its full contents

**Pre-approved commands:**
- `git pull --no-rebase`
- `find`, `ls`, `stat` commands to locate and list session files
- `cat`, `head` or Read tool to display session documentation

**Output format:**
```
📚 Available Session Documentation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. SESSION_2025-11-14.md (Today, 3:45 PM)
   └─ "Ghostty setup replication, added 2-row status bar..."

2. SESSION_2025-11-12_MEGA_INSTALLER.md (2 days ago)
   └─ "Created Windows installer scripts for Ghostty..."

3. SESSION_2025-11-11.md (3 days ago)
   └─ "Initial project setup and configuration..."

---
💡 Use /resume to view the latest session, or ask me to display a specific session by name.
```

If no session documentation is found, suggest running the scribe agent at the end of sessions to start building this documentation repository.
