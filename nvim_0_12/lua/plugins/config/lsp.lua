-- local lspconfig = require("nvim-lspconfig")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gdscript" },
	callback = function()
		vim.lsp.enable("gdscript")
		vim.print("macincheese")
	end
})
