# CLAUDE.md

この Neovim 設定を引き継いで作業するエージェント向けのまとめ。

## 概要
- LazyVim の中身がブラックボックスだったため、ゼロから自作している設定。機能を 1 つずつ足し、ユーザーが触って確かめてから残す
- Neovim 0.13-dev、プラグイン管理は lazy.nvim。いずれユーザーの dotfiles に合流させる
- 対象言語: Python、C / C++、Web (JS / TS / HTML / CSS)、Markdown

## 構成
- `init.lua`: `lua/config/` を順に読み込む
- `lua/config/`: `options.lua` (基本設定)、`keymaps.lua` (最小限のキー)、`autocmds.lua`、`lazy.lua` (lazy.nvim の bootstrap と setup)
- `lua/plugins/`: 1 機能 1 ファイル。外すときはファイルを消して `Lazy! clean`
- `lazy-lock.json`: git で管理する
- 資料 (日本語):
  - `BACKLOG.md`: 後回しにしたもの (途中まで試したもの / 未着手)、上流待ちの回避策、将来の乗り換え、試用して外したもの
  - `KEYMAPS.md`: 使えるキーの一覧 (出どころ付き)
  - `DEPENDENCIES.md`: 設定の外で導入が必要なもの (apt、Node、フォントなど) と、Mason や Treesitter が自動で入れるもの

## 現状 (導入済み)
- 配色: monokai-pro (`colorscheme.lua`)
- LSP: mason + nvim-lspconfig + mason-lspconfig + lazydev (`mason.lua`、`lsp.lua`)。サーバーは lua_ls、basedpyright、ruff、clangd、vtsls、html、cssls、marksman
- Treesitter: nvim-treesitter main ブランチ (`treesitter.lua`)。折りたたみも Treesitter
- 補完: blink.cmp (`completion.lua`)
- 整形: conform.nvim、保存時に自動 (`format.lua`)
- snacks.nvim: picker、lazygit、notifier、input (`snacks.lua`)
- oil.nvim (`oil.lua`)、claudecode.nvim (`claudecode.lua`)
- Git: gitsigns.nvim (`gitsigns.lua`)、codediff.nvim (`codediff.lua`)
- UI: which-key.nvim (`which-key.lua`)、lualine.nvim (`lualine.lua`)、noice.nvim (`noice.lua`)
- 編集: mini.pairs (`pairs.lua`)。Python の括弧内インデントは `options.lua` の `vim.g.python_indent`

## 作業の決まり
- 機能は 1 つずつ足す。流れは次のとおり
  1. 計画を示し、承認をもらう
  2. 実装し、自動で検証する
  3. ユーザー向けの確認手順を示す (どのファイルで何を押すと何が起きれば OK か)
  4. ユーザーが触り、残すか外すか後回しにするかを決める
  5. 承認をもらってからコミットする
- 外したもの、後回しにしたものは、理由と分かったことを `BACKLOG.md` に書く
- キーを足したら `KEYMAPS.md`、設定の外で導入が必要なものを足したら `DEPENDENCIES.md` を更新する
- 試用サンプルは `playground/<段階名>/` に置く (`.gitignore` 済み)。試用が終わったら、ユーザーに確認してから消す
- コードのコメントとキーの desc は英語で短く。資料は日本語
- コミットメッセージは英語の Conventional Commits を 1 行 (本文なし)。push は依頼があるまでしない (今は remote なし)
- 説明は文章で書く。図 (SVG、ASCII) は使わない
- プラグインを選ぶ前に、GitHub で保守状況 (最終更新、archive の有無) を確かめる

## 検証の手法
- 起動: `nvim --headless +qa` でエラーが出ないこと。新しいプラグインの導入は `nvim --headless "+Lazy! install" +qa`
- `Lazy! sync` は既存のプラグインも更新して `lazy-lock.json` を書き換えるので、更新したいときだけ使う
- 状態: `nvim --headless "+checkhealth <名前>" ...` (VeryLazy で読み込むプラグインは headless では出ないことがある)
- 起動時間: `nvim --headless --startuptime <ログ> +qa` で書き出したログを読む (headless では `require("lazy").stats().startuptime` が 0 になる)
- Lua の整形チェック: stylua は PATH にないので `~/.local/share/nvim/mason/bin/stylua --check <ファイル>` (設定は `.stylua.toml`)
- 実際の画面での確認: `nvim --headless --clean -c "set columns=100 lines=30" -c "luafile <script>"` で外側の nvim を起動する。script では `vim.fn.jobstart({ "nvim", "-n", <file> }, { term = true })` で内側の nvim を端末バッファに起動し、`vim.fn.chansend` でキーを送り、`nvim_buf_get_lines` で画面を読む
- 注意: `nvim_feedkeys` による headless の確認は、実際の挙動と違うことがある (例: mini.pairs の `\(` は headless では閉じたが、実画面では閉じない)。キー操作の確認は実画面の方法を優先する

## 次の作業 (順不同)
- 仕上げ
  - `DEPENDENCIES.md` の各「確認」コマンドを実行し、記述が今の設定と合っているか確かめる
  - 全体の確認: 起動時のエラー、`:checkhealth` の警告、起動時間
  - push 先と、dotfiles への合流方法をユーザーと決める
- `BACKLOG.md` の候補から、ユーザーが選んだものを上の流れで 1 つずつ進める。詳しい調査結果と設定案は各節にある
  - 途中まで試したもの: flash.nvim、mini.surround、mini.ai、Markdown のブラウザプレビュー (live-preview.nvim 推奨)、シェル / JSON / YAML / TOML の LSP
  - 未着手: LaTeX、DAP、おすすめキーマップ、snacks.nvim の他の機能、その他の候補
  - 将来の乗り換え: noice.nvim から ui2 (きっかけの条件は BACKLOG に記載)
