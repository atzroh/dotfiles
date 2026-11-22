return {
  "catppuccin/nvim",
  name = "catppuccin",
  -- Load before other plugins so their highlights follow the theme
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      -- Show the terminal background (Ghostty's opacity) through Neovim
      transparent_background = true,
      float = { transparent = true },
      integrations = {
        -- Statusline middle keeps a background (transparent_background clears it)
        lualine = {
          all = function(colors)
            return { normal = { c = { bg = colors.mantle } } }
          end,
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
    -- Hide "~" on lines past the end of the buffer
    vim.opt.fillchars:append({ eob = " " })
  end,
}
