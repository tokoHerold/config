-- Load vim options
require("config.options")

-- Start Plugin Manager and configure plugins
require("config.lazy")
local plugins_path = vim.fn.stdpath('config') .. '/lua/plugins/'
for _, file in ipairs(vim.fn.readdir(plugins_path)) do
		if file:match('%.lua$') then
			require('plugins.' .. file:sub(1, -5))  -- Remove .lua extension
		end
end

-- Custom keybinds
require("config.keybinds")
