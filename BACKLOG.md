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

## 試用して外したもの

(なし)
