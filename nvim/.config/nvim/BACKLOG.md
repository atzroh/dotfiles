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
- Built-in undotree
  - Browse the undo history as a tree (`:packadd nvim.undotree`, `:Undotree`).
  - Restores earlier states without a plugin.
- guess-indent.nvim
  - Detects indent width and tabs per file.
  - Matches the style of code written by others.

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
- neotest
  - neotest-python for pytest.
  - Run tests per function and show results inline; can debug tests with DAP.
- nvim-lint
  - Runs non-LSP linters.
  - Covers languages without a good language server.

## UI

- Other snacks.nvim modules
  - scope: current block as a textobject (`ii` / `ai`)
  - gitbrowse: open the file or line on GitHub
- todo-comments.nvim
  - Highlights and lists `TODO` / `FIXME`.
  - Easy to find pending work.
- nvim-treesitter-context
  - Pins the enclosing function or class at the top of the window.
  - Shows where you are inside long blocks.
- Built-in ui2 (replace noice.nvim)
  - Neovim's new message and cmdline UI.
  - Future default; noice.nvim is no longer maintained.

## Diagnostics and sessions

- persistence.nvim
  - Restores buffers and window layout.
  - Resume work where you left off.
- quicker.nvim
  - Editable, nicer-looking quickfix list.
  - Edit lines in the list and save to apply them to files.

## Keymaps

- Merge `<leader>t` into `<leader>u`
  - `<leader>tb` / `<leader>tw` (gitsigns, from its README) and `<leader>u` (snacks.toggle) are both toggles.
  - LazyVim keeps toggles under `<leader>u` and uses `<leader>t` for tests (neotest).
- `]]` / `[[` for LSP references
  - Replaces the built-in section jumps, and ftplugins (Python, Go, Markdown, ...) override it.
  - Only `<A-n>` / `<A-p>` work everywhere; consider keeping just those.

## Other

- vim.pack
  - Neovim's built-in plugin manager.
  - Removes the dependency on lazy.nvim.
