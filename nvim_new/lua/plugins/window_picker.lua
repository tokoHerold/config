wp = require("window-picker")
wp.setup({
	hint = "floating-big-letter",
})


function focus_selected_window()
    -- Use the window-picker to select a window
    local selected_window_id = wp.pick_window({
        include_current_win = false, -- Exclude the current window from selection
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

