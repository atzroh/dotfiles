local servers = {
  "lua_ls",
  "basedpyright",
  "ruff",
  "clangd",
  "vtsls",
  "html",
  "cssls",
  "marksman",
}

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    -- Load when a file is opened, before its FileType is set
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Install these, and enable only these (other Mason packages stay off)
      ensure_installed = servers,
      automatic_enable = servers,
    },
    config = function(_, opts)
      -- basedpyright checks types only; Ruff handles imports and lint
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              typeCheckingMode = "standard",
              -- Already reported by Ruff
              diagnosticSeverityOverrides = {
                reportUndefinedVariable = "none",
                reportUnusedImport = "none",
                reportUnusedVariable = "none",
              },
            },
          },
        },
      })

      -- Warnings for files without compile_commands.json / compile_flags.txt
      vim.lsp.config("clangd", {
        init_options = { fallbackFlags = { "-Wall", "-Wextra" } },
      })

      -- Use basedpyright's hover instead of Ruff's
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_ruff_no_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      require("mason-lspconfig").setup(opts)
    end,
  },

  -- Completion and type info for the Neovim Lua API in config files
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
