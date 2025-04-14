# ===== BASIC SETTINGS =====

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups
setopt hist_ignore_space

# ===== OH-MY-ZSH CONFIGURATION =====

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="robbyrussell"

# Enable plugins
plugins=(
  git
  docker
  npm
  python
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ===== ENVIRONMENT VARIABLES =====

export LANG=en_US.UTF-8
export EDITOR='nvim'

# ASDF setup
export PATH="$HOME/.local/bin:$PATH"
export ASDF_DIR="$HOME/.asdf"
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$HOME/.asdf/shims:$PATH"

# ===== ALIASES =====

# Git aliases
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"

# Directory navigation
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../.."

# Docker shortcuts
alias dc="docker-compose"
alias dps="docker ps"

# Editor
alias vi="nvim"