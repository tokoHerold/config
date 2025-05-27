local map = vim.keymap.set

require("toggleterm").setup({})


function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- leave terminal mode
  map('t', '<esc>', [[<C-\><C-n>]], opts)
  map('t', 'jk', [[<C-\><C-n>]], opts)
  map('t', 'kj', [[<C-\><C-n>]], opts)

  -- Better movement
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

map('n', "<Leader>t", ":ToggleTerm size=40, direction=float<CR>", { desc = "Open terminal" })
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- vim.cmd('autocmd TermEnter, BufWinEnter, WinEnter term://* silent! normal i)
-- vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, { command = "startinsert" })

