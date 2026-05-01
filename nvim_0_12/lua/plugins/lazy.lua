-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Define Plugins
local plugins = {
	-- Installer for TreeSitter configs -- ! archived !
	{ 'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate' },

	-- Interaction with Treesitter Textobjects
	{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main",
		init = function() vim.g.no_plugin_maps = true end,
	},

	-- LSP Package Manager & enabler
	{ "mason-org/mason-lspconfig.nvim", opts = {},
		dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig", },
	},

	-- File browser to the left side of editor
	{ "nvim-neo-tree/neo-tree.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "3rd/image.nvim" }
	},

	-- Bracket sourrounding
	{ "kylechui/nvim-surround", event = "VeryLazy" },
	{ 'windwp/nvim-autopairs', event = "InsertEnter", config = true },

	-- Leap
	{ url = "https://codeberg.org/andyg/leap.nvim" },

	-- Floating terminal
	{ 'akinsho/toggleterm.nvim', version = "*" },

	-- Better window navigation
	{ 's1n7ax/nvim-window-picker', name = 'window-picker' },

	-- File and other pickers
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- Base plugin
	{ 'nvim-telescope/telescope-ui-select.nvim' }, -- UI for e.g. code actions
	{ "nvim-telescope/telescope-file-browser.nvim", -- File explorer
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	 -- Git TUI
	{ "kdheepak/lazygit.nvim",
		cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile"},
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" }
	},

	-- Inline Git Signs
	{  "https://github.com/lewis6991/gitsigns.nvim"  },

	-- Shows key suggestions
	{ "folke/which-key.nvim" },

	-- Prettier buffer line
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', 'nanozuki/tabby.nvim' } },

	-- Colorscheme
	{ "EdenEast/nightfox.nvim" },

	-- Completion
	{ "neovim/nvim-lspconfig", lazy = false,
		dependencies = {
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ 'ms-jpq/coq.thirdparty', branch = "3p" }
		},
		init = function() vim.g.coq_settings = { auto_start = true, } end,
	}
}

-- Load Plugins
require("lazy").setup(plugins, {
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})

