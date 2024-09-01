return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				build = "make",

				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		keys = {
			{ "<leader>f", "", desc = "Find: " },
			{ "<leader>fh", require("telescope.builtin").help_tags,   desc = "Find: help" },
			{ "<leader>fk", require("telescope.builtin").keymaps,     desc = "Find: keymaps" },
			{ "<leader>ff", require("telescope.builtin").find_files,  desc = "Find: files" },
			{ "<leader>fs", require("telescope.builtin").builtin,     desc = "Find: selectors" },
			{ "<leader>fw", require("telescope.builtin").grep_string, desc = "Find: current word" },
			{ "<leader>fg", require("telescope.builtin").live_grep,   desc = "Find: by Grep" },
			{
				"<leader>fd",
				require("telescope.builtin").diagnostics,
				desc = "Find: Diagnostics"
			},
			{ "<leader>fr", require("telescope.builtin").oldfiles, desc = 'Find: recent' },
			{ "<leader>fb", require("telescope.builtin").buffers,  desc = "Find: existing buffers" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = 'bottom_pane',
					layout_config = {
						height = 0.25,
					},
					mappings = {
						i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},
}
