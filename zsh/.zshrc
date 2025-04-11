# ===== BASIC SETTINGS =====

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups
setopt hist_ignore_space

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

# ===== PROMPT =====

# Simple prompt with username, hostname, and current directory
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '