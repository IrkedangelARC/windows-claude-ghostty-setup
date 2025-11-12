# Claude Code Initialization Prompt for Windows 11

Use this prompt when you first start Claude Code on your Windows 11 machine to help it understand your environment and setup.

---

## Copy and Paste This Into Claude Code:

```
Hi Claude! I've just set up Claude Code on my Windows 11 machine. Here's what you need to know about my environment:

**System Information:**
- Operating System: Windows 11
- Shell: PowerShell (Admin)
- Terminal: Ghostty Terminal
- Working Directory: C:\Users\<YourUsername>\Projects

**Installed Custom Agents:**
I have several custom agents installed in my ~/.claude/agents/ directory:

1. **session-documenter** (scribe) - Creates comprehensive session documentation when I'm done working
2. **gmail-assistant** - Helps with Gmail operations and email composition
3. **av-integration-engineer** - Technical AV programming, Google API integration, Python automation
4. **ghostty-config-specialist** - Configures Ghostty terminal emulator settings and layouts
5. **gworkspace-python-dev** - Google Workspace API development and integration
6. **arcninja** - Project-specific automation and workflows for Arc Events Productions

**My Preferences:**
- I prefer concise, technical communication
- I'm comfortable with command-line operations and PowerShell
- I work on audio/visual integration projects and event production systems
- I use Python extensively for automation and API integrations
- I value well-documented code and clear explanations

**Claude Code Settings:**
I have the following permissions pre-approved (in settings.local.json):
- Bash (PowerShell on Windows)
- Read, Write, Edit
- Glob, Grep
- Task
- NotebookEdit

**Current Projects:**
I typically work in:
- $env:USERPROFILE\Projects
- $env:USERPROFILE\projects

**Windows Terminal Configuration:**
- Theme: Catppuccin Mocha
- Font: JetBrains Mono
- Auto-copy on select enabled
- Background opacity: 95% with acrylic blur

**What I need from you:**
- Use the custom agents when appropriate for specialized tasks
- Suggest using agents proactively when you detect relevant work
- Respect my Windows PowerShell environment (use PowerShell commands, not bash/unix)
- Be efficient with tool usage and batch operations when possible
- Keep me informed of progress using the TodoWrite tool for complex tasks

**First Task:**
Please confirm that you can see my custom agents and are ready to assist. Then, give me a quick overview of how we can work together effectively.
```

---

## Alternative Shorter Prompt (Quick Start):

```
Hi Claude! New Windows 11 setup here. I have custom agents installed:
- session-documenter (for end-of-session docs)
- gmail-assistant (email management)
- av-integration-engineer (AV systems programming)
- ghostty-config-specialist (terminal config - works with Windows Terminal too!)
- gworkspace-python-dev (Google APIs)
- arcninja (project automation)

I work on AV/event production systems, use Windows Terminal with PowerShell, and prefer concise technical communication. Ready to work!
```

---

## Testing Your Setup

After sending the initialization prompt, test your setup with these commands:

### 1. Verify Agent Availability
```
Can you list all available custom agents in my ~/.claude/agents/ directory?
```

### 2. Test File Operations
```
Create a test file in my current directory called "test.txt" with the content "Hello from Windows!"
```

### 3. Test PowerShell Integration
```
Run a PowerShell command to show my current directory and list its contents.
```

### 4. Test a Custom Agent
```
I need help configuring my Ghostty terminal to use a different font size. Can you use the ghostty-config-specialist agent?
```

---

## Pro Tips for Working with Claude Code on Windows

1. **PowerShell vs Bash**: Claude understands you're on Windows. It should automatically use PowerShell commands, but you can remind it if needed.

2. **Path Separators**: Windows uses backslashes (`\`) but PowerShell also accepts forward slashes (`/`). Both work.

3. **Environment Variables**: Use PowerShell syntax:
   - `$env:USERPROFILE` instead of `~`
   - `$env:APPDATA` for application data
   - `$env:TEMP` for temporary files

4. **Agent Invocation**: Simply mention the type of work, and Claude will suggest relevant agents:
   - "Let's document this session" → triggers session-documenter
   - "Send an email to..." → triggers gmail-assistant
   - "Help with Google Calendar API..." → triggers gworkspace-python-dev

5. **Permissions**: Your settings.local.json pre-approves common operations, so Claude won't constantly ask for permission.

---

## Workflow Examples

### Example 1: Starting a New Project
```
I'm starting a new Python project for AV automation. Can you:
1. Create a project structure
2. Set up a virtual environment
3. Create a requirements.txt with common AV libraries
```

### Example 2: Debugging Code
```
I'm getting an error in my Google Calendar API integration. The error is: [paste error]
Can you help me debug this?
```

### Example 3: End of Day Documentation
```
I'm done for today. Can you use the session-documenter agent to create a summary of what we accomplished?
```

### Example 4: Terminal Customization
```
I want to modify my Windows Terminal config to use a larger font size. Can you help?
```

---

## Remember

- Claude Code learns your preferences over time
- Custom agents are automatically available - just ask for relevant help
- Use natural language - no need to memorize commands
- Claude can execute PowerShell, read/write files, search code, and more
- The TodoWrite tool helps track multi-step tasks

**Ready to get started? Copy one of the prompts above and paste it into Claude Code!** 🚀
