# Setup

## macOS

zsh の環境をセットアップする

下記コマンドを実機のターミナルにコピペして実行

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/macos/install.sh | sh -s
```

**注意事項:**

上記スクリプトは Homebrew を使うが、Homebrew でインストールするアプリケーションが既に導入済みの環境の場合はスクリプトがエラーになる可能性がある。そのため、下記で例を挙げた環境変数コマンドで特定のアプリケーションを除外するようにしておくこと

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

スクリプトの実行が終わったら、下記の設定を変更すること

### iTerm2

フォントの設定を変更する

Settings → Profiles → Text → Font にて "RobotoMono Nerd Font" に変更する

### Karabiner-Elements

macOS 設定 → キーボード → キーボードショートカット → 入力ソース内にある「前の入力ソースを選択」を"F13"に設定すること

### Maccy

環境設定で以下の項目を変更すること

- "自動起動" を有効化
- "開く" のショートカットを `Command + Shift + V` に変更
- "動作" の`自動的に貼り付け`を有効化 & Mac のアクセシビリティに Maccy を許可

## Windows

### Powershell

PowerShell 7.x 系の環境をセットアップする

下記コマンドを実機の Microsoft PowerShell（PowerShell 5.x 系）もしくは PowerShell 7.x 系にコピペして実行

```powershell
function Invoke-RemoteScript($url){$script = (New-Object Net.WebClient).DownloadString($url);Invoke-Expression($script)};Invoke-RemoteScript 'https://raw.githubusercontent.com/shimosyan/setup/main/powershell/install.ps1'
```

スクリプトの実行が終わったら、下記の設定を変更すること

### Nerd Font のインストール

[配布先](https://www.nerdfonts.com/font-downloads) から "RobotoMono Nerd Font" をダウンロード＆インストールすること

#### Windows ターミナルの設定変更

設定内の項目を以下の通りに変更

- スタートアップ
  - 既定のプロファイルを "Microsoft PowerShell" から、 PowerShell 7 にあたる "PowerShell"に変更
- プロファイル → PowerShell
  - "外観" からフォントフェイスを "RobotoMono Nerd Font" に変更

---

### WSL2

zsh の環境をセットアップする

下記コマンドを実機のターミナルにコピペして実行

```bash
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/wsl/install.sh | sh -s
```
