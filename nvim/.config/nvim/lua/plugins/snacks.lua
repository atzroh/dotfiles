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
    -- Indent guides; highlights the current scope
    indent = { enabled = true },
    -- Highlights LSP references of the word under the cursor
    words = { enabled = true },
    -- Disables heavy features on huge files
    bigfile = { enabled = true },
    -- Marks and signs left of line numbers; folds and git signs right
    statuscolumn = { enabled = true },
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
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP symbols",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP workspace symbols",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next reference",
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev reference",
    },
    -- Also works where ftplugins override ]] / [[ (e.g. Python)
    {
      "<A-n>",
      function()
        Snacks.words.jump(vim.v.count1, true)
      end,
      desc = "Next reference (cycle)",
    },
    {
      "<A-p>",
      function()
        Snacks.words.jump(-vim.v.count1, true)
      end,
      desc = "Prev reference (cycle)",
    },
    -- Delete buffers without closing their windows
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete other buffers",
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
