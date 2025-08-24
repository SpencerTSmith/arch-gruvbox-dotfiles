return
{
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      -- mini.hipatterns
      require("mini.hipatterns").setup({
        highlighters = {
          fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
          hack  = { pattern = 'HACK',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = 'TODO',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = 'NOTE',  group = 'MiniHipatternsNote'  },
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      })

      -- mini.ai
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      require("mini.ai").setup({
        custom_textobjects = {
          l = spec_treesitter({ a = { "@loop.outer" }, i = { "@loop.inner" } }),
          i = spec_treesitter({ a = { "@conditional.outer" }, i = { "@conditional.inner" } }),
          f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
        },
      })

      -- mini.surround
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })

      -- mini.icons
      require("mini.icons").setup()

      -- mini.pairs setup
      require("mini.pairs").setup({
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_unbalanced = true,
        skip_ts = { "string" },
        markdown = true,
      })
    end,
  },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			indent = {
        enabled = true,
        indent = {
          enabled = false,
        },
        animate = { enabled = false },
      },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			notifier = { enabled = true },
			styles = { notification = { border = "single", }, },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "classic",
			delay = 800,
			layout = {
				width = { min = 5, max = 50 }, -- min and max width of the columns
				spacing = 10, -- spacing between columns
				align = "center", -- align columns left, center or right
			},
			spec = {
				{ "<leader>b", group = "Buffers" },
				{ "<leader>f", group = "Find" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>m", group = "Misc" },
				{ "<leader>q", group = "Quickfix" },
				{ "<leader>t", group = "Toggles" },
				{ "z", group = "fold" },
				{
					"<leader>b",
					group = "Buffers",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				{
					"<leader>w",
					group = "Windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				{ "gx", desc = "Open with system app" },
			},
		},
	},
}
