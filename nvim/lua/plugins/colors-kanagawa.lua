-- Default options:
require('kanagawa').setup({
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { bold = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = true,    -- do not set background color
  dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  theme = "wave",        -- Load "wave" theme when 'background' option is not set
  background = {         -- map the value of 'background' option to a theme
    dark = "wave",       -- try "dragon" !
    light = "lotus"
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
  end,
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
