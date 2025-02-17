#!/bin/bash

### Homebrew
echo ""
echo "#"
echo "# Homebrew..."
echo "#"
sudo chown -R $(whoami):admin /usr/local
sudo chmod -R g+w /usr/local

echo "Installing xcode-stuff"
xcode-select --install

export PATH="/opt/homebrew/bin:$PATH"

if test ! $(which brew); then
  echo ""
  echo "#"
  echo "# Installing homebrew..."
  echo "#"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo ""
echo "#"
echo "# Updating homebrew..."
echo "#"
brew update

echo ""
echo "#"
echo "# Pull Brew Bundle file..."
echo "#"
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.Brewfile -o $HOME/.Brewfile

echo ""
echo "#"
echo "Brew Install from Bundle file..."
echo "#"
brew bundle --global

echo ""
echo "#"
echo "# Cleaning up brew"
echo "#"
brew cleanup

### zsh

echo ""
echo "#"
echo "# Pull .zshrc"
echo "#"
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.zshrc -o $HOME/.zshrc

### macOS Settings
echo ""
echo "#"
echo "# macOS settings..."
echo "#"

# 隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -boolean true
# 補足: 元に戻す場合
#defaults delete com.apple.finder AppleShowAllFiles

# 共有フォルダで .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
# 補足: 元に戻す場合
#defaults write com.apple.desktopservices DSDontWriteNetworkStores false

# マウスポインタの移動速度を変更
defaults write -g com.apple.mouse.scaling 0.6875

### git
echo ""
echo "#"
echo "# Git settings..."
echo "#"
git config --global core.ignorecase false

### Karabiner Elements
echo ""
echo "#"
echo "# Karabiner Elements settings..."
echo "#"
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/karabiner.json -o $HOME/.config/karabiner/karabiner.json

### Anyenv
echo ""
echo "#"
echo "# Anyenv settings..."
echo "#"
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(anyenv init -)"' >> $HOME/.zprofile
export PATH="$HOME/.anyenv/bin:$PATH"
anyenv init -

anyenv install --force-init
anyenv install pyenv
anyenv install nodenv
anyenv install tfenv

### Reboot
echo ""
echo "#"
echo "# Setup is complete. The machine will restart."
echo "#"
sudo shutdown -r now
