-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Keep Debian's <prefix>/lib/<arch>/nvim (bundled parsers) in rtp
local bundled = vim.tbl_filter(function(path)
  return path:match("/lib/[^/]+/nvim$") ~= nil
end, vim.opt.rtp:get())

require("lazy").setup({
  -- Load every spec file in lua/plugins/
  spec = { { import = "plugins" } },
  -- Colorscheme used while installing plugins on first launch
  install = { colorscheme = { "catppuccin", "habamax" } },
  -- No plugin here needs luarocks
  rocks = { enabled = false },
  performance = { rtp = { paths = bundled } },
})

-- Built-in undo tree viewer (:Undotree); after setup so the rtp reset keeps it
vim.cmd.packadd("nvim.undotree")
