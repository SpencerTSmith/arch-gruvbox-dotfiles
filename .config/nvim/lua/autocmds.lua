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
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "*.h",
--   callback = function()
--     vim.bo.filetype = "c"
--   end,
-- })

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
	command = "tabdo wincmd =",
})

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
