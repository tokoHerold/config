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

-- Load plugins
local plugins = {
	-- UI
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- UI to select things (files, search results, open buffers...)
	{ 'nvim-telescope/telescope-ui-select.nvim' }, -- UI for e.g. code actions
	{ "nvim-telescope/telescope-file-browser.nvim", -- File explorer
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{ "kdheepak/lazygit.nvim", -- Git TUI
		cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile"},
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" }
	},
	{ 'nvim-focus/focus.nvim', version = '*' }, -- nice way of splitting windows
	{ 'akinsho/toggleterm.nvim', version = "*" }, -- terminal
	{ "nvim-neo-tree/neo-tree.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "3rd/image.nvim" } }, -- File explorer
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } }, -- Better status line at bottom of screen
	-- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'}, -- Tab bar of open buffers at top
	{   'nanozuki/tabby.nvim' }, -- window line -- window line -- window line -- window line -- window line -- window line -- window line -- window line -- window line
	{ 'brenoprata10/nvim-highlight-colors' }, -- render colors in document
	{ 's1n7ax/nvim-window-picker', name = 'window-picker'  },
	{ "https://github.com/MunifTanjim/nui.nvim" },
	{  "https://github.com/lewis6991/gitsigns.nvim"  },

	-- -- Coding
	-- { 'nvim-treesitter/nvim-treesitter'}, -- Highlight, edit, and navigate code
	{ "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	-- { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- Better movement, peaking
	{ "mason-org/mason.nvim", opts = {} }, -- LSP Package manager
	{ "mason-org/mason-lspconfig.nvim", opts = {}, dependencies = {"mason-org/mason.nvim", "neovim/nvim-lspconfig"} }, -- LSP
	{ "neovim/nvim-lspconfig" }, -- LSP
	{ 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
	-- { "mrcjkb/rustaceanvim", version = '^5' }, -- automatically set up lspconfig for rust-analyzer
	{ "kylechui/nvim-surround", version = "^3.0.0", event = "VeryLazy" },
	--
	-- -- Autocompletion
	{ "neovim/nvim-lspconfig",  lazy = false,
		dependencies = {{  "ms-jpq/coq_nvim", branch = "coq" }, { "ms-jpq/coq.artifacts", branch = "artifacts" }, { 'ms-jpq/coq.thirdparty', branch = "3p" }},
		-- init = function() vim.g.coq_settings = { auto_start = true} end,
		init = function() vim.g.coq_settings = { auto_start = "shut-up" } end, -- use this line to disable startup message
	},
	-- { "hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets", "onsails/lspkind.nvim", "hrsh7th/cmp-nvim-lsp"}},
	{ "Vigemus/iron.nvim" },

	-- -- Helpers
	{ "folke/which-key.nvim" }, -- Shows possible key combinations 
	{ "doctorfree/cheatsheet.nvim", event = "VeryLazy", dependencies = { { "nvim-telescope/telescope.nvim" }, { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } },
	--   -- { "folke/flash.nvim" },
	--
	-- -- Colorscheme
	{ "EdenEast/nightfox.nvim" },
}


require("lazy").setup(plugins, {
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})



