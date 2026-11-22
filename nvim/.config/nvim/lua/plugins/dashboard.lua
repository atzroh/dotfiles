local logo = {
  "╭─╮   ╭─╮   ╭─╮   ╷ ╷   ╷   ╭┬╮",
  "│ │   ├─┘   │ │   │ │   │   │││",
  "╵ ╵   ╰─╯   ╰─╯   ╰─╯   ╵   ╵╵╵",
}

-- Merged into the spec in snacks.lua (load order is set there)
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- Start screen when nvim is opened without arguments
    dashboard = {
      enabled = true,
      preset = { header = table.concat(logo, "\n") },
    },
  },
}
