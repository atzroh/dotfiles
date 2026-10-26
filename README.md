# atzroh's dotfiles

## installation

Place the `dotfiles/` directory in your home directory.

```sh
cd ~
git clone
```

## images

![fastfetch](./img/fastfetch.png)
![neovim_dashboard](./img/neovim_dashboard.png)
![neovim_editor](./img/neovim_editor.png)

## packages

- shell: zsh
- terminal emulator: ghostty
- editor: neovim
  - dependencies: [nvim/.config/nvim/DEPENDENCIES.md](./nvim/.config/nvim/DEPENDENCIES.md)

## directory tree

```txt
.
├── .gitignore
├── ghostty
│  └── .config
│     └── ghostty
│        └── config.ghostty
├── git
│  └── .gitconfig
├── img
│  ├── fastfetch.png
│  ├── neovim_dashboard.png
│  └── neovim_editor.png
├── install.sh
├── nvim
│  └── .config
│     └── nvim
│        ├── .gitignore
│        ├── .stylua.toml
│        ├── BACKLOG.md
│        ├── CLAUDE.md
│        ├── DEPENDENCIES.md
│        ├── KEYMAPS.md
│        ├── init.lua
│        ├── lazy-lock.json
│        └── lua
│           ├── config
│           │  ├── autocmds.lua
│           │  ├── keymaps.lua
│           │  ├── lazy.lua
│           │  └── options.lua
│           └── plugins
│              ├── claudecode.lua
│              ├── codediff.lua
│              ├── colorscheme.lua
│              ├── completion.lua
│              ├── dashboard.lua
│              ├── format.lua
│              ├── gitsigns.lua
│              ├── icons.lua
│              ├── lsp.lua
│              ├── lualine.lua
│              ├── mason.lua
│              ├── neo-tree.lua
│              ├── noice.lua
│              ├── pairs.lua
│              ├── snacks.lua
│              ├── terminal.lua
│              ├── treesitter.lua
│              └── which-key.lua
├── README.md
├── ssh
│  └── .ssh
│     └── config
└── zsh
   ├── .zsh
   │  ├── .fzf.zsh
   │  ├── .p10k.zsh
   │  ├── alias.zsh
   │  ├── completion.zsh
   │  ├── history.zsh
   │  ├── path.zsh
   │  └── plugin.zsh
   └── .zshrc
```
