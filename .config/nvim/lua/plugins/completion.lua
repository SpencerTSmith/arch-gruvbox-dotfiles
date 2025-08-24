return {
  "saghen/blink.cmp",
  version = "1.*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      accept = { auto_brackets = { enabled = true, }, },
      list = {
        selection = {
          preselect = false, auto_insert = true
        },
      },
      menu = {
        auto_show = false,
        draw = { treesitter = { "lsp" }, },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      ghost_text = {
        enabled = true,
        show_with_menu = false,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = {
        menu = { auto_show = false },
        list = {
          selection = {
            preselect = false, auto_insert = true
          },
        },
      },
    },
    keymap = {
      preset = "default",
    },
  },
}
