-- Auto close and rename HTML / JSX tags
return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Also complete the tag name after typing </
    opts = { enable_close_on_slash = true },
  },
}
