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
set('n', '<leader>fm', builtin.man_pages, { desc = 'Man pages' })
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

-- Gitsigns
local gitsigns = require("gitsigns")
-- wk.add("")
set('n', "<leader>gd", gitsigns.diffthis, { desc = "View diff" })
set('n', "<leader>gb", gitsigns.blame, { desc = "Blame" })
set('n', "gb", gitsigns.blame_line, { desc = "Git Blame" })
wk.add({ "<leader>gh", desc = "Hunk..." })
set('n', "<leader>ghs", gitsigns.select_hunk, { desc = "Select" })
set('n', "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview" })
set('n', "<leader>gh ", gitsigns.stage_hunk, { desc = "Stage" })
set('n', "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset" })
set('n', "<leader>gt", gitsigns.toggle_word_diff, { desc = "Toggle Diff" })
set('n', "[h", function() gitsigns.nav_hunk('prev') end, { desc = "Prev Git Hunk" })
set('n', "]h", function() gitsigns.nav_hunk('next') end, { desc = "Next Git Hunk" })
set('n', "[H", function() gitsigns.nav_hunk('prev') end, { desc = "Prev Git Hunk" })
set('n', "]H", function() gitsigns.nav_hunk('last') end, { desc = "Last Git Hunk" })


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
-- Treesitter textobjects
local to = require('plugins.treesitter')
-- Args: keybind, capture, desc
to.add_selection("af", "@function.outer", "Outer function")
to.add_selection("if", "@function.inner", "Inner function")
to.add_selection("ad", "@assignment.outer", "Outer assignment")
to.add_selection("id", "@assignment.inner", "Inner assignment")
to.add_selection("ac", "@class.outer", "Outer class")
to.add_selection("ia", "@parameter.inner", "Inner argument")
to.add_selection("aa", "@parameter.outer", "Outer argument")
to.add_selection("im", "@attribute.inner", "Inner member")
to.add_selection("am", "@attribute.outer", "Outer member")
to.add_selection("ii", "@conditional.inner", "Inner if")
to.add_selection("ai", "@conditional.outer", "Outer if")
to.add_selection("il", "@loop.inner", "Inner loop")
to.add_selection("al", "@loop.outer", "Outer loop")
to.add_selection("i#", "@comment.inner", "Inner comment")
to.add_selection("a#", "@comment.outer", "Outer comment")
-- Args: capture, desc, next start, next end, prev start, prev end, next, prev
to.add_movement("@function.outer", "function", "]f", "]F", "[f", "[F", "]e", "[e")
to.add_movement("@parameter.inner", "argument", "]a", "]A", "[a", "[A")
to.add_movement("@assignment.outer", "assignment", "]d", "]D", "[d", "[D")
to.add_movement("@class.outer", "class", "]c", "]C", "[c", "[C")
to.add_movement("@conditional.outer", "if", "]i", "]I", "[i", "[I")
to.add_movement("@loop.outer", "loop", "]l", "]L", "[l", "[L")
to.setup()
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
-- Repeat movement with ; and ,
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

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
set('n', "<leader>ct", lspconf.toggle, { desc = "Toggle Diagnostic Style" })
set('n', "<leader>cr", lspconf.setup, { desc = "Reload LSP" })

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
set("n", "<leader>ta", ":$tabnew<CR>", { noremap = true, desc = "New" })
set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "Close" })
set("n", "<leader>to", ":tabonly<CR>", { noremap = true, desc = "Close others" })
set("n", "<leader>tn", ":tabn<CR>", { noremap = true, desc = "Next" })
set("n", "<leader>tp", ":tabp<CR>", { noremap = true, desc = "Previous" })
wk.add({ "<leader>tm", desc = "Move" })
set("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true, desc = "Backwards" })
set("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true, desc = "Forwards" })

-- Neotree
set("n", "<leader>e", "<CMD>Neotree toggle<CR>")
set("n", "<leader>r", "<CMD>Neotree focus<CR>")

-- ToggleTerm
set('n', "<C-t>", ":ToggleTerm<cr>", { desc = "Terminal" })
set('t', "<C-t>", function() vim.cmd("ToggleTerm") end, { desc = "Terminal" })

-- Iron (REPL)
local iron = require('iron.core')
wk.add({ "<leader>i", desc = "Interactive REPL" })
set('n', '<leader>if', '<cmd>IronFocus<cr>', { desc = "Focus" })
set('n', '<leader>ih', '<cmd>IronHide<cr>', { desc = "Hide" })
set("n", "<leader>it", "<cmd>IronRepl<cr>", { desc = "Toggle" })
set("n", "<leader>ir", "<cmd>IronRestart<cr>", { desc = "Restart" })
wk.add({ "<leader>is", desc = "Send..." })
set("n", "<leader>isb", iron.send_code_block, { desc = "Code block" })
set("n", "<leader>isf", iron.send_file, { desc = "Send file" })
set("n", "<leader>isl", iron.send_line, { desc = "Send line" })
wk.add({ "<leader>ism", desc = "Motion" })
wk.add({ "<leader>i", desc = "Interactive REPL", mode = "v"})
wk.add({ "<leader>is", desc = "Selection", mode = "v"})
wk.add({ "<leader>ix", desc = "Interrupt" })
wk.add({ "<leader>iq", desc = "Quit" })
wk.add({ "<leader>ic", desc = "Clear" })

