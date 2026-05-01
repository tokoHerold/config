local function tabs_spaces()
	local expandtab = vim.api.nvim_buf_get_option(0, 'expandtab')
	return expandtab and [[Spaces]] or [[Tabs]]
end

require('lualine').setup({
	sections = {
		lualine_c = { {
			'filename',
			path = 4, -- Filename and parent dir, with tilde as the home directory
			newfile_status = true, -- Display new file status (new file means no write after created)
		} },
		lualine_y = {
			tabs_spaces, 'progress'
		},
	},
})
require('lualine').hide({
	place = { 'tabline', "inactive_sections " },
	unhide = false,
})
require('tabby').setup({
	preset = "tab_with_top_win",
	option = {
		lualine_theme = "dracula",
	}
})

