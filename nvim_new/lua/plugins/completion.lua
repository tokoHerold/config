local remap = vim.api.nvim_set_keymap

-- Setup autopairs
local npairs = require('nvim-autopairs')
npairs.setup({ map_bs = false, map_cr = false })

-- Setup suround
require("nvim-surround").setup({})

-- Setup completion
vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<cr>',
	[[pumvisible() ? (complete_info().selected == -1 ?]] ..
	[["<c-e><cr>" :]] .. -- Selection shown but nothing selected
	[["<c-y>") :]] ..     -- Selection shown and something selected
	[["<cr>"]],          -- Selection hidden
	{ expr = true, noremap = true })
remap('i', '<tab>',
	[[pumvisible() ? (complete_info().selected == -1 ?]] ..
	[["<c-e><tab>" :]] .. -- Selection shown but nothing selected
	[["<c-y>") :]] ..     -- Selection shown and something selected
	[["<tab>"]],          -- Selection hidden
	{ expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<s-j>', [[pumvisible() ? "<c-n>" : "<c-j>"]], { expr = true, noremap = true })
remap('i', '<s-k>', [[pumvisible() ? "<c-p>" : "<s-k>"]], { expr = true, noremap = true })
