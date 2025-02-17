# Setup

## How to Use

### for macOS

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/install.sh | sh -s
```

再起動後に実施

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/anyenv.sh | sh -s
```

#### memo

- macOS 設定 → キーボード → キーボードショートカット → 入力ソース内にある「前の入力ソースを選択」を"F13"に設定すること
- Homebrew でインストールするアプリケーションが既に導入済みの環境の場合はエラーになる可能性があるため下記環境変数コマンドで除外するようにしておくこと
```bash
export HOMEBREW_BUNDLE_BREW_SKIP="foo bar"
export HOMEBREW_BUNDLE_CASK_SKIP="vaz"
export HOMEBREW_BUNDLE_MAS_SKIP="qux"
export HOMEBREW_BUNDLE_TAP_SKIP="quux"
```

### for wsl

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/wsl/install.sh | sh -s
```
