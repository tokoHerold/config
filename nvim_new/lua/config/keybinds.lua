local map = vim.keymap.set

-- Better movement
map("n", "j", "gj")
map("n", "k", "gk")

-- Better escaping
map({ "i" }, "jk", "<esc>")
map({ "i" }, "kj", "<esc>")
map({ "i" }, "jj", "<esc>")
map({ "i", "v", "n" }, "<esc>", "<esc>:noh<CR>")

-- -- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Neat shortcut
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- map("n", "<Leader>a", "ggVG", { desc = "Select all" })
-- map('i', '<C-BS>', '<esc>vbda', {  silent = true })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("v", "<C-c>", "\"+y", { desc = "Copy"} )
map("i", "<C-v>", "<esc>:set paste<cr>\"+p:set nopaste<cr>i", { desc = "Paste"} )
map("n", "aa", "A")

-- Buffers
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
-- map("n", "<C-A-Left>", function() vim.print("Test") end)
-- -- map("n", "<C-A-Right>", ">")
-- map('n', '<C-A-Right>', ':vertical resize +2<CR>')
-- map("n", "<C-A-Up>", "<C-w>+")
-- map("n", "<C-A-Down>", "<C-w>-")
--
-- Resize window with Control + Alt + Arrow keys
vim.api.nvim_set_keymap('n', '<C-A-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })
