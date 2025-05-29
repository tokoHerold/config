-- Enable treesitter highlighting
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { 
		enable = true,  -- use treesitter syntax highlighting
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true }, -- use treesitter indentation when pressing '='
})


 -- Config for new main branch - currently does not work well with other plugins
--[[ local ts = require("nvim-treesitter")
local config = require("nvim-treesitter.config")
local async = require('plenary.async')

vim.api.nvim_create_autocmd('FileType', {
	pattern = config.get_available(), -- only use existing parsers
	callback = function()
		local ft = vim.bo.filetype
		ts.install(ft) -- install parser if necessary
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.notify("Treesitter: Loaded " .. ft .. " parser!", vim.log.levels.INFO)
	end,
})
--]]
