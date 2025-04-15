#:q:!/bin/bash
set -e

# Create backup of existing config files
echo "Creating backups of existing config files..."
[ -f ~/.tmux.conf ] && cp ~/.tmux.conf ~/.tmux.conf.bak
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak
[ -f ~/.config/nvim/init.lua ] && cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak

# Create config directories if they don't exist
mkdir -p ~/.config/nvim
mkdir -p ~/.local/bin

# Symlink configuration files
echo "Creating symlinks for configuration files..."
ln -sf "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/zsh/.zshrc" ~/.zshrc
ln -sf "$(pwd)/nvim/init.lua" ~/.config/nvim/init.lua

# Link tmux scripts to bin directory
echo "Linking tmux scripts to ~/.local/bin..."
ln -sf "$(pwd)/tmux/colony-tmux" ~/.local/bin/colony-tmux

# Link Neovim lua directory (for plugins)
echo "Linking Neovim lua directory..."
mkdir -p ~/.config/nvim/lua
ln -sf "$(pwd)/nvim/lua/plugins" ~/.config/nvim/lua/

echo "✅ Dotfiles installation complete!"
echo "Backup files were created with .bak extension if original files existed."
