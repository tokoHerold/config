local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local actions = require("telescope.actions")
-- local builtin = require('telescope.builtin')
local utils = require('plugins.utils')

-- Clone the default Telescope configuration
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
local vimgrep_arguments = telescopeConfig.values.vimgrep_arguments

-- Search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- Don't search in `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

local function select_buf(prompt_bufnr)
	if utils.telescope_is_file() then
		require('telescope.actions.set').edit(prompt_bufnr, "EditAndPick")
	else
		require('telescope.actions').select_default(prompt_bufnr)
	end
end

local special_mapping = {
	i = {
		["<cr>"] = select_buf,
		["<a-cr>"] = "select_default",
	},
	n = {
		["<cr>"] = select_buf,
		["<a-cr>"] = "select_default",
	}
}

-- Setup
telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
		-- get_selection_window = function()
		-- 	return require('window-picker').pick_window({
		-- 		include_current_win = true, -- Include the current window in the selection
		-- 	})
		-- end,
		mappings = {
			i = {           -- insert mode
				["qq"] = actions.close, -- close in insert mode
			},
		},
	},
	pickers = {
		-- Configure find_files file picker
		find_files = {
			no_ignore = true,
			hidden = true, --will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			mappings = special_mapping,

		},
		buffers = { mappings = special_mapping },
		command_history = { theme = "ivy" },
	},
	extensions = {
		file_browser = { mappings = special_mapping },
		["ui-select"] = {
			require("telescope.themes").get_cursor(),
		},
	},
})

-- Extension config --
-- overrides vim.ui.select. See :h vim.ui.select
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")

-- Show VCS of all open buffers
telescope.load_extension("lazygit")
vim.api.nvim_create_autocmd('BufEnter', { callback = require("lazygit.utils").project_root_dir })

-- telescope.defaults.get_selection_window = require("window-picker").pick_window

vim.api.nvim_create_user_command("EditAndPick", function(e)
	pcall(function()
		local picked = require('window-picker').pick_window({
			autoselect_one = true,
			include_current_win = true,
		})
		vim.api.nvim_set_current_win(picked)
	end)
	if e.fargs[1] ~= nil then
		vim.cmd('e ' .. e.fargs[1])
	end
end, { nargs = '?', complete = 'file' })
