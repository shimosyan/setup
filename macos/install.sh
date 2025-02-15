#!/bin/sh

# 隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -boolean true
# 補足: 元に戻す場合
#defaults delete com.apple.finder AppleShowAllFiles

# 共有フォルダで .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
# 補足: 元に戻す場合
#defaults write com.apple.desktopservices DSDontWriteNetworkStores false

### Homebrew
sudo chown -R $(whoami):admin /usr/local
sudo chmod -R g+w /usr/local

xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install git
brew install curl
brew install docker
brew install zplug
brew install fzy
brew install jq
brew install awscli
brew install openssl
brew install anyenv

brew install clipy
brew install 1password
brew install visual-studio-code
brew install google-chrome
brew install iterm2
brew install github
brew install google-japanese-ime
brew install google-backup-and-sync
brew install postman

### git
git config --global core.ignorecase false

### Anyenv
anyenv install --init
anyenv install pyenv
anyenv install nodenv
anyenv install tfenv

echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

exec $SHELL -l

pyenv install 3.9.5
nodenv install 16.15.0
nodenv global 16.15.0

### Reboot
reboot
