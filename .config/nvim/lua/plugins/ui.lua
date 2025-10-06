return {
	{
		"stevearc/oil.nvim",
    lazy = false,
		opts = {
			delete_to_trash = true,
			default_file_explorer = true,
			watch_for_changes = true,
      skip_confirm_for_simple_edits = false,
			constrain_cursor = "editable",
      cleanup_delay_ms = 200,
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      lsp_file_methods = {
        enabled = true,
      },
			columns = {
				"permissions",
				"size",
				"mtime",
				"icon",
			},
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
			view_options = { show_hidden = true, },
			float = { border = "none", },
			preview = { border = "none", },
			confirmation = { border = "none", },
			progress = { border = "none", },
			ssh = { border = "none", },
			keymaps_help = { border = "none", },
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["gx"] = function()
          -- Override the default app for zip files
          local entry = require("oil").get_cursor_entry()
          if not entry then return end

          local path = require("oil").get_current_dir() .. "/" .. entry.name

          if path:match("%.zip$") or path:match("%.7z$") or path:match("%.rar$") then
            vim.cmd("!7z x " .. vim.fn.shellescape(path) .. " -o" .. vim.fn.shellescape(require("oil").get_current_dir()))
          elseif path:match("%.tar.gz$") or path:match("%.tar.xz$") then
            vim.cmd("!tar -xvf " .. vim.fn.shellescape(path))
          else
            require("oil.actions").open_external.callback()
          end
        end,
			},
		},
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
		"nvim-lualine/lualine.nvim",
    dependencies = {
      "ficcdaf/ashen.nvim",
    },
		opts = {
				options = {
					theme = "auto",
					component_separators = "|",
					section_separators = "",
				},
				extensions = {
	         "fzf",
	         "oil",
	         "fugitive",
	         "mason",
	         "lazy",
	         "man",
	       },
			}
    },
    {
      "ficcdaf/ashen.nvim",
      tag = "*",
      lazy = false,
      priority = 1000,
      opts = {
        style_presets = {
          bold_functions = true,
          italic_comments = true,
        },
      },
      config = function(_, opts)
        require("ashen").setup(opts)
        vim.cmd.colorscheme("ashen")
      end,
    },
    -- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		terminal_colors = true,
	-- 		undercurl = true,
	-- 		underline = true,
	-- 		bold = true,
	-- 		italic = {
	-- 			strings = true,
	-- 			emphasis = true,
	-- 			comments = true,
	-- 			operators = false,
	-- 			folds = true,
	-- 		},
	-- 		strikethrough = true,
	-- 		invert_selection = false,
	-- 		invert_signs = false,
	-- 		invert_tabline = false,
	-- 		invert_intend_guides = false,
	-- 		inverse = true,
	-- 		contrast = "",
	-- 		palette_overrides = { },
	-- 		overrides = {
	-- 			SignColumn = { bg = "NONE" },
	-- 			Normal = { bg = "NONE" },
	-- 			GruvboxRedSign = { bg = "NONE" },
	-- 			GruvboxGreenSign = { bg = "NONE" },
	-- 			GruvboxYellowSign = { bg = "NONE" },
	-- 			GruvboxBlueSign = { bg = "NONE" },
	-- 			GruvboxPurpleSign = { bg = "NONE" },
	-- 			GruvboxAquaSign = { bg = "NONE" },
	-- 			GruvboxOrangeSign = { bg = "NONE" },
	--      },
	-- 		dim_inactive = false,
	-- 		transparent_mode = false,
	-- 	},
	--    config = function(_, opts)
	--      require("gruvbox").setup(opts)
	--      vim.cmd.colorscheme("gruvbox")
	--    end,
	-- },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  }
}
