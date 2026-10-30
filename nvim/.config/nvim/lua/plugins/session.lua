-- Saves the session per cwd on exit; restore it manually (as in LazyVim)
return {
  "folke/persistence.nvim",
  -- Only sessions that opened a file are saved
  event = "BufReadPre",
  -- Explorer and Claude Code are not saved in the session; reopen them on load
  init = function()
    -- Before snacks closes its terminals on ExitPre (PersistenceSavePre is too late)
    vim.api.nvim_create_autocmd("ExitPre", {
      callback = function()
        -- Saved in the session file through sessionoptions "globals"
        vim.g.SessionExplorer = #Snacks.picker.get({ source = "explorer" }) > 0 and 1 or 0
        local term = package.loaded["claudecode.terminal"]
        local buf = term and term.get_active_terminal_bufnr()
        vim.g.SessionClaude = buf and #vim.fn.win_findbuf(buf) > 0 and 1 or 0
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceLoadPost",
      callback = function()
        local win = vim.api.nvim_get_current_win()
        if vim.g.SessionExplorer == 1 then
          -- The picker focuses itself later unless enter = false
          Snacks.explorer({ enter = false })
        end
        if vim.g.SessionClaude == 1 then
          vim.cmd("ClaudeCode --continue")
        end
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_set_current_win(win)
        end
      end,
    })
  end,
  opts = {},
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore session",
    },
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore last session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't save current session",
    },
  },
}
