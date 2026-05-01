local gitsigns = require("gitsigns")
local set = vim.keymap.set

set('n', "<leader>gd", gitsigns.diffthis, { desc = "View diff" })
set('n', "<leader>gb", gitsigns.blame, { desc = "Blame" })
set('n', "gb", gitsigns.blame_line, { desc = "Git Blame" })
require("which-key").add({ "<leader>gh", desc = "Hunk..." })
set('n', "<leader>ghs", gitsigns.select_hunk, { desc = "Select" })
set('n', "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview" })
set('n', "<leader>gh ", gitsigns.stage_hunk, { desc = "Stage" })
set('n', "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset" })
set('n', "<leader>gt", gitsigns.toggle_word_diff, { desc = "Toggle Diff" })
set('n', "[h", function() gitsigns.nav_hunk('prev') end, { desc = "Prev Git Hunk" })
set('n', "]h", function() gitsigns.nav_hunk('next') end, { desc = "Next Git Hunk" })
set('n', "[H", function() gitsigns.nav_hunk('prev') end, { desc = "Prev Git Hunk" })
set('n', "]H", function() gitsigns.nav_hunk('last') end, { desc = "Last Git Hunk" })

