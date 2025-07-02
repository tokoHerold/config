local iron = require('iron.core')
local view = require("iron.view")
local common = require("iron.fts.common")

iron.setup {
	config = {
		-- Whether a repl should be discarded or not
		scratch_repl = true,
		-- Your repl definitions come here
		repl_definition = {
			sh = {
				-- Can be a table or a function that
				-- returns a table (see below)
				command = { "fish" }
			},
			python = {
				command = { "python3" }, -- or { "ipython", "--no-autoindent" }
				format = common.bracketed_paste_python,
				block_dividers = { "# %%", "#%%" },
			}
		},
		-- set the file type of the newly created repl to ft
		-- bufnr is the buffer id of the REPL and ft is the filetype of the
		-- language being used for the REPL.
		repl_filetype = function(_, ft)
			return ft
		end,

		repl_open_cmd = view.split.vertical("40%")
		-- repl_open_cmd = view.bottom(40),  -- Set the default REPL open command

		-- repl_open_command = { view.split.vertical.rightbelow("40%") }, -- cmd_1: open a repl to the right
	},
	keymaps = {
		send_motion = "<space>ism",
		visual_send = "<space>is",
		cr = "<space>is<cr>",
		interrupt = "<space>ix",
		exit = "<space>iq",
		clear = "<space>ic",
	},
	-- If the highlight is on, you can change how it looks
	-- For the available options, check nvim_set_hl
	highlight = {
		italic = true,
	},
	ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}
