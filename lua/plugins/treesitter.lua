local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "gitcommit",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- The plugin does not support lazy-loading
  lazy = false,
  build = ":TSUpdate",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    local ts = require("nvim-treesitter")

    -- Parsers are built with tree-sitter-cli; on a fresh machine wait until
    -- Mason has installed it
    if vim.fn.executable("tree-sitter") == 1 then
      ts.install(parsers)
    else
      require("mason-registry"):on("package:install:success", function(pkg)
        if pkg.name == "tree-sitter-cli" then
          vim.schedule(function()
            ts.install(parsers)
          end)
        end
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(args)
        -- Skip filetypes without an installed parser
        if not pcall(vim.treesitter.start, args.buf) then
          return
        end
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
      end,
    })
  end,
}
