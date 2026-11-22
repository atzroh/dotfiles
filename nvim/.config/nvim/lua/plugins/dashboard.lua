local logo = {
  "╭─╮   ╭─╮   ╭─╮   ╷ ╷   ╷   ╭┬╮",
  "│ │   ├─┘   │ │   │ │   │   │││",
  "╵ ╵   ╰─╯   ╰─╯   ╰─╯   ╵   ╵╵╵",
}

-- Catppuccin accent for each letter, from left to right
local letter_colors = { "mauve", "lavender", "blue", "sapphire", "sky", "teal" }

-- Logo with each letter in its own color; letters are separated by 3 spaces
local function header()
  local c = require("catppuccin.palettes").get_palette()
  local text = {}
  for _, line in ipairs(logo) do
    for i, letter in ipairs(vim.split(line, "   ", { plain = true })) do
      vim.api.nvim_set_hl(0, "SnacksDashboardLogo" .. i, { fg = c[letter_colors[i]] })
      text[#text + 1] = { (i > 1 and "   " or "") .. letter, hl = "SnacksDashboardLogo" .. i }
    end
    text[#text + 1] = { "\n" }
  end
  return { align = "center", text = text, padding = 1 }
end

-- Merged into the spec in snacks.lua (load order is set there)
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- Start screen when nvim is opened without arguments
    dashboard = {
      enabled = true,
      -- Same as the snacks default, with the header replaced
      sections = {
        header,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
