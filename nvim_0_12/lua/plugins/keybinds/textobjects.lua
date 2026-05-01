local set = vim.keymap.set

-- Selections
local ts_select = require("nvim-treesitter-textobjects.select")

-- key: single letter (e.g. "f") -> maps "af"/"if"
-- capture: start of the capture -> maps <capture>.outer and <capture>.inner
-- desc: single word used as description/capture base (e.g. "function")
local function map_select(key, capture,  desc)
	local a, i = "a"..key, "i"..key
	local outer, inner = capture..".outer", capture..".inner"
	set({ "x", "o" }, a, function() ts_select.select_textobject(outer, "textobjects") end, { desc = desc })
	set({ "x", "o" }, i, function() ts_select.select_textobject(inner, "textobjects") end, { desc = desc })
end

map_select("f", "@function", "Function")
map_select("c", "@class", "Class")
map_select("a", "@parameter", "Argument")
map_select("m", "@attribute", "Member")
map_select("d", "@assignment", "Assignment")
map_select("q", "@comment", "Comment")

-- Swapping
local ts_swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "}a", function() ts_swap.swap_next "@parameter.inner" end, { desc = "Argument" })
vim.keymap.set("n", "{a", function() ts_swap.swap_previous "@parameter.inner" end, { desc = "Argument" })

-- Movement
local ts_move = require("nvim-treesitter-textobjects.move")

-- key: single char
-- textobj: e.g. "@function.inner"
-- scope: e.g. "textobjects"
-- short_desc: single word like "Function"
local function map_textobj(key, textobj, scope, short_desc)
	set({ "n", "x", "o" }, "]" .. key:lower(), -- next start: ]<lower>
	function() ts_move.goto_next_start(textobj, scope) end,
	{ desc = ("Next %s start"):format(short_desc) })

	set({ "n", "x", "o" }, "[" .. key:lower(), -- previous start: [<lower>
	function() ts_move.goto_previous_start(textobj, scope) end,
	{ desc = ("Prev %s start"):format(short_desc) })

	set({ "n", "x", "o" }, "]" .. key:upper(), -- next end: ]<upper>
	function() ts_move.goto_next_end(textobj, scope) end,
	{ desc = ("Next %s end"):format(short_desc) })

	set({ "n", "x", "o" }, "[" .. key:upper(), -- previous end: [<upper>
	function() ts_move.goto_previous_end(textobj, scope) end,
	{ desc = ("Prev %s end"):format(short_desc) })
end

map_textobj("f", "@function.inner", "textobjects", "function")
map_textobj("a", "@parameter.inner", "textobjects", "argument")
map_textobj("m", "@attribute.inner", "textobjects", "member")
map_textobj("c", "@class.inner", "textobjects", "class")
map_textobj("s", "@local.scope", "locals", "scope")
map_textobj("i", "@conditional.inner", "textobjects", "conditional")
map_textobj("o", "@loop.inner", "textobjects", "loop")
map_textobj("q", "@comment.outer", "textobjects", "comment")
map_textobj("b", "@block.inner", "textobjects", "comment")
map_textobj("l", "@assignment.lhs", "textobjects", "LHS")
map_textobj("r", "@assignment.rhs", "textobjects", "RHS")

set({ "n", "x", "o" }, "]z", function() ts_move.goto_next("@fold", "folds") end, { desc = "Next fold" })
set({ "n", "x", "o" }, "[z", function() ts_move.goto_previous("@fold", "folds") end, { desc = "Prev fold" })


-- Repeat movement with ; and ,
local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- Make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
