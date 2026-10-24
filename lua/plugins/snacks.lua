return {
  "folke/snacks.nvim",
  -- README: set up early; setup only creates autocmds
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Also replaces vim.ui.select (e.g. the gra code action menu)
    picker = { enabled = true },
  },
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help pages",
    },
  },
}
