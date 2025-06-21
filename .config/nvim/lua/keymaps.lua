-- Keymaps
vim.keymap.set("n", "<Esc>", '<C-c><cmd>nohlsearch<CR><cmd>echo ""<CR>', { noremap = true, silent = true })

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
