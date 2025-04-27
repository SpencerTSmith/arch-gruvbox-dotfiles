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
