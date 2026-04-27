#!/usr/bin/env bash
# Auto-update system-specs.md when .nix files are modified

# Read the tool use input from stdin
INPUT=$(cat)

# Extract the file path that was modified (using grep/sed instead of jq)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' | head -1)

# Only proceed if a .nix file was modified
if [[ ! "$FILE_PATH" =~ \.nix$ ]]; then
    exit 0
fi

# Run git diff to see what changed
cd "$CLAUDE_PROJECT_DIR" || exit 0
CHANGES=$(git diff --stat 2>/dev/null)

# Log the change
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Modified: $FILE_PATH" >&2

# Trigger a notification that the specs should be regenerated
# This creates a marker file that Claude Code can detect
MARKER_FILE="$CLAUDE_PROJECT_DIR/.claude/needs-specs-update"
echo "$FILE_PATH" >> "$MARKER_FILE"

# Optional: Show what changed
if [ -n "$CHANGES" ]; then
    echo "Git changes detected:" >&2
    echo "$CHANGES" >&2
fi

exit 0
