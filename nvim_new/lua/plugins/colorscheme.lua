local options = {
	transparent = true,
	styles = {
		comments = 'italic',
		conditionals = 'bold',
		constants = 'underdotted',
		functions = '',
		keywords = 'bold',
		numbers = 'underline',
		operators = 'bold',
		preprocs = 'bold',
		strings = '',
		types = '',
		variables = '',
	},
	modules = {
		telescope = {enable = true},
	},
}

local groups = {
	all = {
		WinSeparator = { fg = '#7D81A1' },
	}
}

-- local specs = {
-- 	all = {
-- 		syntax = {
-- 			bracket = vim.g.terminal_color_7,
-- 			builtin0 = vim.g.terminal_color_14, -- builtin variables
-- 			builtin1 = vim.g.terminal_color_13, -- builtin types
-- 			-- builtin2 = 'green', -- todo
-- 			comment = '#33AA66',
-- 			conditional = 'orange', -- if/for
-- 			const = vim.g.terminal_color_14, -- variable names of const type
-- 			-- dep = 'green', -- todo
-- 			field = vim.g.terminal_color_4, -- member variables
-- 			func = vim.g.terminal_color_6, -- functions
-- 			ident = vim.g.terminal_color_13, -- Identifiers (e.g. python constructors)
-- 			keyword = 'orange',     -- try, with, except, ...
-- 			number = vim.g.terminal_color_2,
-- 			operator = vim.g.terminal_color_7,
-- 			preproc = vim.g.terminal_color_5, -- #include, import, ...
-- 			regex = vim.g.terminal_color_9,
-- 			-- statement = 'green',
-- 			string = vim.g.terminal_color_10,
-- 			type = vim.g.terminal_color_11,
-- 			variable = '#AAC1FD',
-- 		}
-- 	}
-- }

local specs_high_contrast = {
	all = {
		syntax = {
			bracket = '#FECEFE',
			builtin0 = vim.g.terminal_color_14, -- builtin variables
			builtin1 =  '#FF88CF', -- builtin types
			-- builtin2 = 'green', -- todo
			comment = '#33AA66',
			conditional = 'orange', -- if/for
			const = '#A1E6E6', -- variable names of const type
			-- dep = 'green', -- todo
			field = '#80b0ff', -- member variables
			func =  '#A1E6E6', -- functions
			ident = '#E960CC', -- Identifiers (e.g. python constructors)
			keyword = 'orange',     -- try, with, except, ...
			number = '#ccffcc',
			operator = '#FEFEFE',
			preproc = '#E940CC', -- #include, import, ...
			regex = vim.g.terminal_color_9,
			-- statement = 'green',
			string = '#33FF66',
			type = '#F0CF70',
			variable = '#AAC1FD',
		}
	}
}

local palettes = {
	-- https://github.com/EdenEast/nightfox.nvim/blob/main/usage.md#palette
	nightfox = {
		bg0 = '#2B2D3B', -- lighter foreground - hover menus
	}
}
--
require("nightfox").setup({ options = options, palettes = palettes, groups = groups, specs = specs_high_contrast })
vim.cmd("colorscheme nightfox")

-- Set colorscheme before setting up lualine
require('lualine').setup({
	options = {
		theme = "dracula",
	}
})
