-- Jump to last cursor postion
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

-- associate .h with correct file types
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.h",
	callback = function()
		vim.bo.filetype = "c"
	end,
})

-- associate .vert with glsl file type
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.vert",
	callback = function()
		vim.bo.filetype = "glsl"
	end,
})

-- associate .frag with glsl file type
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.frag",
	callback = function()
		vim.bo.filetype = "glsl"
	end,
})

vim.api.nvim_create_augroup("AutoEqualizeSplits", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = "AutoEqualizeSplits",
	command = "wincmd =",
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
