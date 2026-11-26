-- Git root for the terminal keys. get_root() returns "." in special buffers,
-- which would open a second terminal, so use the cwd there instead
local function terminal_root()
  local term = vim.b.snacks_terminal
  if term then
    return term.cwd
  end
  return Snacks.git.get_root(vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) or "")
end

local function toggle_terminal()
  local cwd = terminal_root()
  Snacks.terminal.focus(nil, {
    cwd = cwd,
    win = {
      position = "float",
      border = "rounded",
      width = 0.7,
      height = 0.7,
      title = " Terminal: " .. vim.fn.fnamemodify(cwd or vim.fn.getcwd(), ":t") .. " ",
      title_pos = "center",
    },
  })
end

return {
  "folke/snacks.nvim",
  -- Floating terminal
  keys = {
    { "<C-/>", toggle_terminal, mode = { "n", "t" }, desc = "Terminal (git root)" },
    -- <C-/> in terminals that send it as <C-_>
    { "<C-_>", toggle_terminal, mode = { "n", "t" }, desc = "which_key_ignore" },
  },
}
