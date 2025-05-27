

require("neo-tree").setup({
  window = {
    mappings = {
      -- Preview mode: peek into files
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
    }
  },

  filesystem = {
    filtered_items = {
      hide_gitignored = false, -- show gitignored files
    }
  },
})



-- Key binds
local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
map("n", "<leader>r", "<CMD>Neotree focus<CR>")
