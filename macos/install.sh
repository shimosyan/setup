#!/bin/bash

### Homebrew
export PATH="/opt/homebrew/bin:$PATH"

if test ! $(which brew); then
  echo ""
  echo "#"
  echo "# Installing homebrew..."
  echo "#"
  sudo chown -R $(whoami):admin /usr/local
  sudo chmod -R g+w /usr/local

  xcode-select --install

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

brew_install(){
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
}

# プロセスをバックグラウンドで起動
brew_install &
pid1=$!

# プロセスの終了を待つ
wait $pid1

echo ""
echo "#"
echo "# Cleaning up brew"
echo "#"
brew cleanup

### zsh

echo ""
echo "#"
echo "# zsh settings..."
echo "#"
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.zshrc -o $HOME/.zshrc
chmod 755 /usr/local/share/zsh/site-functions
chmod 755 /usr/local/share/zsh

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

## 未確認のアプリケーションを実行する際のダイアログを無効にする
defaults write com.apple.LaunchServices LSQuarantine -bool false 

# マウスポインタの移動速度を変更
defaults write -g com.apple.mouse.scaling 0.6875

# Fnキーを標準のファンクションキーとして使用
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# バッテリー残量を％表記に
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# 日付と時刻のフォーマット（24時間表示、秒表示あり、日付・曜日を表示）
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDate -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowSeconds -bool true

# Dock のアプリ提案を無効化
defaults write com.apple.dock show-recents -bool false

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
