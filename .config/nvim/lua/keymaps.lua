-- Keymaps
vim.keymap.set("n", "<Esc>", '<C-c><cmd>nohlsearch<CR><cmd>echo ""<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- just in case we ever want to move in the command line
vim.keymap.set("c", "<A-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("c", "<A-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("c", "<A-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("c", "<A-l>", "<Right>", { noremap = true, silent = true })

vim.keymap.set("n", "gO", "O<esc>", { desc = "Insert empty line above" })
vim.keymap.set("n", "go", "o<esc>", { desc = "Insert empty line below" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("x", "gp", [["_dP]], { desc = "Paste without replacing register" })

-- n always forward, N always backward
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- better indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- function align_equals()
--   -- visual selection
--   local start_line = vim.fn.line("'<")
--   local end_line   = vim.fn.line("'>")
--
--   -- all the lines in the selection
--   local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
--
--   local max_pos = 0
--   local line_data = {}
--
--   -- go through each looking for equals to balance
--   for i, line in ipairs(lines) do
--     local equals_pos = string.find(line, "=")
--     if equals_pos then
--       -- we have an equal sign, split them up and insert into table
--       local before_equals = string.match(line, "^(.-)%s*=")
--       if before_equals then
--         local trimmed_pos = string.len(before_equals)
--         max_pos = math.max(max_pos, trimmed_pos) -- update max position
--
--         local after_equals = string.match(line, "=%s*(.*)")
--         table.insert(line_data, {
--           before = before_equals,
--           after = after_equals or "",
--           original_line = i
--         })
--       end
--     else
--       -- don't change if no equals
--       table.insert(line_data, {
--         before = line,
--         after = nil,
--         original_line = i
--       })
--     end
--   end
--
--   local new_lines = {}
--   -- construct, add padding to the max length
--   for _, data in ipairs(line_data) do
--     if data.after ~= nil then
--       local padding = string.rep(" ", max_pos - string.len(data.before))
--       local new_line = data.before .. padding .. " = " .. data.after
--       table.insert(new_lines, new_line)
--     else
--         table.insert(new_lines, data.before)
--     end
--   end
--
--     vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
-- end
-- vim.api.nvim_create_user_command('AlignEquals', align_equals(), { range = true })
-- vim.keymap.set("x", "gb", ":<C-u>lua align_equals()<CR>", {desc = "Balance ="})

local diagnostics_enabled = true

vim.keymap.set("n", "<leader>td", function()
	diagnostics_enabled = not diagnostics_enabled
	if diagnostics_enabled then
		vim.diagnostic.enable()
    print("Diagnostics enabled")
	else
		vim.diagnostic.enable(false)
    print("Diagnostics disabled")
	end

end, { desc = "Toggle diagnostics"})
