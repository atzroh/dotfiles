return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  -- README: neo-tree lazy-loads itself
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",
  },
  keys = {
    { "<leader>e", "<Cmd>Neotree toggle reveal<CR>", desc = "Explorer (reveal current file)" },
    -- Replaces the built-in "-" (open parent directory)
    { "-", "<Cmd>Neotree toggle reveal<CR>", desc = "Explorer (reveal current file)" },
    { "<leader>ge", "<Cmd>Neotree float git_status<CR>", desc = "Git status (neo-tree)" },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    -- Use 'winborder' (rounded) like other floats
    popup_border_style = "",
    window = {
      mappings = {
        -- Move to the trash instead of deleting (u undoes, U restores)
        ["d"] = "trash",
      },
    },
    filesystem = {
      -- Highlight the current file in the tree
      follow_current_file = { enabled = true },
      -- Refresh when files change outside Neovim (e.g. Claude Code)
      use_libuv_file_watcher = true,
      -- Show dotfiles; gitignored files stay hidden (H toggles)
      filtered_items = { hide_dotfiles = false },
    },
  },
}
