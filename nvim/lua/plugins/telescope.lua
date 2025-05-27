local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local actions = require("telescope.actions")
local builtin = require('telescope.builtin')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- Search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- Don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")



-- Setup
telescope.setup({
  defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
    -- Configure find_files file picker
    find_files = {
      no_ignore = true,
			hidden = true, --will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      
      mappings = {
       i = { -- insert mode
        ["<esc>"] = actions.close -- Map ESC to close in insert mode
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




local set = vim.keymap.set

-- Key binds
local wk = require("which-key")
wk.add({
  { "<leader>f", desc="Find" },
})
--set('n'), <leader>f, {}, {desc = "Telescope"})
set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
set('n', '<leader>p', builtin.find_files, { desc = 'Find files' })
set('n', '<leader>fF', "<cmd>Telescope find_files cwd=~<cr>", { desc = 'Find files (home)' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
set('n', '<leader>g', builtin.current_buffer_fuzzy_find, { desc = 'Grep' })
set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
set('n', "<leader>fG", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })

