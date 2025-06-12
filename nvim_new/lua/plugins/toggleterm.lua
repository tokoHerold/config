require('toggleterm').setup({
	direction = "float";
	start_in_insert = true,
	persist_mode = false,
	float_opts = {
		border = "curved",
	},
})

-- vim.api.nvim_create_autocmd({"TermOpen"}, {
-- 	-- pattern = {"term://*toggleterm#*"},
-- 	callback = function (ev)
-- 				vim.cmd("startinsert")
-- 			   end
-- })

