return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufEnter", "VeryLazy" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang", [".vert"] = "glsl", [".frag"] = "glsl" },
		})
	end
}
