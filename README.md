# Tony's Dotfiles

Personal dotfiles repository for Linux systems.

## Installation

### Fresh System Installation

If you're setting up a brand new system, first run the fresh install script:

```bash
./fresh_install.sh
```

This script installs:
- Essential build dependencies
- Git configuration and SSH key generation
- GitHub CLI (gh)
- ASDF version manager with plugins (just, python, terraform, ruby, nodejs)
- Claude Code CLI
- ZSH with Oh-My-ZSH
- tmux and neovim
- Google Cloud CLI (gcloud)
- Docker CE

### Dotfiles Installation

After the fresh installation (or on an existing system), install the dotfiles:

```bash
./install.sh
```

This will:
1. Back up any existing configuration files
2. Create symlinks from this repository to your home directory

## Update

To update all configurations:

```bash
./update.sh
```

## Included Configurations

- ZSH configuration with Oh-My-ZSH
- tmux configuration

## Customization

Feel free to modify any configuration files to suit your preferences.