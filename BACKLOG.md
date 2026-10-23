# BACKLOG

後回しにした機能と、試用して外したものの記録。

## 後回し

### LaTeX
- 構成案: VimTeX + Okular (保存で自動コンパイル、ソースと PDF の相互ジャンプ)
- 補完・診断は texlab (Mason)
- 必要なもの: TeX Live (latexmk)。Okular は導入済み

### デバッガ (DAP)
- 構成案: nvim-dap + nvim-dap-view
- アダプタ: debugpy (Python), codelldb (C/C++)。どちらも Mason で導入可

### おすすめキーマップ
- 現在は最小限 + Neovim 標準キーのみ。LazyVim 互換の候補を後でまとめる
- 候補: ウィンドウ移動 (`<C-h/j/k/l>`), バッファ切替 (`<S-h>`/`<S-l>`), 行移動 (`<A-j>`/`<A-k>`), LSP 系 (`<leader>c*`)

### その他の候補
- Copilot インライン補完 (0.12 のネイティブ LSP inline completion)
- codecompanion.nvim
- neogit
- nvim-lint
- trouble.nvim
- render-markdown.nvim
- vim.pack への移行
- Makefile 用 LSP (autotools_ls): 少数派なので見送り

### シェル / JSON / YAML / TOML の LSP
- 一度実装して動作を確認したが、検討事項が多いため取り消して後回しにした (2026-10-23)
- 構成案 (`lua/plugins/lsp.lua` の `servers` に追加):
  - シェル: bashls + shellcheck (shellcheck は LSP ではない別ツール)
  - JSON: jsonls + SchemaStore.nvim (`package.json`、`tsconfig.json` などのキー補完・検証)
  - YAML: yamlls + SchemaStore.nvim (GitHub Actions、docker-compose など)
  - TOML: taplo (`pyproject.toml`、`Cargo.toml` など)
- 検討すべき問題:
  1. **LSP 以外のツールの自動導入方法**: shellcheck は mason-lspconfig の `ensure_installed` では入らない。mason-registry を使う自前のループか、mason-tool-installer.nvim か。段階 6 の整形ツール (stylua、shfmt など) と合わせて決める
  2. **yamlls: 隠しフォルダの下ではスキーマが自動で割り当てられない**: SchemaStore の fileMatch (`**/.github/workflows/*.yml`) の `**` が、`~/.config` のような隠しフォルダを含むパスに一致しない (yaml-language-server 2.0.0 で確認)。dotfiles を `~/.dotfiles` のような隠しフォルダに置くと影響する。回避策はファイル先頭に `# yaml-language-server: $schema=<URL>` を書くこと
  3. **taplo: SchemaStore のカタログを読めない**: taplo 自身のカタログ取得が形式の不一致で失敗する (`failed to fetch catalog`)。SchemaStore.nvim の TOML 用エントリ (186 件) を taplo の `associations` (正規表現) に変換すれば動くことは確認済み。ただし、変換処理を自前で持つことになる
  4. **起動時間**: JSON ファイルを開いたときの起動時間が約 80 ms (Python は約 65 ms)。SchemaStore.nvim の読み込み分
  5. **ネットワーク依存**: スキーマは各サーバーがネットワーク経由で取得するため、オフラインでは検証が効かない
  6. **Mason 導入時の npm の警告**: npm から「install scripts blocked because they are not covered by allowScripts」と出た。導入されたサーバーは動いたが、どのパッケージで何が省かれたかは未確認
  7. **シェルの整形**: shfmt は段階 3 で残骸として削除した。シェルスクリプトを整形したい場合は段階 6 で入れ直す
- 試用サンプルは `playground/lsp/` に残してある (`sample.sh`、`package.json`、`.github/workflows/ci.yml`、`pyproject.toml`)

## 試用して外したもの

(なし)
