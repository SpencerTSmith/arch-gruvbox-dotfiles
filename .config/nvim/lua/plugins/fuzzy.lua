return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
    fzf_bin = 'sk',
		fzf_colors = {
			true,
			["fg"] = { "fg", "CursorLine" },
			["bg"] = { "bg", "Normal" },
			["hl"] = { "fg", "Comment" },
			["fg+"] = { "fg", "Normal" },
			["bg+"] = { "bg", { "CursorLine", "Normal" } },
			["hl+"] = { "fg", "Operator" },
			["info"] = { "fg", "Comment" },
			["marker"] = { "fg", "CursorLine" },
			["pointer"] = { "fg", "PreProc" },
			["spinner"] = { "fg", "PreProc" },
			["header"] = { "fg", "Comment" },
      ["gutter"] = "-1",
		},
		winopts = {
			border = "none",
			height = 0.20,
			width = 1,
			row = 1,
			col = 0,
			backdrop = 100,
			treesitter = {
				enabled = false,
			},
			preview = {
				border = "none",
				scrollbar = false,
				horizontal = "right:50%", -- right|left:size
			},
		},
    fzf_opts = { ["--tmux"] = "bottom,20%,100%" },
		actions = {
			files = {
				true,
			},
		},
    files = {
      git_icons = true
    }
	},
	keys = {
		{ "<leader>f", "", desc = "Find: " },
		{
			"<leader>fH",
			"<cmd>FzfLua help_tags<cr>",
			desc = "Find: help",
		},
		{
			"<leader>ff",
			"<cmd>FzfLua files<cr>",
			desc = "Find: files",
		},
		{
			"<leader>fh",
			"<cmd>FzfLua files cwd=~<cr>",
			desc = "Find: files in home",
		},
		{
			"<leader>fg",
			"<cmd>FzfLua live_grep_native<cr>",
			desc = "Find: grep",
		},
		{
			"<leader>fb",
			"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
			desc = "Find: buffers",
		},
		{
			"<leader>fk",
			"<cmd>FzfLua keymaps<cr>",
			desc = "Find: keymaps",
		},
		{
			"<leader>fd",
			"<cmd>FzfLua diagnostics_workspace<cr>",
			desc = "Find: diagnostics",
		},
		{
			"<leader>fr",
			"<cmd>FzfLua oldfiles<cr>",
			desc = "Find: recent",
		},
		{ "<leader>fM", "<cmd>FzfLua man_pages<cr>", desc = "Find: man pages" },
	},
}
