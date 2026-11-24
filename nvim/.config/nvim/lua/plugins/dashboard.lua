local logo = {
  "                                                                   ",
  "      ████ ██████           █████      ██                    ",
  "     ███████████             █████                            ",
  "     █████████ ███████████████████ ███   ███████████  ",
  "    █████████  ███    █████████████ █████ ██████████████  ",
  "   █████████ ██████████ █████████ █████ █████ ████ █████  ",
  " ███████████ ███    ███ █████████ █████ █████ ████ █████ ",
  "██████  █████████████████████ ████ █████ █████ ████ ██████",
}

-- Logo in one color (SnacksDashboardHeader, set in colorscheme.lua)
local function header()
  return { align = "center", text = { table.concat(logo, "\n"), hl = "header" }, padding = 3 }
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
