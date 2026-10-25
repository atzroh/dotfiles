return {
  "loctvl842/monokai-pro.nvim",
  -- Load before other plugins so their highlights follow the theme
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      -- classic | octagon | pro | machine | ristretto | spectrum
      filter = "pro",
      -- Theme hides the which-key border (fg = bg); use FloatBorder colors
      override = function(scheme)
        return {
          WhichKeyBorder = { fg = scheme.editorSuggestWidget.foreground, bg = scheme.editor.background },
        }
      end,
    })
    vim.cmd.colorscheme("monokai-pro")
  end,
}
