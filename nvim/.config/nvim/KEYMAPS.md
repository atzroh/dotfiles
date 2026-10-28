# KEYMAPS

Keymaps available in this config.

- Source: **Config** = defined here (LazyVim / README = copied from there), **Built-in** = Neovim default, plugin name = plugin default.
- Mode: `n` normal, `i` insert, `v` visual, `o` operator-pending, `t` terminal, `c` cmdline.
- Leader: `Space`; localleader: `\`.
- Check a mapping with `:nmap <key>`; `:verbose nmap <key>` also shows where it is defined.

## Key hints (which-key.nvim)

- Pause after a prefix key (`Space`, `g`, `z`, `]`, `"`, ...) to see the next keys at the bottom right.

| Key | Action | Source |
|---|---|---|
| `<leader>?` | Buffer-local keymaps | Config (README) |
| `<BS>` (popup open) | Go up one level | which-key |
| `<Esc>` (popup open) | Close | which-key |

- Leader groups: `a` AI, `b` Buffer, `c` Code, `f` Find, `g` Git, `h` Hunk, `q` Quit, `s` Search, `t` Toggle, `w` Window.

## Messages and notifications (noice.nvim + snacks.nvim)

- Same behavior as LazyVim.
- The cmdline row is hidden by default.
- `:` opens a floating cmdline at the top center; `/` and `?` stay at the bottom.
- `:echo` output, errors, and warnings show as notifications at the top right.
- Write / undo info (`10L, 200B written`) shows small at the bottom right.
- Messages with 20+ lines open in a split.
- Macro recording shows `recording @q` in lualine.

| Key / Command | Action | Source |
|---|---|---|
| `<leader>n` | Notification history | Config |
| `:Noice` | noice message history | noice |
| `:Noice dismiss` | Dismiss all notifications | noice |
| `:messages` | Message history | Built-in |

## Dashboard (snacks.dashboard)

- `nvim` without arguments shows logo, version, date, key hints, and startup time.
- Defined in `lua/plugins/dashboard.lua`; `logo` sets the shape, `colors` the color (`b` blue, `p` purple).

| Key | Action | Source |
|---|---|---|
| `f` | Find files | Config |
| `n` | New file (starts in insert mode) | Config |
| `g` | Grep | Config |
| `r` | Recent files | Config |
| `c` | Find config files | Config |
| `L` | lazy.nvim | Config |
| `q` | Quit (`:qa`) | Config |
| `:lua Snacks.dashboard()` | Open the dashboard later (close with `<Esc>`; `q` quits Neovim) | snacks |

## Basics

| Key | Mode | Action | Source |
|---|---|---|---|
| `<Esc>` | n | Clear search highlight | Config |
| `<C-s>` | n / i / v | Save and return to normal mode | Config (LazyVim) |
| `"_d` | n | Delete without touching the clipboard | Built-in |
| `<leader>fn` | n | New empty buffer | Config (LazyVim) |
| `<leader>l` | n | lazy.nvim | Config (LazyVim) |
| `<leader>qq` | n | Quit all (`:qa`) | Config (LazyVim) |

- Yank and put share the system clipboard (`clipboard=unnamedplus`).
- Built-in `<C-l>` (clear and redraw) is replaced by window navigation.
- Built-in insert `<C-s>` (signature help) is replaced by save; signature help opens on `(` and with blink `<C-k>`.

## Windows and buffers

| Key | Action | Source |
|---|---|---|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Go to left / lower / upper / right window | Config (LazyVim) |
| `<leader>-` / `<leader>\|` | Split below / right | Config (LazyVim) |
| `<leader>wd` | Close window | Config (LazyVim) |
| `<S-h>` / `<S-l>` | Previous / next buffer (same as `[b` / `]b`) | Config (LazyVim) |
| `<leader>bb` | Alternate buffer | Config (LazyVim) |
| `<leader>bd` | Delete buffer, keep window | Config (snacks.bufdelete) |
| `<leader>bo` | Delete other buffers | Config (snacks.bufdelete) |

- Built-in `H` / `L` (top / bottom of screen) are replaced by buffer switching.

## Editing

| Key | Mode | Action | Source |
|---|---|---|---|
| `<A-j>` / `<A-k>` | n / i / v | Move line(s) down / up and reindent (`2<A-j>` moves 2 lines) | Config (LazyVim) |
| `<` / `>` | v | Indent and keep the selection | Config (LazyVim) |
| `j` / `k` | n / v | Move by screen line on wrapped lines; counts (`5j`) use real lines | Config (LazyVim) |
| `n` / `N` | n / v / o | Always search forward / backward (even after `?` or `#`), open folds | Config (LazyVim) |

- Alt keys do not reach Neovim if the terminal (Ghostty, etc.) binds them.

## Terminal (snacks.terminal)

- Opens a shell in a bottom split, in terminal mode.

| Key | Mode | Action | Source |
|---|---|---|---|
| `<C-/>` | n / t | Toggle terminal at the Git root; jumps to it if visible elsewhere | Config (LazyVim) |
| `<Esc><Esc>` | t | Normal mode (scroll, copy; `i` to type again) | snacks |
| `q` | n (in terminal) | Hide terminal (shell keeps running) | snacks |
| `gf` | n (in terminal) | Open file under cursor | snacks |

- `exit` in the shell closes the terminal.
- Terminals that cannot send `<C-/>` send `<C-_>`, which is mapped the same.
- Built-in `<C-\><C-n>` also enters normal mode.

## Search (snacks.picker)

| Key | Action | Source |
|---|---|---|
| `<leader>ff` | Find files | Config |
| `<leader>/` | Grep | Config |
| `<leader>,` | Buffers | Config |
| `<leader>sh` | Help pages | Config |
| `<leader>ss` | Symbols in the current file | Config (LazyVim) |
| `<leader>sS` | Workspace symbols (LSP, incl. unopened files) | Config (LazyVim) |

- Hidden and gitignored files are excluded by default.
- `gra` (code action) and other selections also use the picker.

Inside the picker (input starts in insert mode):

| Key | Action |
|---|---|
| Type | Filter (fzf syntax: `'foo` exact, `!foo` exclude) |
| `<C-n>` / `<C-p>` (`<C-j>` / `<C-k>`, `<Down>` / `<Up>`) | Next / previous item |
| `<CR>` | Open |
| `<C-v>` / `<C-s>` / `<C-t>` | Open in vsplit / split / tab |
| `<Tab>` | Multi-select |
| `<C-q>` | Send to quickfix |
| `<C-f>` / `<C-b>` | Scroll preview |
| `<A-h>` / `<A-i>` | Toggle hidden / ignored files |
| `<A-p>` | Toggle preview |
| `<Esc>` `<Esc>` (or `q`) | Normal mode, then close (`<C-c>` closes at once) |
| `?` | Picker keymaps |

## File explorer (snacks.explorer)

- Sidebar tree with Git status and diagnostics; refreshes on external changes.

| Key | Action | Source |
|---|---|---|
| `-` / `<leader>e` | Toggle sidebar and reveal the current file | Config |
| `nvim .` | Open the explorer | snacks |

- Built-in `-` (0.13: open parent dir) is replaced by the explorer.

Inside the sidebar:

| Key | Action |
|---|---|
| `<CR>` / `l` | Open file / toggle folder |
| `h` | Close folder |
| `<C-v>` / `<C-s>` | Open in vsplit / split |
| `P` | Toggle preview |
| `a` | Add file (`name/` for folder) |
| `r` | Rename |
| `d` | Move to the system trash (asks first) |
| `<Tab>` | Select (for `c` / `m` / `d` / `y`) |
| `c` / `m` | Copy / move selection here (no selection: copy as / rename) |
| `y` / `p` | Yank paths / paste (copy) here |
| `o` | Open with the system app |
| `H` / `I` | Toggle hidden / gitignored files (dotfiles shown by default) |
| `/` | Filter by name |
| `<BS>` / `.` | Root to parent / root to folder under cursor |
| `]g` / `[g` | Next / previous Git-changed file |
| `]d` / `[d` | Next / previous diagnostic |
| `Z` | Close all folders |
| `u` | Refresh |
| `<leader>/` | Grep in the folder |
| `<C-t>` | Terminal in the folder |
| `q` | Close |
| `?` | Sidebar keymaps |

## Git (gitsigns.nvim)

- Signs in the left column: `┃` added / changed, `▁` deleted; a change block is a hunk.

| Key | Mode | Action | Source |
|---|---|---|---|
| `]c` / `[c` | n | Next / previous hunk (diff mode: built-in) | Config (README) |
| `<leader>hp` | n | Preview hunk in a float | Config (README) |
| `<leader>hi` | n | Preview hunk inline | Config (README) |
| `<leader>hs` | n / v | Stage hunk (or selected lines) | Config (README) |
| `<leader>hr` | n / v | Reset hunk (or selected lines) | Config (README) |
| `<leader>hS` / `<leader>hR` | n | Stage / reset buffer | Config (README) |
| `<leader>hb` | n | Blame line | Config (README) |
| `<leader>hd` / `<leader>hD` | n | Diff against index / last commit | Config (README) |
| `<leader>hq` / `<leader>hQ` | n | Hunks of buffer / all files to quickfix | Config (README) |
| `<leader>tb` | n | Toggle inline blame | Config (README) |
| `<leader>tw` | n | Toggle word diff | Config (README) |
| `ih` | o / v | Select hunk (`dih`, `vih`) | Config (README) |

### lazygit (snacks.lazygit)

| Key | Action | Source |
|---|---|---|
| `<leader>gg` | lazygit in a float | Config |
| `<leader>gl` | lazygit log | Config |
| `<leader>gf` | lazygit history of the current file | Config |

Inside lazygit:

| Key | Action |
|---|---|
| `q` | Quit to Neovim |
| `?` | Keymaps |
| `<Space>` | Stage / unstage file |
| `c` | Commit |
| `P` / `p` | Push / pull |
| `e` | Edit file in this Neovim (closes lazygit) |
| `<Tab>` / number keys | Switch panel |

### Diff view (codediff.nvim)

- Opens in a new tab and updates live while files change (e.g. by Claude Code).

| Key / Command | Action | Source |
|---|---|---|
| `<leader>gd` | Working tree changes (`:CodeDiff`) | Config |
| `<leader>gh` | File history with diffs (`:CodeDiff history %`) | Config |
| `:CodeDiff main` | Compare with branch main (`:CodeDiff main HEAD` for two revisions) | codediff |
| `:CodeDiff --staged` | Staged changes only | codediff |
| `:CodeDiff history` | Repository history | codediff |

Inside the diff view:

| Key | Action |
|---|---|
| `]f` / `[f` | Next / previous file |
| `]c` / `[c` | Next / previous change |
| `-` | Stage / unstage file |
| `<leader>hs` / `<leader>hu` / `<leader>hr` | Stage / unstage / reset change under cursor |
| `do` / `dp` | Obtain / put change |
| `t` | Toggle side-by-side / inline |
| `gc` | Fold unchanged lines |
| `<leader>e` / `<leader>b` | Focus / toggle file list |
| `q` | Close |
| `g?` | Keymaps |

## Claude Code (claudecode.nvim)

- Opens Claude Code on the right, integrated like the VS Code extension.
- Proposed edits open in a diff view to accept or reject.

| Key | Mode | Action | Source |
|---|---|---|---|
| `<leader>ac` | n | Toggle Claude Code | Config (README) |
| `<leader>af` | n | Focus Claude Code (open if needed) | Config (README) |
| `<leader>ar` | n | Resume a session (`--resume`) | Config (README) |
| `<leader>aC` | n | Continue last session (`--continue`) | Config (README) |
| `<leader>am` | n | Select model and open | Config (README) |
| `<leader>ab` | n | Add current buffer to context | Config (README) |
| `<leader>as` | v | Send selection | Config (README) |
| `<leader>as` | n (explorer) | Add file under cursor to context | Config (README) |
| `<leader>aa` | n | Accept diff | Config (README) |
| `<leader>ad` | n | Deny diff | Config (README) |

- In the Claude Code terminal, `<C-\><C-n>` enters normal mode and `<C-w>h` etc. switch windows.

## LSP

- Available when a language server is attached.

| Key | Mode | Action | Source |
|---|---|---|---|
| `K` | n | Hover (press again to enter) | Built-in |
| `gd` | n | Go to definition (picker if multiple) | Config (LazyVim) |
| `gD` | n | Go to declaration | Config (LazyVim) |
| `<C-]>` | n | Go to definition | Built-in |
| `<C-t>` / `<C-o>` | n | Jump back | Built-in |
| `grn` / `<leader>cr` | n | Rename | Built-in / Config (LazyVim) |
| `gra` / `<leader>ca` | n / v | Code action (range in visual) | Built-in / Config (LazyVim) |
| `grr` | n | References | Built-in |
| `gri` | n | Go to implementation | Built-in |
| `grt` | n | Go to type definition | Built-in |
| `grx` | n | Run code lens | Built-in |
| `gO` | n | Document symbols | Built-in |
| `]]` / `[[` | n | Next / previous reference of the word under cursor | Config (README) |
| `<A-n>` / `<A-p>` | n | Next / previous reference, wraps around | Config (LazyVim) |

- `gd` / `gD` / `<leader>ca` / `<leader>cr` are buffer-local to LSP buffers; elsewhere `gd` / `gD` are built-in.
- References of the word under the cursor are highlighted automatically (snacks.words).
- Built-in `]]` / `[[` (section jump) are replaced; ftplugins (Python, Go, Rust, Markdown, ...) keep their own, so use `<A-n>` / `<A-p>` there.

## Formatting

- Formats on save (`:w`); files without a formatter only get trailing spaces removed.

| Key / Command | Mode | Action | Source |
|---|---|---|---|
| `<leader>cf` | n / v | Format buffer (or selection) | Config |
| `gq{motion}` | n / v | Format with the formatter (`gqq`, `gqip`, `gggqG`) | Config (conform) |
| `gw{motion}` | n / v | Wrap text at `textwidth` | Built-in |
| `:FormatDisable` | - | Disable format on save (`!` for this buffer only) | Config |
| `:FormatEnable` | - | Enable format on save | Config |
| `:ConformInfo` | - | Formatters and log for this buffer | conform |

## Diagnostics

| Key | Mode | Action | Source |
|---|---|---|---|
| `]d` / `[d` | n | Next / previous diagnostic | Built-in |
| `]D` / `[D` | n | Last / first diagnostic | Built-in |
| `]e` / `[e` | n | Next / previous error | Config (LazyVim) |
| `]w` / `[w` | n | Next / previous warning | Config (LazyVim) |
| `<C-w>d` / `<leader>cd` | n | Line diagnostics | Built-in / Config (LazyVim) |

## Completion (insert mode)

- The menu opens automatically while typing.

| Key | Action | Source |
|---|---|---|
| `<C-n>` / `<C-p>` (`<Down>` / `<Up>`) | Next / previous item | blink |
| `<C-y>` | Accept (first item if none selected) | blink |
| `<C-e>` | Close | blink |
| `<C-space>` | Show menu, then docs, then hide docs | blink |
| `<C-b>` / `<C-f>` | Scroll docs | blink |
| `<C-k>` | Toggle signature help | blink |
| `<Tab>` / `<S-Tab>` | Next / previous snippet placeholder | blink |

## Auto pairs (mini.pairs)

- Closes brackets and quotes in insert mode (`|` = cursor).

| Key | Action | Source |
|---|---|---|
| `(` `[` `{` `"` `'` `` ` `` | Insert the pair, cursor inside (`(|)`) | mini.pairs |
| `)` `]` `}` (before the closer) | Move past the closer | mini.pairs |
| `<BS>` (in `(|)`) | Delete both | mini.pairs |
| `<CR>` (in `{|}`) | Newline, closer on the next line | mini.pairs |

- `'` does not close after a letter (`don't`).
- Nothing closes after `\` (`\(`).
- Insert a single character with `<C-v>` first (`<C-v>(`).

## Completion (cmdline)

| Key | Action | Source |
|---|---|---|
| `<Tab>` / `<S-Tab>` | Show menu and select next / previous (accept if only one) | blink |
| `<C-n>` / `<C-p>` | Next / previous item | blink |
| `<C-y>` | Accept | blink |
| `<C-e>` | Close | blink |

## Folding

- Treesitter folds functions, classes, headings, etc.; all open on load.

| Key | Action | Source |
|---|---|---|
| `zc` / `zo` | Close / open fold | Built-in |
| `za` | Toggle fold | Built-in |
| `zM` / `zR` | Close / open all | Built-in |
| `zj` / `zk` | Next / previous fold | Built-in |

## Useful commands

| Command | Action |
|---|---|
| `:Lazy` | Plugins (`U` update, `q` close) |
| `:Lazy profile` | Startup and per-plugin load time |
| `:Mason` | LSP servers and tools |
| `:Inspect` | Highlight source under cursor (Treesitter / LSP) |
| `:InspectTree` | Treesitter syntax tree |
| `:TSUpdate` | Update Treesitter parsers |
| `:checkhealth vim.lsp` | LSP status |
| `:checkhealth nvim-treesitter` | Treesitter status |
