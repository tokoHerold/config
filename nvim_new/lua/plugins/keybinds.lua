local set = vim.keymap.set

-- Telescope
local builtin = require("telescope.builtin")
local wk = require("which-key")
wk.add({{ "<leader>f", desc="Find" }})
set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
set('n', '<leader>p', builtin.find_files, { desc = 'Find files' })
set('n', '<leader>fF', "<cmd>Telescope find_files cwd=~<cr>", { desc = 'Find files (home)' })
set('n', '<leader>fc', "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", { desc = 'Config Files' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
set({'n', 'i' }, '<C-f>', builtin.current_buffer_fuzzy_find, { desc = 'Buffers' })
set('n', '<leader>fr', builtin.registers, { desc = 'Registers' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
set('n', "<leader>fG", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })
set("n", "<leader>w", ":Telescope file_browser path=%:p:h<cr><esc>", { desc = "File browser" })
set("n", "<leader>fv", require("telescope").extensions.lazygit.lazygit, { desc = "Version Control" } )
set('n', '<leader>ft', builtin.treesitter, { desc = 'Treesitter' })

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
set('n',  "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit (CWD as project root)" })
set('n',  "<leader>gf", "<cmd>LazyGit<cr>", { desc = "LazyGit (Current file as project root)" })
set('n',  "<leader>gc", "<cmd>LazyGitFilter<cr>", { desc = "Commits" })

-- Treesitter
wk.add({"<leader>t", desc = "Treesitter"})
set('n', "<leader>ti", ":checkhealth nvim-treesitter<cr>)", {desc = "Info"}) 
set('n', "<leader>tt", ":InspectTree<cr>)", {desc = "Inspect Tree"})
wk.add({"gr", desc = "Incremental Selection"})
require("nvim-treesitter.configs").setup({ incremental_selection = { enable = true, keymaps = {
	init_selection = "gnn", -- set to `false` to disable one of the mappings
	node_incremental = "grn",
	scope_incremental = "grc",
	node_decremental = "grm",
} } })



