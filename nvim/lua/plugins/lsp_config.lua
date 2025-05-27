require("mason").setup();
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

local map = vim.keymap.set

local on_attach = function(_, _)
  map("n", "gd", vim.lsp.buf.definition, { desc = "Code Definition" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "Code Implementation" })
  -- map("n", "gc", vim.lsp.buf.references, { desc = "References" })
  map("n", "K", vim.lsp.buf.hover, { desc = "Code documentation" })

  map("n", "<Leader>cr", require("telescope.builtin").lsp_references, { desc = "Show references" })
  map("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Actions" })
  map("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

  map("n", "<A-l>", vim.lsp.buf.format, { desc = "Format" })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    if (server_name ~= "rust_analyzer") then
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end,

})

vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        }
      },
    },
  },
}

local wk = require("which-key")
wk.add({
  "<Leader>c", desc = "Code",
})
map("n", "<Leader>cm", ":Mason<cr>")
--map("n", "<Leader>ca", vim.lsp.buf.code_action, {desc = "Actions"})
