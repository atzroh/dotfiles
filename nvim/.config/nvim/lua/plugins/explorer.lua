-- Merged into the spec in snacks.lua (load order is set there)
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- File tree; also opens for `nvim .` (replaces netrw)
    -- d moves to the system trash; follows the current file and
    -- refreshes on external changes (e.g. Claude Code) by default
    explorer = { enabled = true },
    picker = {
      sources = {
        -- Show dotfiles; gitignored files stay hidden (H / I toggle)
        explorer = { hidden = true },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer (reveal current file)",
    },
    -- Replaces the built-in "-" (open parent directory)
    {
      "-",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer (reveal current file)",
    },
  },
}
