local remap = vim.api.nvim_set_keymap

local npairs = require('nvim-autopairs')
npairs.setup({ map_bs = false, map_cr = false })
-- Setup completion
vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
_G.MUtils= {}
MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
-- 	[["<c-e><cr>" :]] .. -- Selection shown but nothing selected
-- 	[["<c-y>") :]] ..     -- Selection shown and something selected
-- 	[[require('nvim-autopairs').autopairs_cr()]],          -- Selection hidden
-- 	{ expr = true, noremap = true })
--
remap('i', '<tab>',
	[[pumvisible() ? (complete_info().selected == -1 ?]] ..
	[["<c-e><tab>" :]] .. -- Selection shown but nothing selected
	[["<c-y>") :]] ..     -- Selection shown and something selected
	[["<tab>"]],          -- Selection hidden
	{ expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<s-j>', [[pumvisible() ? "<c-n>" : "<c-j>"]], { expr = true, noremap = true })
remap('i', '<s-k>', [[pumvisible() ? "<c-p>" : "<s-k>"]], { expr = true, noremap = true })
