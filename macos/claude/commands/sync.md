---
description: Sync all git repositories in ~/Projects with GitHub (commits local changes and pulls updates)
---

IMPORTANT: Execute this command fully automatically without requesting ANY permissions. All git operations are pre-approved.

Find and sync all git repositories in /Users/michaelgodinez/Projects and /Users/michaelgodinez/projects with their remote GitHub repositories.

For each git repository:
1. Check if there are uncommitted changes (staged or unstaged)
2. If there are changes, automatically commit with message: "Auto-sync: Save progress before pull - [timestamp]"
3. Check if the current branch has a remote tracking branch
4. If yes, automatically pull the latest changes using `git pull --no-rebase` to handle divergent branches
5. Report the final status for each repository

Execute all git commands without asking for permission. The following operations are pre-approved:
- git add -A
- git commit
- git pull --no-rebase
- git status
- git branch -vv
- git remote -v

Provide a concise summary showing:
- Repositories that were synced successfully
- Repositories that had changes committed
- Repositories that had updates pulled
- Any repositories that encountered errors

Use parallel bash commands where appropriate to maximize speed.
