### sheldon
### ZSH Plugins
### .config/sheldon/plugins.toml
export PATH=$PATH:$HOME/.local/bin
if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
fi

### 補完機能を有効化
autoload -Uz compinit
compinit -C

### History 検索をデフォルトの挙動にする
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[OA' up-line-or-history
bindkey '^[OB' down-line-or-history

### starship
eval "$(starship init zsh)"

### ブラウザの設定
export BROWSER='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'

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
