local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local actions = require("telescope.actions")

-- Clone the default Telescope configuration
local vimgrep_arguments = telescopeConfig.values.vimgrep_arguments

-- Search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- Don't search in `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

-- Setup
telescope.setup({
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
		mappings = {
			i = {           -- insert mode
				["qq"] = actions.close, -- close in insert mode
			},
		},
	},
	pickers = { -- Configure different pickers
		find_files = {
			no_ignore = true,
			hidden = true, --will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
		command_history = { theme = "ivy" },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_cursor(),
		},
	},
})

-- Extension config --
local load_extensions = function()
-- overrides vim.ui.select. See :h vim.ui.select
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")

-- Show VCS of all open buffers
telescope.load_extension("lazygit")
vim.api.nvim_create_autocmd('BufEnter', { callback = require("lazygit.utils").project_root_dir })
end
local ok, res = pcall(load_extensions)
if not ok then
	vim.notify(("Telescope could not load the following extension: %s"):format(res), vim.log.levels.ERROR)
end

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
