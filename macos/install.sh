#!/bin/bash
set -euo pipefail

SKIP_BREW_UPDATE="${SKIP_BREW_UPDATE:-0}"
DEBUG="${DEBUG:-0}"

if [[ "$DEBUG" == "1" ]]; then
  set -x
fi

log() {
  echo ""
  echo "#"
  echo "# $1"
  echo "#"
}

download_config() {
  local url="$1"
  local dest="$2"

  local dir
  dir="$(dirname "$dest")"

  mkdir -p "$dir"

  if [[ -f "$dest" ]]; then
    mv "$dest" "$dest.backup"
  fi

  curl -fsSL "$url" -o "$dest"
}

### sudo keep-alive
sudo -v

while true; do
  sudo -n true
  sleep 30
  kill -0 "$$" || exit
done 2>/dev/null &

SUDO_KEEPALIVE_PID=$!

cleanup() {
  if kill -0 "$SUDO_KEEPALIVE_PID" >/dev/null 2>&1; then
    kill "$SUDO_KEEPALIVE_PID" >/dev/null 2>&1 || true
    wait "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
  fi

  [[ -f "${BREWFILE:-}" ]] && rm -f "$BREWFILE"
}

trap cleanup EXIT

### Homebrew
if [[ "$(uname -m)" == "arm64" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
else
  export PATH="/usr/local/bin:$PATH"
fi

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export NONINTERACTIVE=1

if ! command -v brew >/dev/null 2>&1; then
  log "Installing homebrew..."

  if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install

    for i in {1..120}; do
      if xcode-select -p >/dev/null 2>&1; then
        break
      fi
      sleep 5
    done

    if ! xcode-select -p >/dev/null 2>&1; then
      echo "Xcode Command Line Tools installation timed out."
      exit 1
    fi
  fi

  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(brew shellenv)"
  echo "complete..."
fi

if [[ "$SKIP_BREW_UPDATE" != "1" ]]; then
  log "Updating homebrew..."
  brew update
  echo "complete..."
fi

log "Pull Brew Bundle file..."
BREWFILE="$(mktemp)"

curl -fsSL \
  https://raw.githubusercontent.com/shimosyan/setup/main/macos/.Brewfile \
  -o "$BREWFILE"

echo "complete..."

log "Brew Install from Bundle file..."
brew bundle --file "$BREWFILE" &
BREW_BUNDLE_PID=$!

wait "$BREW_BUNDLE_PID"

echo "complete..."

log "Cleaning up brew..."
brew cleanup || true
echo "complete..."

### zsh
log "zsh settings..."
download_config \
  "https://raw.githubusercontent.com/shimosyan/setup/main/macos/.zshrc" \
  "$HOME/.zshrc"
echo "complete..."

### starship
log "starship settings..."
download_config \
  "https://raw.githubusercontent.com/shimosyan/setup/main/starship.toml" \
  "$HOME/.config/starship.toml"
echo "complete..."

### sheldon
log "sheldon settings..."
download_config \
  "https://raw.githubusercontent.com/shimosyan/setup/main/sheldon.toml" \
  "$HOME/.config/sheldon/plugins.toml"
echo "complete..."

### mise
log "mise settings..."
download_config \
  "https://raw.githubusercontent.com/shimosyan/setup/main/mise.toml" \
  "$HOME/.config/mise/config.toml"
if command -v mise >/dev/null 2>&1; then
  mise install
fi
echo "complete..."

### macOS Settings
log "macOS settings..."

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

# Finder, Dock を再起動
killall Finder || true
killall Dock || true

echo "complete..."

### git
log "Git settings..."
git config --global core.ignorecase false
echo "complete..."

### Karabiner Elements
log "Karabiner Elements settings..."
download_config \
  "https://raw.githubusercontent.com/shimosyan/setup/main/macos/karabiner.json" \
  "$HOME/.config/karabiner/karabiner.json"
echo "complete..."

### Complete
log "Setup is complete."
echo ""
echo "Run the following command:"
echo "source ~/.zshrc"
echo ""
echo "Some macOS settings may require logout or reboot."
