require("which-key").add({ "<leader>g", desc = "Git" })
vim.keymap.set('n', "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit (CWD as project root)" })
vim.keymap.set('n', "<leader>gf", "<cmd>LazyGit<cr>", { desc = "LazyGit (Current file as project root)" })
vim.keymap.set('n', "<leader>gc", "<cmd>LazyGitFilter<cr>", { desc = "Commits" })
