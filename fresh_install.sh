#!/bin/bash
set -e

# =============================================================================
# Fresh Install Script - Linux
# =============================================================================

echo "🔄 Starting fresh system installation..."

# =============================================================================
# System Dependencies
# =============================================================================

echo "📦 Installing build dependencies..."
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    autoconf patch rustc libyaml-dev libgmp-dev libncurses5-dev \
    libgdbm6 libgdbm-dev libdb-dev uuid-dev unzip \
    tmux zsh neovim git fzf ripgrep jq

# =============================================================================
# Git Configuration
# =============================================================================

echo "🔄 Setting up Git configuration..."

# Prompt for Git user info
echo "Please enter your Git username:"
read GIT_USERNAME

echo "Please enter your Git email:"
read GIT_EMAIL

# Configure Git globally
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

# Configure common Git settings
git config --global core.editor "nvim"
git config --global init.defaultBranch "main"
git config --global pull.rebase false

# Generate SSH key
echo "🔑 Generating SSH key..."
ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -N ""

# Start SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Display the public key
echo -e "\n📋 Your SSH public key (add this to GitHub/GitLab):"
cat ~/.ssh/id_ed25519.pub
echo -e "\n👉 Add this key at: https://github.com/settings/keys"
echo -e "Press Enter to continue..."
read

# =============================================================================
# GitHub CLI Installation
# =============================================================================

echo "🔗 Installing GitHub CLI..."
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -nv -O /tmp/githubcli.gpg https://cli.github.com/packages/githubcli-archive-keyring.gpg
sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null < /tmp/githubcli.gpg
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
    sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y

# =============================================================================
# ASDF Installation
# =============================================================================

echo "🧹 Removing old ASDF setup if it exists..."
rm -rf ~/.asdf

echo "📥 Installing ASDF..."
# Determine architecture and set download URL
ARCH=$(dpkg --print-architecture)
ASDF_VERSION="0.16.7"
DOWNLOAD_URL="https://github.com/asdf-vm/asdf/releases/download/v${ASDF_VERSION}/asdf-v${ASDF_VERSION}-linux-${ARCH}.tar.gz"

# Create directories
mkdir -p ~/.local/bin ~/.asdf

# Download and extract the binary
echo "📥 Downloading ASDF v${ASDF_VERSION}..."
wget -q "$DOWNLOAD_URL" -O /tmp/asdf.tar.gz

# Create a clean directory for extraction
rm -rf /tmp/asdf-extract
mkdir -p /tmp/asdf-extract
tar -xzf /tmp/asdf.tar.gz -C /tmp/asdf-extract

# Find the asdf binary in the extracted files
echo "🔍 Finding asdf binary..."
find /tmp/asdf-extract -type f -name "asdf" -o -type f -executable | while read -r file; do
    if file "$file" | grep -q "executable"; then
        echo "✅ Found binary: $file"
        cp "$file" ~/.local/bin/asdf
        chmod +x ~/.local/bin/asdf
        break
    fi
done

# Check if binary was found and copied
if [ ! -f ~/.local/bin/asdf ]; then
    echo "❌ Could not find asdf binary in the archive. Archive contents:"
    find /tmp/asdf-extract -type f | sort
    exit 1
fi

# Clean up
rm -rf /tmp/asdf.tar.gz /tmp/asdf-extract

# Set up ASDF in shell configuration
echo "🔧 Setting up ASDF in shell..."
cat >> ~/.bashrc << 'EOF'

# ASDF setup
export PATH="$HOME/.local/bin:$PATH"
export ASDF_DIR="$HOME/.asdf"
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$HOME/.asdf/shims:$PATH"
EOF

# Add environment variables for current session
export PATH="$HOME/.local/bin:$PATH"
export ASDF_DIR="$HOME/.asdf"
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$HOME/.asdf/shims:$PATH"

# =============================================================================
# ASDF Plugins Installation
# =============================================================================

echo "🔌 Installing ASDF plugins..."
~/.local/bin/asdf plugin add just
~/.local/bin/asdf plugin add python
~/.local/bin/asdf plugin add terraform
~/.local/bin/asdf plugin add ruby
~/.local/bin/asdf plugin add nodejs

# Install specific versions
echo "📦 Installing tool versions..."
~/.local/bin/asdf install just 1.40.0 
~/.local/bin/asdf set just 1.40.0 -u

~/.local/bin/asdf install python 3.13.3
~/.local/bin/asdf set python 3.13.3 -u 

~/.local/bin/asdf install terraform 1.6.6
~/.local/bin/asdf set terraform 1.6.6 -u

~/.local/bin/asdf install ruby latest
~/.local/bin/asdf set ruby latest -u

~/.local/bin/asdf install nodejs 20.14.0
~/.local/bin/asdf set nodejs 20.14.0 -u

echo "✅ ASDF tools installed successfully!"

# =============================================================================
# Claude Code Installation
# =============================================================================

echo "🤖 Installing Claude Code CLI..."

# Install Claude Code with npm
npm install -g @anthropic-ai/claude-code

# Reshim to make sure the command is available
~/.local/bin/asdf reshim nodejs

# =============================================================================
# ZSH Installation & Configuration
# =============================================================================

echo "🐚 Setting up ZSH and Oh-My-ZSH..."

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set ZSH as default shell
chsh -s $(which zsh)

# Note: ASDF setup is now in the dotfiles .zshrc file that will be linked by install.sh

# =============================================================================
# Google Cloud CLI Installation
# =============================================================================

echo "☁️ Installing Google Cloud CLI..."

# Install prerequisites
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl

# Create directory for the repository key
sudo mkdir -p /usr/share/keyrings

# Import the Google Cloud public key (for newer distributions - Debian 9+ or Ubuntu 18.04+)
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Add the gcloud CLI distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Update and install the gcloud CLI
sudo apt-get update
sudo apt-get install -y google-cloud-cli

# =============================================================================
# Docker Installation
# =============================================================================

echo "🐳 Installing Docker..."

# Remove older packages if they exist
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# Ensure pre-requisites are installed
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker apt key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker apt repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Refresh apt repos
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Perform post-installation steps
sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker $USER

# =============================================================================
# Final Setup Notes
# =============================================================================

echo "🎉 Installation complete!"
echo ""
echo "⚠️  Important next steps:"
echo "1. Close your shell and open another one for group changes to take effect"
echo "2. New shell will use ZSH with Oh-My-ZSH as the default shell"
echo "3. Docker access will require logging out and back in"
echo ""
echo "For WSL2 users - to enable Docker at startup, add the following to /etc/wsl.conf:"
echo "[boot]"
echo "systemd=true"
echo ""
echo "🔧 Installed components:"
echo "- Build tools and dependencies"
echo "- Git configuration and SSH key"
echo "- GitHub CLI (gh)"
echo "- ASDF version manager with plugins (just, python, terraform, ruby, nodejs)"
echo "- Claude Code CLI"
echo "- ZSH with Oh-My-ZSH"
echo "- tmux and neovim"
echo "- Google Cloud CLI (gcloud)"
echo "- Docker CE"