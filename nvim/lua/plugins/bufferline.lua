local bufferline = require("bufferline")

bufferline.setup({
  options = {
    separator_style = "slope",
  },
})

local map = vim.keymap.set

map("n", "<C-h>", ":BufferLineCyclePrev<CR>")
map("n", "<C-l>", ":BufferLineCycleNext<CR>")
