-- Pins the enclosing function or class at the top of the window
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  -- Same color as the indent guides; set again after each colorscheme change
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- catppuccin underlines the last line; the separator replaces it
        vim.api.nvim_set_hl(0, "TreesitterContextBottom", {})
        vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { link = "SnacksIndentScope" })
      end,
    })
  end,
  -- Line of "=" below the context; the transparent float hides its edge
  opts = { separator = "=" },
}
