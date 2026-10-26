# BACKLOG

後回しにした機能と、試用して外したものの記録。

## 後回し (途中まで試したもの)

### flash.nvim (段階 16 で途中まで試用)
- ラベルで画面内の好きな場所へ移動するプラグイン。途中まで試して後回しにした (2026-10-25)
- 試した設定 (README のまま): `s` 移動、`S` Treesitter の構文のまとまりを選択、`r` (オペレーター) 離れた場所を操作して戻る、`R` 検索した文字を含むまとまりを選択、`<C-s>` (`/` 検索中) 検索にラベルを付ける / 外す。`f` / `t` も行をまたぐようになる
- 分かったこと:
  - `S` と `R` は Treesitter のパーサーがあるファイル (Python など) でだけ動く。`.txt` では何も起きない
  - `<C-s>` は押した直後にラベルが描かれず、次のキーで表示される (Neovim 0.13-dev で確認)。`toggle()` のあとに `vim.schedule(function() vim.cmd.redraw() end)` を足すと直る
  - `<C-s>` のオン / オフは以後の `/` 検索すべてに引き継がれる
  - Vim 標準の `s` / `S` は `cl` / `cc` で代用する
- 戻すなら: mini.surround を入れるときは `gs` 始まりにすれば `s` と衝突しない

### mini.surround (段階 17 で途中まで試用)
- 括弧、引用符、タグ、関数呼び出しなどの囲みを付ける / 外す / 取り替えるプラグイン (vim-surround と同じ考え方)。途中まで試して後回しにした (2026-10-25)
- 試した設定: `nvim-mini/mini.surround` を `keys` で遅延読み込みし、`opts.mappings` で LazyVim と同じ `gs` 始まりに割り当てた (`gsa` 付ける、`gsd` 外す、`gsr` 取り替える、`gsf` / `gsF` 右 / 左の囲みへ移動、`gsh` 強調、`gsn` 探す行数の変更)。which-key に `{ "gs", group = "Surround" }` を足した
- 自動検証で動いたもの: `gsr"'`、`gsd'`、`gsaiw"`、`gsd(` (内側の空白も消える)、`gsdf` (関数名と括弧を外す)、ビジュアル選択からの `gsa)`、`gsdn}` (次の囲み)

### mini.ai (段階 19 で説明まで)
- `ci(` や `da"` のような a / i の範囲指定を広げるプラグイン。導入前に後回しにした (2026-10-26)
- できること:
  - カーソルが対象の中になくても、同じ行や近くの行から次の対象を探す (`print("hello")` の行頭で `ci"` が効く)
  - 対象が増える: `af` / `if` 関数呼び出し、`aa` / `ia` 引数 1 つ、`ab` / `ib` 一番近い括弧、`aq` / `iq` 一番近い引用符、`a?` / `i?` 区切り文字をその場で指定
- 決めること:
  - `an` / `in`: mini.ai の標準 (「次の〇〇」) は、Neovim 0.12 から組み込まれた「ビジュアルモードで構文の範囲を広げる / 狭める」(`an` / `in`) を上書きする。案は、組み込みを残して `opts.mappings` の `around_next` / `inside_next` を `''` にする (`al` / `il` は使える)
  - 関数定義やクラス: 選ぶには nvim-treesitter-textobjects (main ブランチ、2026-09 更新) の範囲定義が必要。プラグイン自体のキーは使わず、`MiniAi.gen_spec.treesitter()` で使う。案は `aF` / `iF` 関数定義、`ac` / `ic` クラス (`af` は標準どおり関数呼び出し)

### Markdown のブラウザプレビュー (段階 20 で計画まで)
- 計画を立てたところで後回しにした (2026-10-26)
- 推奨: live-preview.nvim (`brianhuster/live-preview.nvim`)。v0.9.7 (2026-09) で更新が続いている。Lua だけで動き (Node / Deno 不要)、KaTeX / Mermaid、コードの色分け、スクロール同期に対応。Markdown は保存しなくても更新される
- 設定案: `cmd = "LivePreview"` で遅延読み込み。Markdown のバッファで `<leader>cp` を押すと、`require("livepreview").is_running()` を見て `:LivePreview start` / `:LivePreview close` を切り替える。設定は標準のまま (ブラウザは OS の標準、`127.0.0.1:5500`)。確認は `:checkhealth livepreview`
- 比較した他の候補 (2026-10 時点):
  - markdown-preview.nvim: 最後のコミットが 2023-10。Node でのビルドが必要
  - peek.nvim: 2024-08 で更新が止まっている。Deno が必要

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

## 後回し (未着手)

### LaTeX
- 構成案: VimTeX + Okular (保存で自動コンパイル、ソースと PDF の相互ジャンプ)
- 補完・診断は texlab (Mason)
- 必要なもの: TeX Live (latexmk)。Okular は導入済み

### デバッガ (DAP)
- 構成案: nvim-dap + nvim-dap-view
- アダプタ: debugpy (Python), codelldb (C/C++)。どちらも Mason で導入可

### snacks.nvim の他の機能
- 有効にしているのは picker、lazygit、notifier、input、dashboard。どれも `lua/plugins/snacks.lua` の `opts` に `<名前> = { enabled = true }` を足せば使える (dashboard は設定が長いので `lua/plugins/dashboard.lua` に分けた)
- terminal は claudecode.nvim が Claude Code を開くのに使っている
- dashboard で分かったこと:
  - 試して採らなかった構成: キー一覧を縦に並べる既定の形、最近のファイル / プロジェクト / git status を右の列に出す 2 列の形 (横幅 124 列以上が必要)。今は「ロゴ + 1 行のキー案内」にしている。公式の例は snacks の `docs/dashboard.md` の Examples
  - monokai-pro は `NonText` の文字色を背景色にしている。snacks の `dir` (最近のファイル一覧のディレクトリ部分) はこれを参照するので見えなくなる。一覧を出すときは `SnacksDashboardDir` の色を指定する
  - `preset.keys` を関数にすると、コメントでは既定のキーが渡るとあるが、実際にはダッシュボード自体が渡ってエラーになる。キーを足すときは自分で一覧を書く
  - 前の LazyVim 構成のロゴが青かったのは、配色 0x96f が `SnacksDashboardHeader` を青にしていたため
- おすすめ (試用候補):
  - indent: インデントの縦線と、今いるブロックの強調
  - words: カーソル下の変数の参照箇所を強調し、`]]` / `[[` で移動
  - bigfile: 巨大なファイルを開いたとき重い機能を自動で止める (普段は見えない保険)
- その他の候補:
  - toggle: 設定の on/off キー (which-key に状態が表示される)
  - scope: 今いるブロックをテキストオブジェクト (`ii` / `ai`) として扱う
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
- 対象外: explorer (ファイラーは neo-tree.nvim を選んだため)

### その他の候補
- Copilot インライン補完 (0.12 のネイティブ LSP inline completion)
- codecompanion.nvim
- neogit
- nvim-lint
- trouble.nvim
- render-markdown.nvim
- vim.pack への移行
- Makefile 用 LSP (autotools_ls): 少数派なので見送り

## 回避策 (上流の修正待ち)

### blink.cmp が LSP の itemDefaults.data を合成しない
- 症状: basedpyright の補完候補で説明 (ドキュメント) が表示されない。ホバー (`K`) では表示される
- 原因: Neovim が `applyKindSupport` を有効にしているため、basedpyright は候補に共通の `data` (uri、position) を `itemDefaults` にまとめ、「各候補に合成する」指定 (applyKind) で送る。blink.cmp (v1.10.2、main も同じ) は候補に `data` があると合成せずに上書きしないため、resolve に必要な uri が欠け、説明が返らない
- 回避策: `lua/plugins/lsp.lua` で全サーバーに `applyKindSupport = false` を伝え、`data` を候補ごとに付けさせている
- 外す条件: blink.cmp が applyKind (merge) に対応したら、この設定を消して basedpyright の補完で説明が出るか確認する

## 将来の乗り換え

### noice.nvim から組み込みの ui2 へ (段階 15 で決定、2026-10-25)
- 今は noice.nvim (`lua/plugins/noice.lua`) を使い、将来 Neovim 組み込みの ui2 に乗り換える
- noice を選んだ理由: LazyVim と同じ見た目と動き (`:` を中央に浮かせる、`:echo` などを右上の通知に出す、長い出力を分割ウィンドウに出す) が設定数行で手に入るため。ui2 で同じことをすると、ui2 の内部に頼る自作コードが増える
- 乗り換える理由: noice は 2025-11 から更新がなく、2026 年の不具合報告の多くが「対応しない」で閉じられている (Neovim 0.12.1 で `:` を押すと落ちる報告なども含む)。Neovim はメッセージ表示を ui2 へ作り直している最中で、ui2 が今後の標準になる
- 乗り換えのきっかけ (どれか 1 つで検討する):
  - Neovim の更新後に noice が壊れた (`:` で落ちる、メッセージが出ないなど)
  - ui2 が実験的な機能でなくなった、または Neovim の標準で有効になった
  - ui2 の公式の設定だけで、`:` のコマンドラインを浮かせられるようになった
- 乗り換え方 (段階 15 で試して分かったこと):
  - noice と ui2 は同時に使えない。`lua/plugins/noice.lua` を消し、`:Lazy clean` で noice と nui.nvim を消す
  - `lua/config/options.lua` で `require("vim._core.ui2").enable({ msg = { targets = { default = "msg", typed_cmd = "cmd" } } })` を呼ぶ。`default = "msg"` でプラグインなどからのメッセージが右下の枠付きウィンドウに出る。`typed_cmd = "cmd"` で、自分で打ったコマンドの出力は画面下に出る (`"msg"` にすると右下の枠に出るが、長い出力が画面の半分で切れる)
  - `cmdheight = 0` にすると、コマンドラインの行を普段は隠せる。その場合、マクロ記録中の表示は lualine の `recording @q` で補う (設定済み)
  - `:` のコマンドラインを浮かせるには、CmdlineEnter / CmdlineLeave の autocmd で `require("vim._core.ui2").wins.cmd` のウィンドウ設定 (`relative = "editor"`、枠、見出し) を変え、抜けたら `relative = "laststatus"`、`row = 1`、`col = 0`、`width = 10000` に戻す。blink.cmp の候補一覧を枠の下に出すには `vim.g.ui_cmdline_pos = { 枠の行 + 3, 枠の列 + 1 }` を設定する。ui2 の内部に頼るので、乗り換え時点の ui2 の作りを確認すること
  - ui2 は画面がつながっていないと有効にならないため、headless では確認できない。疑似端末 (`script`) で画面付きの Neovim を起動して確かめる
  - snacks の notifier / input はそのまま使える (通知は右上、入力欄は浮動ウィンドウ)
  - `K` の説明表示と引数の説明は、noice に任せず Neovim 標準 / blink.cmp にしてあるので、乗り換えても変わらない
- 乗り換えたら、Neovim を更新するたびに `:h news` の ui2 の項目を確認する (0.13 で `pager_char` などが `'messagesopt'` に移ったように、設定の書き方が変わることがある)

## 試用して外したもの

### oil.nvim
- フォルダをバッファとして開き、編集して `:w` で確定するファイラー。neo-tree.nvim に置き換えた (2026-10-26)
- 外した理由: 一度に 1 つのフォルダしか見えず、Git の状態も出せないため。木構造で全体を見渡し、Git の状態を見たかった
- 利点 (戻すときの判断材料): 名前の変更や移動を Vim の編集操作でまとめて行える、ゴミ箱に送る、サイドバーを持たない
- Git の状態を出す拡張: malewicz1337/oil-git.nvim (ファイル名の色分け、2026-10 更新、star 48) と refractalize/oil-git-status.nvim (`git status --short` の 2 文字を記号欄に表示、2026-02 更新、star 158)
- 戻すなら: `{ "stevearc/oil.nvim", lazy = false, keys = { { "-", "<Cmd>Oil<CR>" } }, opts = { delete_to_trash = true, view_options = { show_hidden = true } } }`。lualine の extensions に `"oil"` を戻す

### diffview-plus.nvim (段階 12)
- 元の diffview.nvim (2024-06 で更新停止) の保守されている派生版。codediff.nvim と比べて、codediff を残した
- 外した理由: codediff の方が、Claude Code が変更している最中も差分が更新される点、文字単位の強調、stage や履歴まで 1 画面で扱える点で優れていたため
- 戻すなら: `{ "dlyongemallo/diffview-plus.nvim", version = "*", cmd = { "DiffviewOpen", "DiffviewFileHistory" } }`。バイナリのダウンロードが不要な点は diffview-plus の利点
