local set = vim.keymap.set
local wk = require("which-key")

-- Telescope
local builtin = require("telescope.builtin")
-- Normal Mappings
wk.add({ { "<leader>f", desc = "Find" } })
set('n', '<leader>ff', builtin.find_files, { desc = 'Files (CWD)' })
set('n', '<leader>fF', "<cmd>Telescope find_files cwd=~<cr>", { desc = 'Files (Home)' })
set('n', '<leader>fc', "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", { desc = 'Config Files' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recently opened' })
set('n', '<leader>fx', builtin.commands, { desc = 'Commands' })
set('n', '<leader>fr', builtin.registers, { desc = 'Registers' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
set('n', "<leader>fG", "<cmd>Telescope git_files<cr>", { desc = "Git files)" })
set("n", "<leader>fV", require("telescope").extensions.lazygit.lazygit, { desc = "Version Control" })
set('n', '<leader>ft', builtin.treesitter, { desc = 'Treesitter' })
-- Code Mappings
set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'Definitions' })
set('n', '<leader>fe', function() builtin.diagnostics({ bufnr = 0 }) end, { desc = 'Errors/Warnings' })
set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementations' })
set('n', '<leader>fy', builtin.lsp_type_definitions, { desc = 'Type Definitions' })
set('n', '<leader>fv', builtin.lsp_references, { desc = 'Variables under cursor' })
set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Symbols' })
set('n', '<leader>fS', builtin.lsp_workspace_symbols, { desc = 'All Symbols' })
-- Special Mappings
set('n', '<leader>p', builtin.find_files, { desc = 'Find files' })
set('c', '<C-r>', builtin.command_history, { desc = 'Command history' })
set({ 'n', 'i' }, '<C-f>', builtin.current_buffer_fuzzy_find, { desc = 'Buffers' })
set("n", "<leader>w", ":Telescope file_browser path=%:p:h<cr><esc>", { desc = "File browser" })

-- Window Picker
local wp = require("window-picker")
set('n', "<leader><leader>", require('plugins/window_picker').focus_selected_window, { desc = "Select Window" })
-- Function to swap the current window with a specified window
local function swap_current_window_with()
	local win = wp.pick_window({ filter_rules = { include_current_win = false } })
	local buf1 = vim.api.nvim_get_current_buf()
	local buf2 = vim.api.nvim_win_get_buf(win)
	vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf2)
	vim.api.nvim_win_set_buf(win, buf1)
	vim.api.nvim_set_current_win(win)
end
set('n', "<leader>mw", swap_current_window_with)

-- Lazygit
wk.add({ "<leader>g", desc = "Git" })
set('n', "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit (CWD as project root)" })
set('n', "<leader>gf", "<cmd>LazyGit<cr>", { desc = "LazyGit (Current file as project root)" })
set('n', "<leader>gc", "<cmd>LazyGitFilter<cr>", { desc = "Commits" })

-- Treesitter
set('n', "<leader>cc", ":checkhealth nvim-treesitter<cr>)", { desc = "Treesitter Info" })
set('n', "<leader>ct", ":InspectTree<cr>)", { desc = "Inspect Tree" })
wk.add({ "gr", desc = "Incremental Selection" })
require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		}
	}
})

-- LSP
local lspconf = require("plugins/lsp")
wk.add({ "<leader>c", desc = "Code" })
set('n', "<leader>cm", "<cmd>Mason<cr>")
set('n', "<leader>ci", "<cmd>LspInfo<cr>")
set({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Actions" })
set('n', "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
set({ 'n', 'v' }, "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
set({ 'n', 'v' }, "gi", vim.lsp.buf.declaration, { desc = "Goto Implementation" })
set({ 'n', 'v' }, "<leader>ce", vim.diagnostic.open_float, { desc = "Show Error/Warning" })
set({ 'n', 'v' }, "<F2>", vim.lsp.buf.rename)
set('n', "<leader>ct", lspconf.toggle, {desc = "Toggle Diagnostic Style"})
set('n', "<leader>cr", lspconf.setup, {desc = "Reload LSP"})

-- Focus
local focus = require("focus")
set('n', "<C-l>", focus.split_nicely, { desc = "Split nicely" })
set('n', "<leader><left>", function() focus.split_command('h') end, { desc = "Split left" })
set('n', "<leader>h", function() focus.split_command('h') end, { desc = "Split left" })
set('n', "<leader><right>", function() focus.split_command('l') end, { desc = "Split right" })
set('n', "<leader>l", function() focus.split_command('l') end, { desc = "Split right" })
set('n', "<leader><up>", function() focus.split_command('k') end, { desc = "Split up" })
set('n', "<leader>k", function() focus.split_command('k') end, { desc = "Split up" })
set('n', "<leader><down>", function() focus.split_command('j') end, { desc = "Split down" })
set('n', "<leader>j", function() focus.split_command('j') end, { desc = "Split down" })

-- Tab Line
wk.add({ "<leader>t", desc = "Tab" })
set("n", "<leader>ta", ":$tabnew<CR>", { noremap = true, desc = "New"})
set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "Close"})
set("n", "<leader>to", ":tabonly<CR>", { noremap = true, desc = "Close others" })
set("n", "<leader>tn", ":tabn<CR>", { noremap = true, desc = "Next" })
set("n", "<leader>tp", ":tabp<CR>", { noremap = true, desc = "Previous"})
wk.add({"<leader>tm", desc = "Move"})
set("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true, desc = "Backwards" })
set("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true, desc = "Forwards" })

-- Neotree
set("n", "<leader>e", "<CMD>Neotree toggle<CR>")
set("n", "<leader>r", "<CMD>Neotree focus<CR>")
