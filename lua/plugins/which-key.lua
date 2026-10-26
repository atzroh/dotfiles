return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Floating window at the bottom right, as in LazyVim
    preset = "helix",
    -- Names shown for <leader> prefixes
    spec = {
      { "<leader>a", group = "AI (Claude Code)" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk (gitsigns)" },
      { "<leader>q", group = "Quit" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggle" },
      { "<leader>w", group = "Window" },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    -- monokai-pro resets this on load and skips its override (colorscheme.lua)
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "FloatBorder" })
  end,
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
