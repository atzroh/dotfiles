-- Git root for the terminal keys. get_root() returns "." in special buffers,
-- which would open a second terminal, so use the cwd there instead
local function terminal_root()
  local term = vim.b.snacks_terminal
  if term then
    return term.cwd
  end
  return Snacks.git.get_root(vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) or "")
end

return {
  "folke/snacks.nvim",
  -- Terminal at the bottom; <C-/> and <leader>ft share the same one
  keys = {
    {
      "<leader>ft",
      function()
        Snacks.terminal(nil, { cwd = terminal_root() })
      end,
      desc = "Terminal (git root)",
    },
    {
      "<leader>fT",
      function()
        Snacks.terminal()
      end,
      desc = "Terminal (cwd)",
    },
    {
      "<C-/>",
      function()
        Snacks.terminal.focus(nil, { cwd = terminal_root() })
      end,
      mode = { "n", "t" },
      desc = "Terminal (git root)",
    },
    -- <C-/> in terminals that send it as <C-_>
    {
      "<C-_>",
      function()
        Snacks.terminal.focus(nil, { cwd = terminal_root() })
      end,
      mode = { "n", "t" },
      desc = "which_key_ignore",
    },
  },
}
