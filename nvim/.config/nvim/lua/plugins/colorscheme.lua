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
      -- Color palette
      color_overrides = {
        mocha = {
          rosewater = "#fcfcfa",
          flamingo = "#ff7e83",
          pink = "#ff7e83",
          mauve = "#a392e8",
          red = "#ff666d",
          maroon = "#ff7e83",
          peach = "#ff9653",
          yellow = "#ffc739",
          green = "#b3e03a",
          teal = "#acedf8",
          sky = "#9deaf6",
          sapphire = "#1bd5eb",
          blue = "#00cde8",
          lavender = "#b0a3eb",
          text = "#fcfcfa",
          subtext1 = "#e4e4e2",
          subtext0 = "#cdcccb",
          overlay2 = "#b5b4b3",
          overlay1 = "#9d9c9c",
          overlay0 = "#858485",
          surface2 = "#6d6c6d",
          surface1 = "#565456",
          surface0 = "#3e3c3e",
          base = "#262427",
          mantle = "#1e1c1f",
          crust = "#171518",
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
    -- Hide "~" on lines past the end of the buffer
    vim.opt.fillchars:append({ eob = " " })
  end,
}
