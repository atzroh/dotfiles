-- NVIM in the style of the built-in intro logo (:intro)
local logo = {
  "│ ╲ ││ ╲╲   ╱╱ ││ ││╲ ╱╱│",
  "││╲╲││  ╲╲ ╱╱  ││ ││╲╲╱││",
  "││ ╲ │   ╲╲╱   ││ ││   ││",
}

-- Color of each logo character at the same position: b = blue, p = purple
local colors = {
  "b p pp bb   pp bp bbb ppp",
  "bbbppp  bb pp  bp bbbbppp",
  "bb b p   bbp   bp bb   pp",
}

-- Same actions as the snacks default keys
local keys = {
  { key = "f", hint = "files", action = ":lua Snacks.dashboard.pick('files')" },
  { key = "n", hint = "new", action = ":ene | startinsert" },
  { key = "g", hint = "grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
  { key = "r", hint = "recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
  { key = "c", hint = "config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
  { key = "L", hint = "lazy", action = ":Lazy" },
  { key = "q", hint = "quit", action = ":qa" },
}

-- Logo in blue and purple, plus version and date
local function header()
  local text = {}
  for row, line in ipairs(logo) do
    for col, char in ipairs(vim.fn.split(line, "\\zs")) do
      text[#text + 1] = { char, hl = colors[row]:sub(col, col) == "p" and "Keyword" or "header" }
    end
    text[#text + 1] = { "\n" }
  end
  local v = vim.version()
  local version = ("v%d.%d.%d%s"):format(v.major, v.minor, v.patch, v.prerelease and "-dev" or "")
  text[#text + 1] = { "\n" .. version .. "  ·  " .. os.date("%a, %b %d"), hl = "Comment" }
  return { align = "center", text = text, padding = 2 }
end

-- One-line key hint; the keys themselves are hidden items
local function hint()
  local text = {}
  for i, k in ipairs(keys) do
    text[#text + 1] = { (i > 1 and "   " or "") .. k.key, hl = "key" }
    text[#text + 1] = { " " .. k.hint, hl = "desc" }
  end
  local items = { { align = "center", text = text, padding = 2 } }
  for _, k in ipairs(keys) do
    items[#items + 1] = { key = k.key, action = k.action, hidden = true }
  end
  return items
end

-- Merged into the spec in snacks.lua (load order is set there)
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- Start screen when nvim is opened without arguments
    dashboard = {
      enabled = true,
      sections = {
        header,
        hint,
        { section = "startup" },
      },
    },
  },
}
