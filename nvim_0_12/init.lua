--vim.treesitter.start()
-- Load vim options
require("config.options")

-- Start Plugin Manager and configure plugins
require("plugins.lazy")
local plugins_path = vim.fn.stdpath('config') .. '/lua/plugins/config/'
for _, file in ipairs(vim.fn.readdir(plugins_path)) do
	if file:match('%.lua$') then
		-- require('plugins.' .. file:sub(1, -5))  -- Remove .lua extension
		local config = 'plugins.config.' .. file:sub(1, -5) -- remove .lua
		local ok, res = pcall(require, config)
		if not ok then
		  vim.notify(("Error loading %s: %s"):format(file, res), vim.log.levels.ERROR)
		end
	end
end

-- Custom keybinds
require("config.keybinds")

-- Plugin Keybinds
local plugin_keybinds = vim.fn.stdpath('config') .. '/lua/plugins/keybinds/'
for _, file in ipairs(vim.fn.readdir(plugin_keybinds)) do
	if file:match('%.lua$') then
		-- require('plugins.' .. file:sub(1, -5))  -- Remove .lua extension
		local config = 'plugins.keybinds.' .. file:sub(1, -5) -- remove .lua
		local ok, res = pcall(require, config)
		if not ok then
		  vim.notify(("Error loading %s: %s"):format(config, res), vim.log.levels.ERROR)
		end
	end
end
