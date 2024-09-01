return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "classic",
		delay = 800,
		layout = {
			width = { min = 5, max = 50 }, -- min and max width of the columns
			spacing = 10,         -- spacing between columns
			align = "center",     -- align columns left, center or right
		},
		spec = {
			{ "<leader>b",  group = "Buffers" },
			{ "<leader>f",  group = "Find" },
			{ "<leader>l",  group = "LSP" },
			{ "<leader>m",  group = "Misc" },
			{ "<leader>q",  group = "Quickfix" },
			{ "<leader>R",  group = "Replace" },
			{ "<leader>s",  group = "Search" },
			{ "<leader>t",  group = "Toggles" },
			{ "<leader>w",  group = "Window" },
		},
	},
}
