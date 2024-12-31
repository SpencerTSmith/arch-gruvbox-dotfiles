return {
	{
		"stevearc/oil.nvim",
		event = "VimEnter",
		opts = {
			delete_to_trash = true,
			default_file_explorer = true,
			watch_for_changes = true,
			constrain_cursor = "editable",
			columns = {
				"permissions",
				"size",
				"mtime",
				"icon",
			},
			view_options = {
				show_hidden = true,
			},
			float = {
				border = "single",
			},
			preview = {
				border = "single",
			},
			progress = {
				border = "single",
			},
			ssh = {
				border = "single",
			},
			keymaps_help = {
				border = "single",
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Oil: Open parent directory",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			render = "wrapped-compact",
			stages = "static",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				local config = vim.api.nvim_win_get_config(win)
				config.border = "single"
				vim.api.nvim_win_set_config(win, config)
			end,
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local custom_gruvbox = require("lualine.themes.gruvbox")
			custom_gruvbox.normal.a.bg = "#FABD2F"
			local opts = {
				options = {
					theme = custom_gruvbox,
					disabled_filetypes = {
						"dashboard",
					},
					component_separators = "",
					section_separators = "",
				},
				extensions = { "oil", "nvim-dap-ui", "fugitive", "mason", "neo-tree", "lazy" },
			}

			return opts
		end,
	},
	-- {
	-- 	"mikesmithgh/borderline.nvim",
	-- 	enabled = true,
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		border = "single",
	-- 	},
	-- },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = true,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {
				-- SignColumn = { bg = "#282828" },
			},
			dim_inactive = false,
			transparent_mode = true,
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
