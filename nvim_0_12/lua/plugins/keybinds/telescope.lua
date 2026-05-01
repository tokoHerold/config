local builtin = require("telescope.builtin")
local wk = require("which-key")
local set = vim.keymap.set

-- Normal Mappings
wk.add({ { "<leader>f", desc = "Find" } })
set('n', '<leader>ff', builtin.find_files, { desc = 'Files (CWD)' })
set('n', '<leader>fF', "<cmd>Telescope find_files cwd=~<cr>", { desc = 'Files (Home)' })
set('n', '<leader>fc', "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", { desc = 'Config Files' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recently opened' })
set('n', '<leader>fx', builtin.commands, { desc = 'Commands' })
set('n', '<leader>fr', builtin.registers, { desc = 'Registers' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
set('n', '<leader>fm', builtin.man_pages, { desc = 'Man pages' })
set('n', "<leader>fG", "<cmd>Telescope git_files<cr>", { desc = "Git files)" })
set("n", "<leader>fV", require("telescope").extensions.lazygit.lazygit, { desc = "Version Control" })
set('n', '<leader>ft', builtin.treesitter, { desc = 'Treesitter' })

-- Code Mappings
set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'Definitions' })
set('n', '<leader>fe', function() builtin.diagnostics({ bufnr = 0 }) end, { desc = 'Errors/Warnings' })
set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementations' })
set('n', '<leader>fy', builtin.lsp_type_definitions, { desc = 'Type Definitions' })
set('n', '<leader>fv', builtin.lsp_references, { desc = 'Variables under cursor' })
set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Symbols' })
set('n', '<leader>fS', builtin.lsp_workspace_symbols, { desc = 'All Symbols' })

-- Special Mappings
set('n', '<leader>p', builtin.find_files, { desc = 'Find files' })
set('c', '<C-r>', builtin.command_history, { desc = 'Command history' })
set({ 'n', 'i' }, '<C-f>', builtin.current_buffer_fuzzy_find, { desc = 'Buffers' })
set("n", "<leader>w", ":Telescope file_browser path=%:p:h<cr><esc>", { desc = "File browser" })
