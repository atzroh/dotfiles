local prettier = { "prettierd" }

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "x" },
      desc = "Format buffer (or selection)",
    },
  },
  init = function()
    -- gq uses conform; use gw to rewrap comments and prose
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true, desc = "Disable format on save (! for this buffer only)" })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable format on save" })

    vim.api.nvim_create_user_command("FormatAll", function()
      local root = vim.fs.root(0, ".git")
      if not root then
        return vim.notify("Not in a git repository", vim.log.levels.WARN)
      end
      -- Tracked text files (-I skips binaries)
      local files = vim.fn.systemlist({ "git", "-C", root, "grep", "-I", "-l", "" })
      if vim.fn.confirm(("Format %d files?"):format(#files), "&Yes\n&No", 2) ~= 1 then
        return
      end
      local conform = require("conform")
      local skipped = 0
      for _, file in ipairs(files) do
        local path = vim.fs.joinpath(root, file)
        local loaded = vim.fn.bufloaded(path) == 1
        local buf = vim.fn.bufadd(path)
        -- Skip buffers with unsaved changes
        if vim.bo[buf].modified then
          skipped = skipped + 1
        else
          vim.fn.bufload(buf)
          conform.format({ bufnr = buf, async = false })
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("silent noautocmd update")
          end)
          if not loaded then
            vim.api.nvim_buf_delete(buf, {})
          end
        end
      end
      vim.notify(("Formatted %d files (%d skipped)"):format(#files - skipped, skipped))
    end, { desc = "Format all git-tracked files" })
  end,
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      python = { "ruff_organize_imports", "ruff_format" },
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      html = prettier,
      css = prettier,
      json = prettier,
      jsonc = prettier,
      yaml = prettier,
      -- injected: format code blocks with their own language's formatter.
      markdown = { "injected", "prettierd" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      toml = { "taplo" },
      -- Filetypes without a formatter above
      ["_"] = { "trim_whitespace" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000 }
    end,
  },
}
