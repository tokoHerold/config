local coq = require('coq')
local M = {}

--== AUTOSTART ==--
require("mason-lspconfig").setup {
	automatic_enable = false, -- need to attach some stuff
}

local custom_servers = { "gdscript" }

-- Attach coq to lsp servers
local function setup_lsp(server_name)
	vim.lsp.config(server_name, coq.lsp_ensure_capabilities({}))
	vim.lsp.enable(server_name)
end

-- Retrieves all lsp servers installed with mason and calls setup
local function setup()
	for _, server in pairs(require('mason-lspconfig').get_installed_servers()) do
		setup_lsp(server)
	end
	-- Custom LSPs
	for _, server in pairs(custom_servers) do
		setup_lsp(server)
	end
end
M.setup = setup

-- Set up LSP servers on startup
setup()


--== STYLE ERRORS/WARNINGS ==--
vim.diagnostic.config({
	virtual_lines = true,
})

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
