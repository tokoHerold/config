
local o = vim.opt

o.number = true 		-- Print the line number in front of each line
o.relativenumber = false 	-- Relative line numbers.
o.clipboard = "unnamed" 	-- uses the clipboard register for all operations except yank.
o.syntax = "on" 		-- When this option is set, the syntax with this name is loaded.
o.autoindent = false 		-- Copy indent from current line when starting a new line.
o.cursorline = true 		-- Highlight the screen line of the cursor with CursorLine.
o.expandtab = false 		-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.list = true
o.tabstop = 4 			-- Number of spaces that a <Tab> in the file counts for.
o.shiftwidth = 4
o.encoding = "UTF-8" 		-- Sets the character encoding used inside Vim.
o.ruler = true 			-- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "a" 			-- Enable the use of the mouse. "a" you can use on all modes
o.title = true 			-- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true 		-- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 100 		-- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true 		-- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true 		-- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true 		-- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = "split" 		-- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.splitright = true
o.splitbelow = true 		-- When on, splitting a window will put the new window below the current one
o.termguicolors = true
-- o.paste = true
o.formatoptions:remove('r') -- dont automatically add comments when hitting enter

-- Automatically highlight text when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})
