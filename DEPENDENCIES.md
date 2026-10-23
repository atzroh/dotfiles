# DEPENDENCIES

この設定を別の環境で使うときに、設定ファイルとは別に導入が必要なもの。
Ubuntu 26.04 を前提とする。導入後は Neovim で `:checkhealth` を実行して確認する。

状態: 使用中 = 現在の設定で使う / 予定 = 今後の段階で使う予定 (段階が進んだら更新)

## 本体

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| Neovim >= 0.12 | 本体 | 使用中 | `sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt install neovim` | `nvim --version` |
| git | lazy.nvim によるプラグイン取得 | 予定 | `sudo apt install git` | `git --version` |

## システムパッケージ

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| wl-clipboard | OS クリップボード連携 (Wayland)。無い場合は xsel / xclip (XWayland 経由) が使われる | 使用中 | `sudo apt install wl-clipboard` | `:checkhealth vim.provider` の Clipboard 欄 |
| ripgrep | picker の grep | 予定 | `sudo apt install ripgrep` | `rg --version` |
| fd-find | picker のファイル検索 | 予定 | `sudo apt install fd-find` | `fdfind --version` |
| gcc, make | Treesitter パーサーのビルド | 予定 | `sudo apt install build-essential` | `gcc --version` |
| curl, unzip, tar, gzip | Mason のダウンロード・展開 | 予定 | `sudo apt install curl unzip tar gzip` | - |

## 実行環境 (Mason が LSP サーバー等を入れるときに使う)

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| Node.js + npm | npm 製のサーバー (vtsls, html, cssls など) | 予定 | `fnm install --lts` | `node --version` |
| python3 + venv | pip 製のツール | 予定 | `sudo apt install python3 python3-venv` | `python3 -m venv --help` |

## その他

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| Nerd Font | アイコン表示 | 予定 | JetBrainsMono Nerd Font を `~/.local/share/fonts` に置き `fc-cache -f`、端末のフォントに設定 | `fc-list \| grep -i nerd` |
| lazygit | lazygit 連携 (試用) | 予定 | GitHub Releases のバイナリを `/usr/local/bin` に置く | `lazygit --version` |
| Claude Code | claudecode.nvim | 予定 | `curl -fsSL https://claude.ai/install.sh \| bash` | `claude --version` |
