-- Enable treesitter highlighting
local ts = require("nvim-treesitter")
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

-- Enable indentation

-- local ts_parsers = require("nvim-treesitter.parsers")

-- vim.api.nvim_create_autocmd("BufEnter", {
	--   pattern = { "*" },
	--   callback = function()
		--     local ft = vim.bo.filetype
		-- pattern = { '<filetype>' },
		--     if not ft then
		--       return
		--     end
		--     local parser = ts_parsers.filetype_to_parsername[ft]
		--     if not parser then
		--       return
		--     end
		--     local is_installed = ts_parsers.has_parser(ts_parsers.ft_to_lang(ft))
		--     if not is_installed then
		--       vim.cmd("TSInstall " .. parser)
		--     end
		--   end,
		-- }) fh
