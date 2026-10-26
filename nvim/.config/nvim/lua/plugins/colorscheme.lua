-- Panels the theme still fills with a background color
local clear_bg = {
  "NormalFloat",
  "Pmenu",
  "PmenuExtra",
  "PmenuKind",
  "PmenuBorder",
  "BlinkCmpMenu",
  "NeoTreeFloatNormal",
  "NoiceConfirm",
  "NoiceConfirmBorder",
  "NoiceFormatConfirm",
  "SnacksPickerBorder",
  "SnacksPickerInputBorder",
  "SnacksPickerPrompt",
  "SnacksPickerTitle",
  "SnacksPickerTree",
  "SnacksTitle",
  "StatusLine",
  "StatusLineNC",
  "TabLineFill",
}

return {
  "loctvl842/monokai-pro.nvim",
  -- Load before other plugins so their highlights follow the theme
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      -- classic | octagon | pro | machine | ristretto | spectrum
      filter = "pro",
      -- Show the terminal background (Ghostty's opacity) through Neovim
      transparent_background = true,
      background_clear = { "neo-tree", "which-key" },
    })

    -- The theme sets each plugin's groups when that plugin loads, so clear again then
    vim.api.nvim_create_autocmd({ "ColorScheme", "User" }, {
      group = vim.api.nvim_create_augroup("transparent_panels", { clear = true }),
      callback = function(args)
        if args.event == "User" and args.match ~= "LazyLoad" then
          return
        end
        for _, name in ipairs(clear_bg) do
          local hl = vim.api.nvim_get_hl(0, { name = name })
          if hl.bg then
            hl.bg = nil
            vim.api.nvim_set_hl(0, name, hl)
          end
        end
      end,
    })
    vim.cmd.colorscheme("monokai-pro")
    -- The theme hid "~" with fg = bg, which no longer works
    vim.opt.fillchars:append({ eob = " " })
  end,
}
