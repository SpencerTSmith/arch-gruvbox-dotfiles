return {
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
				group = "buffer",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{
				"<leader>w",
				group = "windows",
				proxy = "<c-w>",
				expand = function()
					return require("which-key.extras").expand.win()
				end,
			},
			{ "gx", desc = "Open with system app" },
		},
	},
}
