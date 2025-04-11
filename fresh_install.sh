set -e

echo "📦 Installing build dependencies..."
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    autoconf patch rustc libyaml-dev libgmp-dev libncurses5-dev \
    libgdbm6 libgdbm-dev libdb-dev uuid-dev

# sudo apt install make -y
sudo apt install unzip -y

# # Install GH CLI
# (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
# 	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
#         && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
#         && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
# 	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
# 	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# 	&& sudo apt update \
# 	&& sudo apt install gh -y


#!/bin/bash
set -e

echo "🧹 Removing old ASDF setup if it exists..."
rm -rf ~/.asdf

echo "📥 Installing ASDF binary..."
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

# Add plugins
echo "🔌 Installing ASDF plugins..."
export PATH="$HOME/.local/bin:$PATH"
export ASDF_DIR="$HOME/.asdf"
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$HOME/.asdf/shims:$PATH"

~/.local/bin/asdf plugin add just
~/.local/bin/asdf plugin add python
~/.local/bin/asdf plugin add terraform
~/.local/bin/asdf plugin add ruby
~/.local/bin/asdf plugin add nodejs

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

echo "✅ ASDF installed successfully!"
echo "🚀 Please restart your shell or run 'source ~/.bashrc' to start using ASDF"



# Ensures not older packages are installed
sudo apt-get remove docker docker-engine docker.io containerd runc

# Ensure pre-requisites are installed
sudo apt-get update
sudo apt-get install \
	ca-certificates \
	curl \
	gnupg \
	lsb-release

# Adds docker apt key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Adds docker apt repository
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Refreshes apt repos
sudo apt-get update

# Installs Docker CE
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Perform the post-installation steps:
 # Ensures docker group exists
sudo groupadd docker

   # Ensures you are part of it
sudo usermod -aG docker $USER

   # Now, close your shell and open another for taking the group changes into account


#    Make Docker Daemon start on WSL initialization:
# First, make sure you are running a recent version of WSL2 (you can update with wsl.exe --update).

# Then, you only need to add:

#    [boot]
#    systemd=true