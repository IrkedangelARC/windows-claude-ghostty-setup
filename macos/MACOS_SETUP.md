# macOS Ghostty + Tmux Setup

This directory contains the complete Ghostty terminal and tmux configuration for macOS.

## Features

- **2-row status bar** at the bottom showing:
  - Top row: Session/window info, git branch, Python venv, current folder, time/date
  - Bottom row: Prefix hint, network stats, memory usage, CPU usage

- **Pane titles** at the top of each pane showing:
  - Pane index and current command
  - Full current folder path

- **Catppuccin Mocha theme** with transparency and blur
- **Custom dev layout** (Prefix + d): Claude Code on left, editor top-right, output bottom-right
- **Vim-style navigation** and many workflow shortcuts

## Installation

### 1. Install Ghostty
```bash
brew install --cask ghostty
```

### 2. Install tmux and dependencies
```bash
brew install tmux
```

### 3. Copy configuration files

```bash
# Create necessary directories
mkdir -p ~/.config/ghostty
mkdir -p ~/.tmux/scripts

# Copy Ghostty config
cp macos/ghostty/config ~/.config/ghostty/

# Copy tmux config
cp macos/tmux/.tmux.conf ~/

# Copy tmux scripts
cp macos/tmux/scripts/* ~/.tmux/scripts/
chmod +x ~/.tmux/scripts/*
```

### 4. Reload tmux configuration

If tmux is already running:
```bash
tmux source-file ~/.tmux.conf
```

Or restart Ghostty to start fresh tmux sessions.

## Troubleshooting

### Status bar only shows one row
1. Ensure tmux version is 3.0 or higher: `tmux -V`
2. Reload config: `tmux source-file ~/.tmux.conf`
3. Kill all tmux sessions and restart Ghostty: `tmux kill-server`

### Pane titles not showing
1. Check that `pane-border-status` is set to `top`
2. Reload config: `tmux source-file ~/.tmux.conf`

### Scripts not working
1. Ensure scripts are executable: `chmod +x ~/.tmux/scripts/*`
2. Check script paths in `.tmux.conf` match your home directory

## Key Bindings

- Prefix: `Ctrl-a` (instead of default Ctrl-b)
- Create dev layout: `Prefix + d`
- Split horizontal: `Prefix + |`
- Split vertical: `Prefix + -`
- Navigate panes: `Prefix + h/j/k/l` or `Prefix + arrows`
- Resize panes: `Prefix + H/J/K/L` (fine) or `Prefix + Shift + arrows` (coarse)
- Zoom pane: `Prefix + z`
- Reload config: `Prefix + r`
