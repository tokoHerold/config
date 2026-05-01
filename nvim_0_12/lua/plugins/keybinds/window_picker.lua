local wp = require("window-picker")
vim.keymap.set('n', "<leader><leader>", require('plugins/config/window_picker').focus_selected_window, { desc = "Select Window" })
