local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.winborder = "rounded"

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Search: case-insensitive unless the pattern has uppercase
opt.ignorecase = true
opt.smartcase = true

-- Open splits to the right and below
opt.splitright = true
opt.splitbelow = true

-- Persist undo history across sessions
opt.undofile = true

-- Share the system clipboard
opt.clipboard = "unnamedplus"

-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  float = { source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
})
