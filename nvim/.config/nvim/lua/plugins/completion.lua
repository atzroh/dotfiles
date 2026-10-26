return {
  "saghen/blink.cmp",
  -- Release tags ship a prebuilt fuzzy matcher (no Rust toolchain needed)
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- <C-y> accept, <C-n>/<C-p> select, <C-e> hide, <C-space> show
    keymap = { preset = "default" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 0 },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        -- require() modules and plugin types in the Neovim config
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
