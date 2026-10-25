-- Plan to move to the built-in ui2 later (see BACKLOG.md)
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  -- LazyVim's setup, without the LSP hover/markdown overrides
  opts = {
    lsp = {
      -- Keep Neovim's own K hover (rounded via 'winborder', like other floats)
      hover = { enabled = false },
      -- blink.cmp already shows signature help
      signature = { enabled = false },
    },
    routes = {
      -- Small view for write / undo messages
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
}
