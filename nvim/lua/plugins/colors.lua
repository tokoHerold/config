-- Default options
require('github-theme').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath('cache') .. '/github-theme',
    compile_file_suffix = '_compiled', -- Compiled file suffix
    hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
    hide_nc_statusline = true, -- Override the underline style for non-active statuslines
    transparent = true,       -- Disable setting bg (make neovim's background transparent)
    terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = true,      -- Non focused panes set to alternative background
    module_default = true,     -- Default enable value for modules
    styles = {                 -- Style to be applied to different syntax groups
      comments = 'italic',       -- Value is any valid attr-list value `:help attr-list`
      functions = 'NONE',
      keywords = 'bold',
      variables = 'NONE',
      conditionals = 'NONE',
      constants = 'NONE',
      numbers = 'bold',
      operators = 'bold',
      strings = 'italic',
      types = 'bold',
    },
    inverse = {                -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = true,
    },
    darken = {                 -- Darken floating windows and sidebar-like windows
      floats = true,
      sidebars = {
        enable = true,
        list = {},             -- Apply dark background to specific windows
      },
    },
  },
  palettes = {},
  specs = {
    github_dark = {
      syntax = {
        bracket = 'cyan',
        string = '#00ca00',
      }
    }
  },
  groups = {},
})

-- setup must be called before loading
vim.cmd('colorscheme github_dark')
