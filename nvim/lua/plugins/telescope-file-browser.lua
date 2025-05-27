
local telescope = require("telescope")
local map = vim.keymap.set


--map("n", "<leader>fb", telescope.extensions.file_browser.file_broswer, { desc = "File browser" })
map("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File browser" })
