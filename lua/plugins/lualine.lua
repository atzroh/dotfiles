return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      -- One statusline at the bottom, for the current window
      globalstatus = true,
    },
    sections = {
      lualine_b = {
        "branch",
        {
          "diff",
          -- Reuse gitsigns' counts instead of running git again
          source = function()
            local gs = vim.b.gitsigns_status_dict
            if gs then
              return { added = gs.added, modified = gs.changed, removed = gs.removed }
            end
          end,
        },
        "diagnostics",
      },
      lualine_x = {
        -- Show "recording @q" (noice takes over the cmdline area)
        {
          function()
            return "recording @" .. vim.fn.reg_recording()
          end,
          cond = function()
            return vim.fn.reg_recording() ~= ""
          end,
        },
        "encoding",
        "fileformat",
        "filetype",
      },
    },
    -- Simpler statusline in these special buffers
    extensions = { "lazy", "mason", "oil", "quickfix", "man" },
  },
}
