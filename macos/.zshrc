# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

### sheldon
### ZSH Plugins
### .config/sheldon/plugins.toml
if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
fi

### 補完機能を有効化
autoload -Uz compinit
compinit -C

### zoxide
export _ZO_FZF_OPTS='--smart-case'
eval "$(zoxide init zsh)"

# mise
eval "$(mise activate zsh)"

### Git
export PATH="/usr/local/git/bin:$PATH"

### OpenSSL
export PATH="/opt/homebrew/opt/openssl/bin:$PATH"

### curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

### Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

### オプション

# 同時に起動しているzshの間でhistoryを共有する
setopt share_history

# 同じコマンドをhistoryに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンドをhistoryに残さない
setopt hist_ignore_space

# historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# cd無しでもディレクトリ移動
setopt auto_cd

# コマンドのスペルミスを指摘
setopt correct

# タイムスタンプを表示
setopt prompt_subst
TMOUT=1
TRAPALRM() {zle reset-prompt}
RPROMPT="%F{white} %D{%Y-%m-%d %H:%M:%S} %f"

# GPG署名関連の設定
export GPG_TTY=$TTY
