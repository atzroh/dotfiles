# DEPENDENCIES

この設定を別の環境で使うときに、設定ファイルとは別に導入が必要なもの。
Ubuntu 26.04 を前提とする。導入後は Neovim で `:checkhealth` を実行して確認する。

状態: 使用中 = 現在の設定で使う / 予定 = 今後の段階で使う予定 (段階が進んだら更新)

## 本体

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| Neovim >= 0.12 | 本体 | 使用中 | `sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt install neovim` | `nvim --version` |
| git | lazy.nvim によるプラグイン取得 (初回起動時に lazy.nvim 自体も clone する) | 使用中 | `sudo apt install git` | `git --version` |

## システムパッケージ

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| wl-clipboard | OS クリップボード連携 (Wayland)。無い場合は xsel / xclip (XWayland 経由) が使われる | 使用中 | `sudo apt install wl-clipboard` | `:checkhealth vim.provider` の Clipboard 欄 |
| ripgrep | picker の grep | 予定 | `sudo apt install ripgrep` | `rg --version` |
| fd-find | picker のファイル検索 | 予定 | `sudo apt install fd-find` | `fdfind --version` |
| gcc (C コンパイラ) | Treesitter パーサーのビルド | 使用中 | `sudo apt install build-essential` | `:checkhealth nvim-treesitter` |
| curl, unzip, tar, gzip | Mason のダウンロード・展開、Treesitter パーサーの取得、blink.cmp のビルド済みバイナリの取得 | 使用中 | `sudo apt install curl unzip tar gzip` | `:checkhealth mason` |

## 実行環境 (Mason が LSP サーバー等を入れるときに使う)

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| Node.js + npm | npm 製のサーバー (vtsls, html-lsp, css-lsp) | 使用中 | `fnm install --lts` | `node --version` |
| python3 + venv | pip 製のサーバー (basedpyright) | 使用中 | `sudo apt install python3 python3-venv` | `python3 -m venv --help` |

## Mason が自動で入れるもの (手作業は不要)

`lua/plugins/lsp.lua` の `servers` に書いたものは、初回にファイルを開いたとき自動で導入される。
導入先は `~/.local/share/nvim/mason/`。状態は `:Mason` で確認できる。

| サーバー | 言語 | 取得元 |
|---|---|---|
| lua_ls | Lua | GitHub Releases |
| basedpyright | Python (型チェック、補完) | PyPI |
| ruff | Python (lint) | GitHub Releases |
| clangd | C / C++ | GitHub Releases |
| vtsls | JavaScript / TypeScript | npm |
| html, cssls | HTML / CSS | npm |
| marksman | Markdown | GitHub Releases |

LSP 以外のツールは `lua/plugins/mason.lua` の `tools` に書き、起動時に自動で導入される。

| ツール | 用途 | 取得元 |
|---|---|---|
| tree-sitter-cli | Treesitter パーサーのビルド (0.26.1 以上が必要。apt 版は 0.25 で古い) | GitHub Releases |
| stylua | Lua の整形 (設定は `.stylua.toml`) | GitHub Releases |
| clang-format | C / C++ の整形 | PyPI |
| prettierd | JS / TS / HTML / CSS / JSON / YAML / Markdown の整形 | npm |
| shfmt | シェルスクリプトの整形 | GitHub Releases |
| taplo | TOML の整形 | GitHub Releases |

Python の整形には、LSP サーバーとして入れた ruff をそのまま使う。

## Treesitter パーサー (手作業は不要)

`lua/plugins/treesitter.lua` の `parsers` に書いたものは、tree-sitter-cli が使えるようになった時点で自動で導入される。
導入先は `~/.local/share/nvim/site/parser/`。新しい PC では、初回起動で Mason が tree-sitter-cli を入れ、続けてパーサーがビルドされる。

## その他

| 名前 | 用途 | 状態 | 導入方法 | 確認 |
|---|---|---|---|---|
| Nerd Font | アイコン表示 | 予定 | JetBrainsMono Nerd Font を `~/.local/share/fonts` に置き `fc-cache -f`、端末のフォントに設定 | `fc-list \| grep -i nerd` |
| lazygit | lazygit 連携 (試用) | 予定 | GitHub Releases のバイナリを `/usr/local/bin` に置く | `lazygit --version` |
| Claude Code | claudecode.nvim | 予定 | `curl -fsSL https://claude.ai/install.sh \| bash` | `claude --version` |
