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
      custom_highlights = function(colors)
        return {
          -- Dashboard logo color (any catppuccin palette name)
          SnacksDashboardHeader = { fg = colors.teal },
          -- Drop the context underline; the separator in context.lua replaces it
          TreesitterContextBottom = { style = {} },
          -- Context separator in the same color as the indent guides
          TreesitterContextSeparator = { link = "SnacksIndentScope" },
        }
      end,
    })
    vim.cmd.colorscheme("catppuccin")
    -- Hide "~" on lines past the end of the buffer
    vim.opt.fillchars:append({ eob = " " })
  end,
}
