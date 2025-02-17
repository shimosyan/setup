#!/bin/sh

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

if test ! $(which brew); then
  echo "Installing homebrew..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating homebrew..."
brew update

brew install git
brew install curl
brew install docker
brew install zplug
brew install fzy
brew install jq
brew install awscli
brew install openssl
brew install anyenv

brew install karabiner-elements

brew install google-chrome
brew install 1password
brew install visual-studio-code
brew install iterm2
brew install clipy
brew install github
brew install google-japanese-ime
brew install google-backup-and-sync
brew install postman

echo "Cleaning up brew"
brew cleanup

### git
git config --global core.ignorecase false

### Karabiner Elements
# macOS 設定 → キーボード → キーボードショートカット → 入力ソース内にある「前の入力ソースを選択」を"F13"に設定すること
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/karabiner.json -o ~/.config/karabiner/karabiner.json

### Anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.zprofile
echo 'eval "$(anyenv init -)"' >> ~/.zprofile
eval "$(anyenv init -)"

anyenv install --init
anyenv install pyenv
anyenv install nodenv
anyenv install tfenv

exec $SHELL -l

pyenv install 3.9.5
nodenv install 16.15.0
nodenv global 16.15.0

### zsh
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.zshrc -o ~/.zshrc

### Reboot
sudo shutdown -r now
