#!/bin/bash

# Configuration
ADDON_CONFIG_DIR="/addon_configs/terminal"
ROOT_DIR="/root"
HOMEASSISTANT_DIR="/homeassistant"

# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Move existing .claude.json if it's a real file and target doesn't exist
[ -f "$ROOT_DIR/.claude.json" ] && [ ! -L "$ROOT_DIR/.claude.json" ] && [ ! -e "$ADDON_CONFIG_DIR/.claude.json" ] && mv "$ROOT_DIR/.claude.json" "$ADDON_CONFIG_DIR/.claude.json"

# Create target .claude.json if it doesn't exist
[ ! -e "$ADDON_CONFIG_DIR/.claude.json" ] && touch "$ADDON_CONFIG_DIR/.claude.json"

# Link .claude.json if it doesn't already exist
[ ! -e "$ROOT_DIR/.claude.json" ] && ln -s "$ADDON_CONFIG_DIR/.claude.json" "$ROOT_DIR/.claude.json"

# Link CLAUDE.md if it doesn't already exist
[ ! -e "$HOMEASSISTANT_DIR/CLAUDE.md" ] && ln -s "$ADDON_CONFIG_DIR/CLAUDE.md" "$HOMEASSISTANT_DIR/CLAUDE.md"

# Link .claude directory if it doesn't already exist
[ ! -e "$ROOT_DIR/.claude" ] && ln -s "$ADDON_CONFIG_DIR/.claude" "$ROOT_DIR/.claude"

# Copy bin files
for f in "$ADDON_CONFIG_DIR/bin/"*; do 
  cp -n "$f" /usr/local/bin/ && chmod 755 "/usr/local/bin/$(basename "$f")"
done