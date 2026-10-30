# BACKLOG

Plugins and settings to add.

## Next

- Choose between grug-far.nvim and quicker.nvim
- Add built-in undotree

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
- grug-far.nvim
  - Project-wide search and replace in a buffer.
  - Previews all changes before applying them.
- Built-in undotree
  - Browse the undo history as a tree (`:packadd nvim.undotree`, `:Undotree`).
  - Restores earlier states without a plugin.
- guess-indent.nvim
  - Detects indent width and tabs per file.
  - Matches the style of code written by others.

## Language support

- TOML LSP
  - taplo or tombi; schema validation for `pyproject.toml` etc.
  - taplo cannot load the SchemaStore catalog (tamasfe/taplo#799) and is barely maintained; tombi is the likely successor.
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

- todo-comments.nvim
  - Highlights and lists `TODO` / `FIXME`.
  - Easy to find pending work.
- Built-in ui2 (replace noice.nvim)
  - Neovim's new message and cmdline UI.
  - Future default; noice.nvim is no longer maintained.

## Diagnostics and sessions

- quicker.nvim
  - Editable, nicer-looking quickfix list.
  - Edit lines in the list and save to apply them to files.
- trouble.nvim
  - Persistent panel listing diagnostics, LSP references / symbols, and quickfix, grouped by file.
  - Stays open while fixing errors one by one; for one-off jumps `Snacks.picker.diagnostics()` is enough.

## Options

From LazyVim (lazyvim/config/options.lua).

- `confirm`: ask to save instead of failing on `:q` with unsaved changes.
- `virtualedit = "block"`: block selection can extend past line ends.
- `splitkeep = "screen"`: keep the view in place when splits open or close.
- `showmode = false`: lualine already shows the mode.
- `pumheight = 10`: limit popup menu height (blink.cmp sets its own, so little effect).
- `sidescrolloff = 8`: horizontal margin around the cursor with `nowrap`.
- `shiftround`: round `>` / `<` indent to a multiple of `shiftwidth`.
- `updatetime = 200`: faster `CursorHold` and swap writes (default 4000 ms).
- `timeoutlen = 300`: shorter wait for mapped key sequences; which-key shows sooner.
- `spelllang = { "en", "cjk" }`: do not mark Japanese as spelling errors.

## Autocmds

From LazyVim (lazyvim/config/autocmds.lua). Reloading externally changed files is not needed (built-in `nvim.autoread` in 0.13).

- Restore cursor position (last_loc)
  - Jump to the last position when reopening a file.
- Close with `q` (close_with_q)
  - `q` closes help, quickfix, man, checkhealth, etc.
- Equalize splits on resize (resize_splits)
  - `wincmd =` on `VimResized`.
- Wrap and spell in prose (wrap_spell)
  - Enable `wrap` and `spell` for markdown and gitcommit.
- Create missing directories on save (auto_create_dir)
  - `BufWritePre` creates the parent directory instead of failing.

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
