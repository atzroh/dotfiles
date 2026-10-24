return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Names shown for <leader> prefixes
    spec = {
      { "<leader>a", group = "AI (Claude Code)" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk (gitsigns)" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggle" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
