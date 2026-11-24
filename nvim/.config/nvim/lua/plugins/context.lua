-- Pins the enclosing function or class at the top of the window
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  -- Line of "=" below the context; the transparent float hides its edge
  -- (colors are set in colorscheme.lua)
  opts = { separator = "=" },
}
