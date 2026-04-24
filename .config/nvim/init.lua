
-- Options
-- ##########################################

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true
vim.g.c_syntax_for_h = true

vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.tabstop = 2
vim.o.smarttab = true

vim.o.title = true

vim.o.smartindent = true
vim.o.autoindent = true
vim.o.cindent = true
vim.opt.cinoptions:append("(0,m1,W4,{0,}0,?1s,:1s")

vim.o.breakindent = true

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
-- Line numbers and such
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
-- vim.o.colorcolumn = "120"
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.cursorline = true

vim.o.syntax = "enable"

-- Decrease update time
vim.o.updatetime = 200

vim.o.list = true
vim.opt.listchars = { tab = "  ", extends = ">", precedes = "<", trail = "~", nbsp = "␣" }
vim.opt.showbreak = "↪"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 0

-- status line does it
vim.o.showmode = false
vim.o.ruler = false
vim.o.cmdheight = 1
vim.o.laststatus = 3

-- Preview substitutions live, as you type!
vim.o.incsearch = true

vim.o.undofile = true
vim.o.undodir = vim.fn.expand"~/.cache/nvim/"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.o.confirm = true

vim.o.backspace = "indent,eol,start"

-- Sync up default register with system clipboard
vim.o.clipboard = "unnamedplus"

vim.diagnostic.config({ virtual_text = true })

vim.o.linebreak = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

vim.o.virtualedit = "block,onemore"

vim.opt.winborder = "none"
vim.o.winblend = 10

-- vim.o.complete = ".,o" -- use buffer and omnifunc
-- vim.opt.completeopt = "menu,menuone,noselect,popup"
-- vim.o.autocomplete = true
vim.o.pumblend = 10
vim.o.pumheight = 10

vim.o.equalalways = true

vim.o.hlsearch = true

vim.opt.shortmess:append("aWCc")
vim.opt.formatoptions:remove("ro")

vim.opt.path:append("**")

-- ##########################################
-- Keybinds
-- ##########################################

vim.keymap.set("n", "<Esc>", '<C-c><cmd>nohlsearch<CR><cmd>echo ""<CR>', { noremap = true, silent = true })

-- The greatest keymap of all time...
-- just makes sure indent on a blank line gets the right indent
vim.keymap.set('n', 'i', function ()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil
         and 'cc' or 'i'
end, {expr=true, noremap=true})

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- move lines and keep indentation in normal mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "gO", "O<esc>", { desc = "Insert empty line above" })
vim.keymap.set("n", "go", "o<esc>", { desc = "Insert empty line below" })

-- Cursor line in the middle!
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Cursor stays put when joining lines
vim.keymap.set("n", "J", "m`J``")

vim.keymap.set("x", "gp", [["_dP]], { desc = "Paste without replacing register" })

vim.keymap.set({"n", "v"}, "gh", "^", { desc = "Go to start of line"})
vim.keymap.set({"n", "v"}, "gl", "$", { desc = "Go to end of line"})

-- n always forward, N always backward
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- better indent, don't lose selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Easily yank brackets
vim.keymap.set("n", "YY", "va{Vy")

vim.keymap.set("n", "<leader>td", function()
  local enabled = vim.diagnostic.is_enabled()

	vim.diagnostic.enable(not enabled)

  if enabled then
    print("Diagnostics disabled")
  else
    print("Diagnostics enabled")
  end
end, { desc = "Toggle diagnostics"})

-- ##########################################
-- Autocmds
-- ##########################################

-- Jump to last cursor postion when opening buffer
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = lastplace,
  pattern = { "*" },
  desc = "remember last cursor place",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Associate .vert with glsl file type
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.vert",
	callback = function()
		vim.bo.filetype = "glsl"
	end,
})

-- Associate .frag with glsl file type
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.frag",
	callback = function()
		vim.bo.filetype = "glsl"
	end,
})

-- Spellcheck on some text filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

-- Close more things with q
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Close quickfix when selecting something
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>:cclose<CR>", { noremap = true, silent = true })
  end,
})

-- Auto resize splits when the window resizes
vim.api.nvim_create_augroup("AutoEqualizeSplits", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = "AutoEqualizeSplits",
	command = "tabdo wincmd =",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Auto-create parent directories when saving
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.tbl_contains({ "oil" }, vim.bo.ft) then
      return
    end
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end
})

-- ##########################################
-- Plugins
-- ##########################################

vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") }
})

require("oil").setup({
  delete_to_trash = true,
  watch_for_changes = true,
  cleanup_delay_ms = 200,
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
    ["gx"] = function()
      local oil = require("oil")
      local entry = oil.get_cursor_entry()
      if not entry then return end

      local dir  = oil.get_current_dir()
      local path = dir .. "/" .. entry.name
      local escaped_path = vim.fn.shellescape(path)
      local escaped_dir  = vim.fn.shellescape(dir)

      local tar_patterns = {
        "%.tar$", "%.tar%.gz$", "%.tgz$",
        "%.tar%.bz2$", "%.tbz2$",
        "%.tar%.xz$", "%.txz$",
      }
      for _, pat in ipairs(tar_patterns) do
        if path:match(pat) then
          vim.cmd("!tar -xf " .. escaped_path .. " -C " .. escaped_dir)
          return
        end
      end

      local sevenz_patterns = {
        "%.zip$", "%.7z$", "%.rar$",
      }
      for _, pat in ipairs(sevenz_patterns) do
        if path:match(pat) then
          vim.cmd("!7z x " .. escaped_path .. " -o" .. escaped_dir)
          return
        end
      end
      require("oil.actions").open_external.callback()
    end,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require('lualine').setup({
  options = {
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
})

require("gruvbox").setup({
  terminal_colors = true,
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
  invert_intend_guides = false,
  inverse = true,
  contrast = "",
  overrides = {
    SignColumn = { bg = "NONE" },
    Normal = { bg = "NONE" },
    GruvboxRedSign = { bg = "NONE" },
    GruvboxGreenSign = { bg = "NONE" },
    GruvboxYellowSign = { bg = "NONE" },
    GruvboxBlueSign = { bg = "NONE" },
    GruvboxPurpleSign = { bg = "NONE" },
    GruvboxAquaSign = { bg = "NONE" },
    GruvboxOrangeSign = { bg = "NONE" },
  },
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd.colorscheme("gruvbox")

require("gitsigns").setup({
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
})

require("nvim-treesitter").install({
  "c",
  "cpp",
  "odin",
  "lua",
  "bash",
  "glsl",
  "json",
  "python",
  "ini",
  "hyprlang",
})
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function()
        require("nvim-treesitter").update()
    end
})
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang ~= nil and vim.treesitter.language.add(lang) then
      vim.treesitter.start()
    end
  end
})

require('nvim-autopairs').setup({
  check_ts = true,
})

vim.keymap.set("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>"     )
vim.keymap.set("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>"     )
vim.keymap.set("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>"       )
vim.keymap.set("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>"    )
vim.keymap.set("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>")

require("mini.hipatterns").setup({
  highlighters = {
    fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
    hack  = { pattern = 'HACK',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = 'TODO',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = 'NOTE',  group = 'MiniHipatternsNote'  },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
})

local spec_treesitter = require("mini.ai").gen_spec.treesitter
require("mini.ai").setup({
  custom_textobjects = {
    l = spec_treesitter({ a = { "@loop.outer" }, i = { "@loop.inner" } }),
    i = spec_treesitter({ a = { "@conditional.outer" }, i = { "@conditional.inner" } }),
    f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
  },
})

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

require("mini.icons").setup()

require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  skip_unbalanced = true,
  skip_ts = { "string" },
  markdown = true,
})

require("snacks").setup({
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
})

require("which-key").setup({
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
})

require("fzf-lua").setup({
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
      horizontal = "right:50%",
    },
  },
  fzf_opts = { ["--tmux"] = "bottom,100%,20%" },
  actions = {
    files = {
      true,
    },
  },
  files = {
    git_icons = true
  }
})
vim.keymap.set("n", "<leader>fH", "<cmd>FzfLua help_tags<cr>",                                { desc = "Find: help" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>",                                    { desc = "Find: files" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua files cwd=~<cr>",                              { desc = "Find: files in home" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep_native<cr>",                         { desc = "Find: grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Find: buffers" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>",                                  { desc = "Find: keymaps" })
vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>",                    { desc = "Find: diagnostics" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>",                                 { desc = "Find: recent" })
vim.keymap.set("n", "<leader>fM", "<cmd>FzfLua man_pages<cr>",                                { desc = "Find: man pages" })

require("blink.cmp").setup({
	fuzzy = {
		prebuilt_binaries = { force_version = "v1.10.0", download = true },
	},
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    accept = { auto_brackets = { enabled = true, }, },
    list = {
      selection = {
        preselect = false, auto_insert = true
      },
    },
    menu = {
      auto_show = false,
      draw = { treesitter = { "lsp" }, },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    ghost_text = {
      enabled = true,
      show_with_menu = false,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = { enabled = true },
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = {
      menu = { auto_show = false },
      list = {
        selection = {
          preselect = false, auto_insert = true
        },
      },
    },
  },
  keymap = {
    preset = "default",
  },
})

require("mason").setup()

require("mason-lspconfig").setup({
  automatic_enable = true,
  ensure_installed = {
    "lua_ls",
    "clangd",
    "glsl_analyzer",
    "hyprls",
    "pyright",
    "bashls",
    "slangd",
    "ols",
  },
})
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client ~= nil then
      if client.server_capabilities.documentHighlightProvider then
        client.server_capabilities.documentHighlightProvider = false
      end
      client.server_capabilities.semanticTokensProvider = nil

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {noremap = true, silent = true})
    end
  end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }, -- Recognize 'vim' global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
		},
	},
})
