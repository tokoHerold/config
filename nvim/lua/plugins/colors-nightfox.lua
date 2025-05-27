require("nightfox").setup({
  options = {
    transparent = false,
    dim_inactive = true,
    styles = {
      comments = "italic",
      numbers = "bold",
      keywords = "bold",
      conditionals = "bold",
      types = "bold",
      operators = "bold",
    },
    inverse = {
      search = true,
    },
  },
})

-- Activate color scheme
vim.cmd("colorscheme nightfox")
