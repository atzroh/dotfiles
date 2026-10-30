vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Keys follow LazyVim (lazyvim/config/keymaps.lua)
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Move by screen line on wrapped lines, unless a count is given
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
map("n", "<leader>-", "<C-w>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-w>v", { desc = "Split window right", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window", remap = true })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer" })

-- Move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move up" })
map("x", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move down" })
map("x", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move up" })

-- n always searches forward, N backward; open folds at the match
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Keep the selection after indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

-- Diagnostics
local function diagnostic_jump(count, severity)
  return function()
    vim.diagnostic.jump({ count = count, severity = severity and vim.diagnostic.severity[severity] })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "]e", diagnostic_jump(1, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_jump(-1, "ERROR"), { desc = "Prev error" })
map("n", "]w", diagnostic_jump(1, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_jump(-1, "WARN"), { desc = "Prev warning" })

map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-- UI toggles (snacks.toggle); Snacks is ready after VeryLazy
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle
      .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
      :map("<leader>uc")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.inlay_hints():map("<leader>uh")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle({
      name = "Treesitter Context",
      get = function()
        return require("treesitter-context").enabled()
      end,
      set = function(state)
        require("treesitter-context")[state and "enable" or "disable"]()
      end,
    }):map("<leader>ut")
  end,
})
