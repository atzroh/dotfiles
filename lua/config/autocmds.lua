-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    -- hl_op replaces on_yank in 0.13; fall back for 0.12
    (vim.hl.hl_op or vim.hl.on_yank)()
  end,
})
