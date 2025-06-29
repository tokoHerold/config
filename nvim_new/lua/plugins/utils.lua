local telescope_state = require('telescope.actions.state')

local M = {}

M.telescope_is_file = function()
	local entry = telescope_state.get_selected_entry()
	return not entry.is_dir
end

return M
