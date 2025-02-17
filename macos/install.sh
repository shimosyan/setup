#!/bin/bash

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

### Homebrew
sudo chown -R $(whoami):admin /usr/local
sudo chmod -R g+w /usr/local

echo "Installing xcode-stuff"
xcode-select --install

export PATH="/opt/homebrew/bin:$PATH"

if test ! $(which brew); then
  echo "Installing homebrew..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating homebrew..."
brew update

echo "Pull Brew Bundle file..."
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.Brewfile -o $HOME/.Brewfile

echo "Brew Install from Bundle file..."
brew bundle --global

echo "Cleaning up brew"
brew cleanup

### zsh
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.zshrc -o $HOME/.zshrc

### git
git config --global core.ignorecase false

### Karabiner Elements
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/karabiner.json -o $HOME/.config/karabiner/karabiner.json

### Anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(anyenv init -)"' >> $HOME/.zprofile
export PATH="$HOME/.anyenv/bin:$PATH"
anyenv init -

anyenv install --force-init
anyenv install pyenv
anyenv install nodenv
anyenv install tfenv

### Reboot
echo "Setup is complete. The machine will restart."
sudo shutdown -r now
