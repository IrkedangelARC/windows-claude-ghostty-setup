#!/bin/bash
# Script to reload tmux configuration and verify 2-row status bar

echo "Reloading tmux configuration..."
tmux source-file ~/.tmux.conf

echo ""
echo "Checking tmux status configuration:"
echo "  Status enabled: $(tmux display-message -p '#{status}')"
echo "  Tmux version: $(tmux -V)"

echo ""
echo "If you still see only one row, try:"
echo "  1. Kill tmux server: tmux kill-server"
echo "  2. Restart Ghostty"
echo ""
echo "Configuration reloaded!"
