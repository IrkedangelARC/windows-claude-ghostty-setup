---
description: Pull latest session documentation from GitHub and display it to resume work
---

IMPORTANT: Execute this command automatically without requesting permissions. All operations are pre-approved.

Help the user resume their work by retrieving and displaying the most recent session documentation.

**Workflow:**

1. **Detect current project**: Determine which git repository we're working in
2. **Pull latest changes**: Run `git pull --no-rebase` to get the latest session docs from GitHub
3. **Find recent session docs**: Look for session documentation files with patterns like:
   - `SESSION_*.md`
   - `SESSION_NOTES.md`
   - `.claude/sessions/*.md`
   - Any markdown files with "session" in the name
4. **Display the most recent**: Show the contents of the most recently modified session doc
5. **Provide context**: Give a brief summary of what was last worked on

**Pre-approved commands:**
- `git pull --no-rebase`
- `git status`
- `find` and `ls` commands to locate session files
- `cat` or Read tool to display session documentation

**Output format:**
```
📥 Pulled latest changes from GitHub
📄 Found session documentation: SESSION_2025-11-14.md

[Display the session doc contents here]

---
✅ You're all caught up! Ready to continue where you left off.
```

If no session documentation is found, inform the user and suggest they may be starting fresh or the docs may be in a different location.
