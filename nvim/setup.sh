#!/bin/bash

# Create nvim config directory if it doesn't exist
mkdir -p ~/.config/nvim

# Create symbolic link
ln -sf $(pwd)/init.vim ~/.config/nvim/init.vim

echo "Basic Neovim configuration has been linked."