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
        get_selection_window = function()
            return require('window-picker').pick_window({
                -- You can customize the behavior here
                include_current_win = true, -- Include the current window in the selection
                -- Other options can be added as needed
            })
        end,
	},
	pickers = {
    -- Configure find_files file picker
    find_files = {
      no_ignore = true,
			hidden = true, --will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      
			  mappings = {
			   i = { -- insert mode
				["qq"] = actions.close -- close in insert mode
			   },
			 },
		},
	},
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

telescope.load_extension("ui-select")

-- telescope.defaults.get_selection_window = require("window-picker").pick_window

