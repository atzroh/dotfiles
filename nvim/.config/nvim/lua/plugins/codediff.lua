-- VSCode-style diff viewer; follows changes live (e.g. while Claude Code edits)
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gd", "<Cmd>CodeDiff<CR>", desc = "Diff working tree" },
    { "<leader>gh", "<Cmd>CodeDiff history %<CR>", desc = "Current file history" },
  },
}
