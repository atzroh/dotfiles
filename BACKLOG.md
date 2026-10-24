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

### snacks.nvim の他の機能
- 段階 7 では picker だけを有効にした。どれも `lua/plugins/snacks.lua` の `opts` に `<名前> = { enabled = true }` を足せば使える
- 他の段階と関係するもの:
  - lazygit: 段階 11 で試用
  - terminal: 段階 9 の claudecode.nvim が Claude Code を開くのに使う
  - notifier (通知の浮動表示)、input (`grn` などの入力欄の浮動表示): 段階 15 の noice / ui2 の比較で一緒に試す
  - toggle (設定の on/off キー): 段階 13 の which-key と合わせて検討
- おすすめ (試用候補):
  - indent: インデントの縦線と、今いるブロックの強調
  - words: カーソル下の変数の参照箇所を強調し、`]]` / `[[` で移動
  - bigfile: 巨大なファイルを開いたとき重い機能を自動で止める (普段は見えない保険)
- その他の候補:
  - scope: 今いるブロックをテキストオブジェクト (`ii` / `ai`) として扱う
  - dashboard: 起動画面
  - statuscolumn: 行番号・記号欄・折りたたみ表示を整える
  - scroll: スクロールを滑らかにする
  - quickfile: `nvim ファイル名` でプラグインより先にファイルを表示する
  - bufdelete: ウィンドウの配置を崩さずにバッファを閉じる
  - scratch: 使い捨てのメモ用バッファ
  - zen / dim: 集中モード / 今いるブロック以外を暗くする
  - gitbrowse: 今のファイルや行を GitHub などでブラウザに開く
  - gh: GitHub CLI 連携 (Issue や PR を Neovim 内で見る)
  - rename: ファイル名の変更を LSP 経由で import などに反映
  - image: 画像を Neovim 内に表示 (Ghostty は対応。PNG 以外は ImageMagick が必要)
  - profiler: Lua 処理の遅い箇所を調べる
- 対象外: explorer (ファイル操作は oil.nvim を選んだため)

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
  1. ~~**LSP 以外のツールの自動導入方法**~~: 段階 4 で決定。`lua/plugins/mason.lua` の `tools` に書けば自動で入る (mason-registry を使う自前のループ)。shellcheck はそこに足せばよい
  2. **yamlls: 隠しフォルダの下ではスキーマが自動で割り当てられない**: SchemaStore の fileMatch (`**/.github/workflows/*.yml`) の `**` が、`~/.config` のような隠しフォルダを含むパスに一致しない (yaml-language-server 2.0.0 で確認)。dotfiles を `~/.dotfiles` のような隠しフォルダに置くと影響する。回避策はファイル先頭に `# yaml-language-server: $schema=<URL>` を書くこと
  3. **taplo: SchemaStore のカタログを読めない**: taplo 自身のカタログ取得が形式の不一致で失敗する (`failed to fetch catalog`)。SchemaStore.nvim の TOML 用エントリ (186 件) を taplo の `associations` (正規表現) に変換すれば動くことは確認済み。ただし、変換処理を自前で持つことになる
  4. **起動時間**: JSON ファイルを開いたときの起動時間が約 80 ms (Python は約 65 ms)。SchemaStore.nvim の読み込み分
  5. **ネットワーク依存**: スキーマは各サーバーがネットワーク経由で取得するため、オフラインでは検証が効かない
  6. **Mason 導入時の npm の警告**: npm から「install scripts blocked because they are not covered by allowScripts」と出た。導入されたサーバーは動いたが、どのパッケージで何が省かれたかは未確認
  7. ~~**シェルの整形**~~: 段階 6 で shfmt を入れ直し、conform で整形するようにした (TOML も taplo で整形済み)
- 試用サンプルは `playground/lsp/` に残してある (`sample.sh`、`package.json`、`.github/workflows/ci.yml`、`pyproject.toml`)

## 回避策 (上流の修正待ち)

### blink.cmp が LSP の itemDefaults.data を合成しない
- 症状: basedpyright の補完候補で説明 (ドキュメント) が表示されない。ホバー (`K`) では表示される
- 原因: Neovim が `applyKindSupport` を有効にしているため、basedpyright は候補に共通の `data` (uri、position) を `itemDefaults` にまとめ、「各候補に合成する」指定 (applyKind) で送る。blink.cmp (v1.10.2、main も同じ) は候補に `data` があると合成せずに上書きしないため、resolve に必要な uri が欠け、説明が返らない
- 回避策: `lua/plugins/lsp.lua` で全サーバーに `applyKindSupport = false` を伝え、`data` を候補ごとに付けさせている
- 外す条件: blink.cmp が applyKind (merge) に対応したら、この設定を消して basedpyright の補完で説明が出るか確認する

## 試用して外したもの

(なし)
