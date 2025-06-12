local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local actions = require("telescope.actions")
local builtin = require('telescope.builtin')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- Search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- Don't search in `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

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
				["<cr>"] = function(prompt_bufnr)
					require('telescope.actions.set').edit(prompt_bufnr, "EditAndPick")
				end,
				["<a-cr>"] = "select_default",
			},
			n = {
				["<a-cr>"] = "select_default",
				["<cr>"] = function(prompt_bufnr)
					require('telescope.actions.set').edit(prompt_bufnr, "EditAndPick")
				end,
			}
		},
	},
	pickers = {
		-- Configure find_files file picker
		find_files = {
			no_ignore = true,
			hidden = true, --will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },

		},
		command_history = { theme = "ivy" },
	},
	extensions = {
		file_browser = {
			mappings = {
				['n'] = {
					["<cr>"] = "select_default",
				},
				['i'] = {
					["<cr>"] = "select_default",
				},
			}
		},
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
  local success, picked = pcall(function ()
    return require('window-picker').pick_window({
      autoselect_one = true,
      include_current_win = true,
    })
  end)
	if not success then
		picked = vim.api.nvim_get_current_win();
	end
	vim.print(picked)
	vim.api.nvim_set_current_win(picked)
	if e.fargs[1] ~= nil then
		vim.cmd('e ' .. e.fargs[1])
	end
end, { nargs = '?', complete = 'file' })

