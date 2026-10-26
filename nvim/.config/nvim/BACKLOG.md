# BACKLOG

Plugins and settings to add.

## Editing

- flash.nvim
  - Jump anywhere on screen by typing a label.
  - Fewer keystrokes than `w` / `f` / `/` for distant targets.
- mini.surround
  - Add / delete / replace surrounding brackets, quotes, tags, and function calls.
  - Faster than editing both ends by hand.
- mini.ai
  - Extends a / i textobjects (`af` call, `aa` argument, `aq` quote, `ab` bracket, etc.).
  - Works even when the cursor is not inside the target (`ci"` from the line start).
- nvim-ts-autotag
  - Auto close and rename HTML / JSX tags.
  - Keeps opening and closing tags in sync.
- grug-far.nvim
  - Project-wide search and replace in a buffer.
  - Previews all changes before applying them.
- ts-comments.nvim
  - Context-aware `gc` comments (e.g. JSX).
  - Uses the correct comment syntax for embedded languages.

## Language support

- Shell / JSON / YAML / TOML LSP
  - bashls + shellcheck, jsonls / yamlls + SchemaStore.nvim, taplo.
  - Completion and validation for config files (`package.json`, GitHub Actions, `pyproject.toml`).
- LaTeX
  - VimTeX + Okular, texlab for completion and diagnostics.
  - Compile on save and jump between source and PDF.
- Debugger (DAP)
  - nvim-dap + nvim-dap-view, debugpy (Python), codelldb (C / C++).
  - Breakpoints and variable inspection inside Neovim.
- nvim-lint
  - Runs non-LSP linters.
  - Covers languages without a good language server.

## Markdown

- live-preview.nvim
  - Live browser preview of Markdown.
  - Pure Lua (no Node / Deno), KaTeX / Mermaid, scroll sync.
- render-markdown.nvim
  - Renders Markdown inside Neovim.
  - Readable headings, tables, and code blocks without leaving the editor.

## UI

- snacks.nvim indent
  - Indent guides and current scope highlight.
  - Makes nested blocks easy to follow.
- snacks.nvim words
  - Highlights LSP references of the word under the cursor; jump with `]]` / `[[`.
  - Shows where a variable is used at a glance.
- snacks.nvim bigfile
  - Disables heavy features on huge files.
  - Keeps Neovim responsive.
- Other snacks.nvim modules
  - toggle: option toggles shown in which-key
  - scope: current block as a textobject (`ii` / `ai`)
  - statuscolumn: tidy line numbers, signs, and folds
  - scroll: smooth scrolling
  - quickfile: show the file before plugins load
  - scratch: throwaway buffers
  - zen / dim: focus mode / dim inactive code
  - gitbrowse: open the file or line on GitHub
  - gh: GitHub issues and PRs in Neovim
  - rename: LSP-aware file rename
  - image: inline images
  - profiler: find slow Lua code
- todo-comments.nvim
  - Highlights and lists `TODO` / `FIXME`.
  - Easy to find pending work.
- bufferline.nvim
  - Buffer tabs at the top.
  - Shows open buffers at a glance.
- Built-in ui2 (replace noice.nvim)
  - Neovim's new message and cmdline UI.
  - Future default; noice.nvim is no longer maintained.

## Diagnostics and sessions

- trouble.nvim
  - Lists of diagnostics, references, and quickfix items.
  - Easier to review many problems at once.
- persistence.nvim
  - Restores buffers and window layout.
  - Resume work where you left off.

## Git

- neogit
  - Magit-like Git UI.
  - Stage, commit, and rebase without leaving Neovim.

## AI

- Copilot inline completion
  - Uses the native LSP inline completion (0.12+).
  - AI suggestions while typing.
- codecompanion.nvim
  - AI chat and inline edits.
  - Works with multiple model providers.

## Other

- vim.pack
  - Neovim's built-in plugin manager.
  - Removes the dependency on lazy.nvim.
