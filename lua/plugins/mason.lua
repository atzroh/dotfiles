-- Non-LSP tools installed automatically (LSP servers are listed in lsp.lua)
local tools = {
  "tree-sitter-cli", -- builds Treesitter parsers
  -- Formatters used by conform.nvim (ruff comes with the LSP server)
  "stylua",
  "clang-format",
  "prettierd",
  "shfmt",
  "taplo",
}

return {
  "mason-org/mason.nvim",
  -- Load at startup so Mason's bin/ is on PATH for tree-sitter-cli
  lazy = false,
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(tools) do
        local pkg = registry.get_package(name)
        if not pkg:is_installed() and not pkg:is_installing() then
          pkg:install()
        end
      end
    end)
  end,
}
