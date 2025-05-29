vim.diagnostic.config({
	virtual_lines = true,
})

local M = {}
local state = 0

-- Toggles style of diagnostis: virtual line -> virtual text -> none
M.toggle = function()
	local text = false
	local lines = false
	if state == 0 then
		text = true
		state = 1
	elseif state == 1 then
		state = 2
	else
		lines = true
		state = 0
	end
	vim.diagnostic.config({
		virtual_text = text,
		virtual_lines = lines,
	})
end

return M
