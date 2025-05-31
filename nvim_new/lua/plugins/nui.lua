local Input = require("nui.input")

-- Override ui.input
local function input_dialog(opts, callback)
	local prompt = opts.prompt or "Input"
	prompt = vim.trim(prompt)
	local reee = vim.api.nvim_get_current_win()
	local popup_options = {
		relative = "cursor",
		position = {
			row = 3,
			col = 0,
		},
		size = 100,
		border = {
			style = "default",
			text = {
				top = prompt,
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	}

	local input = Input(popup_options, {
		prompt = "> ",
		default_value = opts.default or "",
		on_submit = callback
	})
	input:map("n", "<Esc>", function() input:unmount() end, { noremap = true })
	input:mount()
end
vim.ui.input = input_dialog


