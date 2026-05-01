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

