return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = false },
      ensure_installed = {
        "bash",
        "c",
        "lua",
        "json",
      },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     include_surrounding_whitespace = false,
      --     selection_modes = {
      --       ["@parameter.outer"] = "v",   -- charwise
      --       ["@parameter.inner"] = "v",   -- charwise
      --       ["@function.outer"] = "v",    -- charwise
      --       ["@conditional.outer"] = "V", -- linewise
      --       ["@loop.outer"] = "V",        -- linewise
      --       ["@class.outer"] = "<c-v>",   -- blockwise
      --     },
      --   },
      -- },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang", [".vert"] = "glsl", [".frag"] = "glsl" },
      })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  },
}
