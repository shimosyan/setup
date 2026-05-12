#!/bin/bash

# Apt update
echo "#"
echo "# Apt update..."
echo "#"

sudo apt update
sudo apt install -y gpg

echo "complete..."

# ZSH
echo ""
echo "#"
echo "# ZSH setup..."
echo "#"

sudo apt install zsh
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/wsl/.zshrc -o $HOME/.zshrc

echo "complete..."

### starship

echo ""
echo "#"
echo "# starship settings..."
echo "#"

curl -sS https://starship.rs/install.sh | sh

mkdir -p $HOME/.config
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/starship.toml -o $HOME/.config/starship.toml

echo "complete..."

# sheldon
echo ""
echo "#"
echo "# sheldon settings..."
echo "#"

curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

mkdir -p $HOME/.config/sheldon

curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/sheldon.toml -o $HOME/.config/sheldon/plugins.toml

echo "complete..."

# eza
echo ""
echo "#"
echo "# eza settings..."
echo "#"

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "complete..."

# git
echo ""
echo "#"
echo "# Git settings..."
echo "#"

git config --global core.ignorecase false

echo "complete..."

# Enabling zsh as the default shell
echo ""
echo "#"
echo "# Enabling zsh as the default shell..."
echo "#"
chsh -s /bin/zsh

echo "complete..."

### Complete
echo ""
echo "#"
echo "# Setup is complete."
echo "#"
