local cmp = require("cmp")
-- local lspkind = require("lspkind")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()


cmp.setup({
  --view = "wildmenu",
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-e>"] = cmp.mapping.close(),
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
     if cmp.visible() then
        cmp.confirm({ select = true })
     else
        fallback()
     end
    end, {"i"}),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
 --[[c mapping = cmp.mapping.preset.cmdline(),
mp.setup.cmdline({ '/', '?' }, {
  sources = {
    { name = 'buffer' }
  }
})]]
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--[[cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    }),
  matching = { disallow_symbol_nonprefix_matching = false }
})]]

-- vim.cmd([[
--      set completeopt=menuone,noinsert,noselect
--      highlight! default link CmpItemKind CmpItemMenuDefault
--      ]])
