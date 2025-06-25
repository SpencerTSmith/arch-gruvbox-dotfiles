return {
  {
    "echasnovski/mini.hipatterns",
    version = false,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = function()
      return {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "GruvboxRedBold" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "GruvboxYellowBold" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "GruvboxAquaBold" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "GruvboxBlueBold" },
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      }
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      local opts = {
        custom_textobjects = {
          l = spec_treesitter({
            a = { "@loop.outer" },
            i = { "@loop.inner" },
          }),
          i = spec_treesitter({
            a = { "@conditional.outer" },
            i = { "@conditional.inner" },
          }),
          f = spec_treesitter({
            a = "@function.outer",
            i = "@function.inner"
          }),
          c = spec_treesitter({
            a = "@class.outer",
            i = "@class.inner"
          }),
        },
      }
      return opts
    end
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
