-- The new builtin neovim treesitter broke some highlighting stuff.
-- This config maps certain treesitter textobjects to highlight groups.
local fixes = {
	["@lsp.type.variable"] = "@variable.paramter.builtin",
	["@lsp.type.concept.cpp"] = "@type",
}

for group, target in pairs(fixes) do
	vim.api.nvim_set_hl(0, group, { link = target })
end
