#!/bin/bash
set -e

# Create backup of existing config files
echo "Creating backups of existing config files..."
[ -f ~/.tmux.conf ] && cp ~/.tmux.conf ~/.tmux.conf.bak
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak

# Symlink configuration files
echo "Creating symlinks for configuration files..."
ln -sf "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/zsh/.zshrc" ~/.zshrc

echo "✅ Dotfiles installation complete!"
echo "Backup files were created with .bak extension if original files existed."
