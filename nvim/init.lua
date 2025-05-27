-- Load vim-specific settings
require("config.settings")

-- Setup lazy.nvim
require("config.lazy")

-- Activate colorscheme
require("plugins.colors")

-- Add telescope functionality
require("plugins.telescope")
--require("plugins.telescope-file-browser")

-- Configure Neotree
require("plugins.neotree")

-- LSP
require("plugins.treesitter")
require("plugins.lsp_config")
require("plugins.cmp")

-- Configure Window
require("lualine").setup()
require("plugins.bufferline")
require("plugins.term")
require("plugins.cheatsheet")

-- Set up keybinds
require("config.mappings")
