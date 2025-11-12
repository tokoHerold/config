local treesitter      = require("nvim-treesitter.configs")

local M               = {}

local keymaps         = {}
local selection_modes = {}
local move_next_start = {}
local move_next_end   = {}
local move_prev_start = {}
local move_prev_end   = {}
local move_next       = {}
local move_prev       = {}
local lsp_interop     = {
				enable = true,
				border = 'none',
				floating_preview_opts = {},
				-- peek_definition_code = {
				-- 	["<leader>df"] = "@function.outer",
				-- 	["<leader>dF"] = "@class.outer",
				-- },
			}

M.add_selection       = function(keybind, capture_group, description, selection_mode)
	keymaps[keybind] = { query = capture_group, desc = description }
	if selection_mode then
		selection_modes[capture_group] = selection_mode
	end
end

M.add_movement        = function(capture, desc, next_start, next_end, prev_start, prev_end, next, prev)
	move_next_start[next_start] = { query = capture, desc = "Next " .. desc .. " start" }
	move_next_end[next_end] = { query = capture, desc = "Next " .. desc .. " end" }
	move_prev_start[prev_start] = { query = capture, desc = "Prev " .. desc .. " start" }
	move_prev_end[prev_end] = { query = capture, desc = "Prev " .. desc .. " end" }
	if next then
		move_next[next] = { query = capture, desc = "Next " .. desc .. " start/end" }
	end
	if prev then
		move_prev[prev] = { query = capture, desc = "Prev " .. desc .. " start/end" }
	end
end

M.add_lsp_bind = function(capture, option, keybind)
	local op = lsp_interop[option]
	if op then
		op[keybind] = capture
	else
		lsp_interop[option] = {[keybind] = capture}
	end
end

-- should be called whenever the config was changed by another method call of this module
M.setup               = function()
	treesitter.setup({
		auto_install = true,
		highlight = {
			enable = true, -- use treesitter syntax highlighting
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true }, -- use treesitter indentation when pressing '='
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = keymaps,
				selection_modes = selection_modes,
				include_surrounding_whitespace = true,
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = move_next_start,
				goto_next_end = move_next_end,
				goto_previous_start = move_prev_start,
				goto_previous_end = move_prev_end,
				goto_next = move_next,
				goto_previous = move_prev,
			},
			lsp_interop = lsp_interop,
		}
	})
end

M.setup()
return M


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
