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
}

local groups = {
	all = {
		WinSeparator = { fg = '#7D81A1' },
	}
}

local specs_high_contrast = {
	all = {
		syntax = {
			bracket = '#FECEFE',
			builtin0 = '#00DDC0', -- builtin variables
			builtin1 = '#FF88CF', -- builtin types
			builtin2 = 'green', -- todo
			comment = '#33AA66',
			conditional = 'orange', -- if/for
			const = '#A1E6E6', -- variable names of const type
			-- dep = 'green', -- todo
			field = '#80b0ff', -- member variables
			func = '#A1E6E6', -- functions
			ident = '#E960CC', -- Identifiers (e.g. python constructors)
			keyword = 'orange', -- try, with, except, ...
			number = '#ccffcc',
			operator = '#FEFEFE',
			preproc = '#E940CC', -- #include, import, ...
			regex = '#FF7744',
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
local setup_lualine = function()
  local ok, lualine = pcall(require, 'lualine')
  if not ok then
    vim.notify(("Warning: lualine not loaded: %s"):format(lualine), vim.log.levels.WARN)
    return
  end

  lualine.setup({
    options = { theme = "dracula" },
  })
end
setup_lualine()

