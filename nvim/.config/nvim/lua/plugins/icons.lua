-- File icons for which-key, snacks.picker and neo-tree
return {
  "nvim-mini/mini.icons",
  lazy = true,
  opts = {},
  init = function()
    -- Serve plugins that require nvim-web-devicons (neo-tree, lualine)
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
