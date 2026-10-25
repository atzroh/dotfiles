return {
  "folke/snacks.nvim",
  -- README: set up early; setup only creates autocmds
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Also replaces vim.ui.select (e.g. the gra code action menu)
    picker = { enabled = true },
    -- Theme follows the colorscheme; "e" in lazygit opens files in this Neovim
    lazygit = { enabled = true },
    -- vim.notify as toasts at the top right
    notifier = { enabled = true },
    -- vim.ui.input (e.g. grn rename) in a floating window
    input = { enabled = true },
  },
  keys = {
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification history",
    },
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
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit log",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit current file history",
    },
  },
}
