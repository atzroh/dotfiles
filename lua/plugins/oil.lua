return {
  "stevearc/oil.nvim",
  -- README: lazy-loading is not recommended
  lazy = false,
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open parent directory" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Deleted files go to the trash (g\ shows it)
    delete_to_trash = true,
    view_options = { show_hidden = true },
  },
}
