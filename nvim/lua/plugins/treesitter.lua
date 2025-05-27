require("nvim-treesitter.configs").setup({

  ensure_installed = { -- LSP
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "rust",
  },

  auto_install = true, -- automatically installs LSP for other languages that are not listed above 

  highlight = { -- Configure highlight blocks
    enable = true,
  },

  indent = { -- Auto indenting
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Leader>ss",
      node_incremental = "<Leader>sj",
      scope_incremental = "<Leader>sc",
      node_decremental = "<Leader>sk",
    },
  },

  textobjects = { -- Textobjects Module
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select outer function" },
        ["if"] = { query = "@function.inner", desc = "Select inner function" },
        ["ac"] = { query = "@class.outer", desc = "Select inner class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise

        include_surrounding_whitespace = true,
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["<Leader>mf"] = { query = "@function.outer", desc = "Next outer func" },
        ["<Leader>mc"] = { query = "@class.outer", desc = "Next class" },
        ["<Leader>mo"] = "@loop.outer",
        ["<Leader>ms"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
        ["<Leader>mz"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["<Leader>mef"] = { query = "@function.outer", desc = "End outer func" },
        ["<Leader>mec"] = { query = "@class.outer", desc = "End outer class" },
      },
      goto_previous_start = {
        ["<Leader>mF"] = { query = "@function.outer", desc = "Prev outer func" },
        ["<Leader>mC"] = { query = "@class.outer", desc = "Prev outer class" },
      },
      goto_previous_end = {
        ["<Leader>meF"] = { query = "@function.outer", desc = "Prev end outer func" },
        ["<Leader>meC"] = { query = "@class.outer", desc = "Prev end outer class" },
      },
      goto_next = {
        ["<Leader>md"] = { query ="@conditional.outer", desc = "Next cond" },
      },
      goto_previous = {
        ["<Leader>mD"] = { query = "@conditional.outer", desc = "Prev cond" },
      }
    },
    lsp_interop = { -- peal
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>vf"] = "@function.outer",
        ["<leader>vc"] = "@class.outer",
      },
    },
  },
})

local wk = require("which-key")
wk.add({
  { "<Leader>s", desc="Select" },
  { "<Leader>m", desc="Move cursor to" },
  { "<Leader>me", desc="End" },
})
-- Enable repeating moves
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
