vim.keymap.set('n', "<C-t>", ":ToggleTerm<cr>", { desc = "Terminal" })
vim.keymap.set('t', "<C-t>", function() vim.cmd("ToggleTerm") end, { desc = "Terminal" })
