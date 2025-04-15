# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- **Install dotfiles**: `./install.sh`
- **Fresh system setup**: `./fresh_install.sh`
- **Update configurations**: `./update.sh`

## Code Style Guidelines

### Shell Scripts
- Use `#!/bin/bash` shebang
- Set `set -e` for error handling
- Use descriptive comments with section separators (`# =============================================================================`)
- Echo status messages with emoji prefixes
- Quote all variables
- Use lowercase for variable names

### Neovim Configuration
- Use Lua for configuration (not VimScript)
- Structure plugins with lazy.nvim format
- Plugin configuration should follow lazy.nvim pattern
- Keep related settings grouped together
- Use consistent indentation (2 spaces)

### File Organization
- Group configuration by tool (nvim, tmux, zsh)
- Keep installation scripts in repository root
- Store tool-specific configurations in dedicated directories