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
        "odin",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang", [".vert"] = "glsl", [".frag"] = "glsl" },
      })
    end,
  },
}
