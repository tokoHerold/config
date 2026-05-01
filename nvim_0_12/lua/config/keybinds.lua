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
map("n", "Y", "y$")         -- copy until end - line copy is already 'yy'
map({ "n", "v" }, "L", "$") -- Use L instead of $
map({ "n", "v" }, "H", "^") -- Use H instead of ^

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

-- Neat shortcuts
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("v", "<C-c>", "\"+y", { desc = "Copy" })
map("i", "<C-v>", "<esc>:set paste<cr>\"+p:set nopaste<cr>i", { desc = "Paste" })
map("n", "aa", "A")

-- Better indentation
map("n", ">", ">>")
map("n", "<", "<<")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Buffers
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })           -- Use LSP formatting
map({ "i", "n" }, "<A-l>", format_document, { desc = "Format document" }) -- Use internal filter formatting

-- Toggle Tabs and Spaces indent mode
local function toggle_indent()
	vim.api.nvim_buf_set_option(0, 'expandtab', not vim.api.nvim_buf_get_option(0, 'expandtab'))
end
map('n', '<Leader>ci', toggle_indent, { desc = 'Toggle Indent' })

-- Terminal Mappings
map('t', "<esc><esc>", "<C-\\><C-n>")
map('t', "<c-w>", function() vim.api.nvim_command('wincmd w') end)

-- LSP options
local state = 0
local function toggle_diagnostics()
	state = (state + 1) % 3
	vim.diagnostic.config({
		virtual_text  = state == 1,
		virtual_lines = state == 0,
	})
end
map({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Actions" })
map({ 'n', 'v' }, "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map({ 'n', 'v' }, "gi", vim.lsp.buf.declaration, { desc = "Goto Implementation" })
map({ 'n', 'v' }, "<leader>ce", vim.diagnostic.open_float, { desc = "Show Error/Warning" })
map({ 'n', 'v' }, "<F2>", vim.lsp.buf.rename)
map('n', "<leader>ct", toggle_diagnostics, { desc = "Toggle Diagnostic Style" })
