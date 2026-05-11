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

  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "complete..."
fi

echo ""
echo "#"
echo "# Updating homebrew..."
echo "#"
brew update
echo "complete..."

brew_install(){
  echo ""
  echo "#"
  echo "# Pull Brew Bundle file..."
  echo "#"
  curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.Brewfile -o $HOME/.Brewfile
  echo "complete..."

  echo ""
  echo "#"
  echo "# Brew Install from Bundle file..."
  echo "#"
  brew bundle --global
  echo "complete..."
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
echo "complete..."

### zsh

echo ""
echo "#"
echo "# zsh settings..."
echo "#"
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/.zshrc -o $HOME/.zshrc
echo "complete..."

### starship

echo ""
echo "#"
echo "# starship settings..."
echo "#"
mkdir -p $HOME/.config
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/starship.toml -o $HOME/.config/starship.toml
echo "complete..."

### sheldon

echo ""
echo "#"
echo "# sheldon settings..."
echo "#"
mkdir -p $HOME/.config/sheldon
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/sheldon.toml -o $HOME/.config/sheldon/plugins.toml
echo "complete..."

### mise
echo ""
echo "#"
echo "# mise settings..."
echo "#"
mkdir -p $HOME/.config/mise
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/mise.toml -o $HOME/.config/mise/config.toml
/opt/homebrew/bin/mise install
echo "complete..."

### macOS Settings
echo ""
echo "#"
echo "# macOS settings..."
echo "#"

# 隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true
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

# Dock の位置を左側に変更
defaults write com.apple.dock orientation -string "left"

# Dock を再起動
killall Dock

echo "complete..."

### git
echo ""
echo "#"
echo "# Git settings..."
echo "#"
git config --global core.ignorecase false
echo "complete..."

### Karabiner Elements
echo ""
echo "#"
echo "# Karabiner Elements settings..."
echo "#"
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/karabiner.json -o $HOME/.config/karabiner/karabiner.json
echo "complete..."

### Complete
echo ""
echo "#"
echo "# Setup is complete."
echo "#"
