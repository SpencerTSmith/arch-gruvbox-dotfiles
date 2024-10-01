return {
	{
		"echasnovski/mini.hipatterns",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = function()
			return {
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
				},
			}
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = function()
			return {
				draw = {
					animation = require("mini.indentscope").gen_animation.none(),
				},
				options = {
					indent_at_cursor = false,
					try_as_border = true,
				},
				symbol = "│",
			}
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"lazy",
					"lazyterm",
					"mason",
					"notify",
					"Oil",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{ "echasnovski/mini.jump", version = false, event = { "BufReadPost", "BufWritePost", "BufNewFile" }, opts = {} },
	{ "echasnovski/mini.pairs", version = false, event = "InsertEnter", opts = {} },
	{ "echasnovski/mini.ai", version = false, event = { "BufReadPost", "BufWritePost", "BufNewFile" }, opts = {} },
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
	},
	-- {
	-- 	"echasnovski/mini.notify",
	-- 	version = false,
	-- 	event = "VimEnter",
	-- 	opts = function()
	-- 		local opts = {
	-- 			window = {
	-- 				winblend = 0,
	-- 			},
	-- 		}
	-- 		vim.notify = require("mini.notify").make_notify()
	-- 		return opts
	-- 	end,
	-- },
	-- { "echasnovski/mini.starter", version = false, event = "VimEnter", opts = {
	-- 	evaluate_single = true,
	-- } },
	{
		"echasnovski/mini.pick",
		version = false,
		keys = {
			{ "<leader>f", "", desc = "Find: " },
			{
				"<leader>fh",
				function()
					require("mini.pick").builtin.help()
				end,
				desc = "Find: help",
			},
			{
				"<leader>ff",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Find: files",
			},
			{
				"<leader>fg",
				function()
					require("mini.pick").builtin.grep_live()
				end,
				desc = "Find: grep",
			},
			{
				"<leader>fb",
				function()
					require("mini.pick").builtin.buffers()
				end,
				desc = "Find: buffers",
			},
		},
		opts = {
			options = {
				content_from_bottom = false,
				use_cache = true,
			},
			window = {
				config = { border = "none", col = 1, row = vim.o.lines, height = 10, width = vim.o.columns },
				prompt_prefix = " Find: ",
				prompt_cursor = "█ ",
			},
		},
	},
	{
		"echasnovski/mini.extra",
		version = false,
		keys = {
			{
				"<leader>fk",
				function()
					require("mini.extra").pickers.keymaps()
				end,
				desc = "Find: keymaps",
			},
			{
				"<leader>fd",
				function()
					require("mini.extra").pickers.diagnostic()
				end,
				desc = "Find: diagnostics",
			},
			{
				"<leader>fr",
				function()
					require("mini.extra").pickers.oldfiles()
				end,
				desc = "Find: recent",
			},
		},
		opts = {},
	},
}
