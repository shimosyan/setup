# Setup

## How to Use

挙げたコマンドを実機のターミナルにコピペして実行すること

## for macOS

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/install.sh | sh -s
```

### memo

#### Homebrew

Homebrew でインストールするアプリケーションが既に導入済みの環境の場合はスクリプトがエラーになる可能性がある。そのため、下記で例を挙げた環境変数コマンドで特定のアプリケーションを除外するようにしておくこと

```bash
export HOMEBREW_BUNDLE_BREW_SKIP="foo bar"
export HOMEBREW_BUNDLE_CASK_SKIP="vaz"
export HOMEBREW_BUNDLE_MAS_SKIP="qux"
export HOMEBREW_BUNDLE_TAP_SKIP="quux"
```

例

```bash
export HOMEBREW_BUNDLE_CASK_SKIP="google-chrome 1password"
```

#### iTerm2

フォントの設定を変更すること

Settings → Profiles → Text → Font にて "RobotoMono Nerd Font" に変更する

#### Karabiner-Elements

macOS 設定 → キーボード → キーボードショートカット → 入力ソース内にある「前の入力ソースを選択」を"F13"に設定すること

#### Maccy

環境設定で以下の項目を変更すること

- "自動起動" を有効化
- "開く" のショートカットを `Command + Shift + V` に変更
- "動作" の`自動的に貼り付け`を有効化 & Mac のアクセシビリティに Maccy を許可

## for wsl

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/wsl/install.sh | sh -s
```
