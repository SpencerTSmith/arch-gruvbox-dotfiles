return {
  "saghen/blink.cmp",
  version = "1.*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    -- add blink.compat to dependencies
    {
      "saghen/blink.compat",
      lazy = true,
      opts = {},
      version = "2.*"
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      accept = { auto_brackets = { enabled = true, }, },
      list = { selection = { preselect = false, auto_insert = true }, },
      menu = { draw = { treesitter = { "lsp" }, }, },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      ghost_text = { enabled = vim.g.ai_cmp, },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
    keymap = {
      preset = "default",
    },
  },
}
