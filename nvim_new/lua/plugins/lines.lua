require('lualine').setup()
require('lualine').hide({
	place = { 'tabline', "inactive_sections "},
	unhide = false,
})
require('tabby').setup({
	preset = "tab_with_top_win",
	option = {
		lualine_theme = "dracula",
	}
})
