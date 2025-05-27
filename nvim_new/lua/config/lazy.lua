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
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } }, -- File explorer
  -- { 'akinsho/toggleterm.nvim' },
  -- { "nvim-neo-tree/neo-tree.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "3rd/image.nvim" } }, -- File explorer
  -- { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } }, -- Better status line at bottom of screen
  -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'}, -- Tab bar of open buffers at top
  -- {'brenoprata10/nvim-highlight-colors'}, -- render colors in document
  -- {'s1n7ax/nvim-window-picker', name = 'window-picker' },
  --
  -- -- Coding
  -- { 'nvim-treesitter/nvim-treesitter'}, -- Highlight, edit, and navigate code
  -- { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- Better movement, peaking
  -- { "williamboman/mason.nvim" }, -- LSP
  -- { "williamboman/mason-lspconfig.nvim", dependencies = {"mason.nvim"} }, -- LSP
  -- { "neovim/nvim-lspconfig" }, -- LSP
  -- { "mrcjkb/rustaceanvim", version = '^5' }, -- automatically set up lspconfig for rust-analyzer
  --
  -- -- Autocompletion
  -- { "hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets", "onsails/lspkind.nvim", "hrsh7th/cmp-nvim-lsp"}},
  --
  -- -- Helpers
  "folke/which-key.nvim", -- Shows possible key combinations 
  { "doctorfree/cheatsheet.nvim", event = "VeryLazy", dependencies = { { "nvim-telescope/telescope.nvim" }, { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } },
  --   -- { "folke/flash.nvim" },
  --
  -- -- Colorscheme
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- { "EdenEast/nightfox.nvim" },
  -- { "rebelot/kanagawa.nvim" },
  -- { 'projekt0n/github-nvim-theme', name = 'github-theme' },
}


require("lazy").setup(plugins, {
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})



