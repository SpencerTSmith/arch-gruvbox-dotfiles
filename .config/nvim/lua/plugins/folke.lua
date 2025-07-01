return {
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
        -- only_current = true,
        -- only_scope = true,
      },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			notifier = { enabled = true },
			styles = { notification = { border = "single", }, },
			rename = { enabled = true },
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
