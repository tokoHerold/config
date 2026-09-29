vim.keymap.set('n', "<leader><leader>", require('plugins/config/window_picker').focus_selected_window, { desc = "Select Window" })

local function swap_current_window_with()
	local win = require("window-picker").pick_window({ filter_rules = { include_current_win = false } })
	local buf1 = vim.api.nvim_get_current_buf()
	local buf2 = vim.api.nvim_win_get_buf(win)
	vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf2)
	vim.api.nvim_win_set_buf(win, buf1)
	vim.api.nvim_set_current_win(win)
end
vim.keymap.set('n', "<leader>mw", swap_current_window_with)
