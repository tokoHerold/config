local map = vim.keymap.set

local function format_document() -- Save the current cursor position and view
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local view = vim.fn.winsaveview()

	-- Format the entire buffer using the = operator
	vim.cmd('normal! gg=Gzz')

	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(0, cursor_pos)
	vim.fn.winrestview(view)
end

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
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("v", "<C-c>", "\"+y", { desc = "Copy" })
map("i", "<C-v>", "<esc>:set paste<cr>\"+p:set nopaste<cr>i", { desc = "Paste" })
map("n", "aa", "A")
map("n", "<s-tab>", "<<")

-- Buffers
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })           -- Use LSP formatting
map({ "i", "n" }, "<A-l>", format_document, { desc = "Format document" }) -- Use internal filter formatting
-- map("n", "<C-A-Left>", function() vim.print("Test") end)
-- -- map("n", "<C-A-Right>", ">")
-- map('n', '<C-A-Right>', ':vertical resize +2<CR>')
-- map("n", "<C-A-Up>", "<C-w>+")
-- map("n", "<C-A-Down>", "<C-w>-")
--
-- Resize window with Control + Alt + Arrow keys
map('n', '<C-A-Up>', ':resize +2<CR>', { noremap = true, silent = true })
map('n', '<C-A-Down>', ':resize -2<CR>', { noremap = true, silent = true })
map('n', '<C-A-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
map('n', '<C-A-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })


-- Terminal Mappings
map('t', "<esc>", "<C-\\><C-n>")
