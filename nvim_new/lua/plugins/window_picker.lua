wp = require("window-picker")
wp.setup({
	hint = "floating-big-letter",
})


function focus_selected_window()
	-- Use the window-picker to select a window
	local selected_window_id = wp.pick_window({
		prompt_message = 'Jump to window:',
		filter_rules = { include_current_win = false },
	})
	-- If a window was selected, set focus to it
	if selected_window_id then
		vim.api.nvim_set_current_win(selected_window_id)
	else
		print("No window selected")
	end
end

return {
	focus_selected_window = focus_selected_window
}
