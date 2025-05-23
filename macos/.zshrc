### 補完機能を有効化
autoload -Uz compinit && compinit

### Zplug
# This setting is suitable for Zplug installed by Homebrew
# -> https://qiita.com/b4b4r07/items/f37aadef0b3f740e8c14

# Zplug のパスを指定
# export ZPLUG_HOME=/usr/local/opt/zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/lein", from:oh-my-zsh
zplug "plugins/command", from:oh-my-zsh
zplug "themes/robbyrussell", from:oh-my-zsh, as:theme

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:init.sh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    # No ask confirm install
    #printf "Install? [y/N]: "
    #if read -q; then
    #    echo; zplug install
    #fi
    zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

### Git
export PATH="/usr/local/git/bin:$PATH"

### Anyenv
if [ -e "$HOME/.anyenv" ]
then
    export ANYENV_ROOT="$HOME/.anyenv"
    export PATH="$ANYENV_ROOT/bin:$PATH"
    if command -v anyenv 1>/dev/null 2>&1
    then
        eval "$(anyenv init -)"
    fi
fi

### Brew が Anyenv の python を読み込まないようにする
alias brew="env PATH=${PATH/\/Users\/${USER}\/\.anyenv\/envs\/pyenv\/shims:/} brew"

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
