local map = vim.keymap.set

-- Better escaping
map({ "i", "v" }, "jk", "<esc>")
map({ "i", "v" }, "kj", "<esc>")

map({"i", "v", "n" }, "<esc>", "<esc>:noh<CR>")

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

map("n", "<A-down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Neat shortcuts
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "aa", "A")
