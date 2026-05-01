local set = vim.keymap.set
local wk = require("which-key")

local dap = require('dap')
local dapui = require('dapui')
local nui = require('plugins.util.nui')
local function step_and_center(func)
	local ok, _ = pcall(func)
	if ok then
		vim.cmd('normal! zz')
	end
end
local function evaluate()
	nui.input_dialog({ prompt="Enter statement to evaluate"}, function (text)
		dapui.eval(text)
	end)
end
local function send_to_repl(format)
	local word = vim.fn.expand("<cword>")
	dap.repl.execute(format .. word)
end

wk.add({ "<leader>u", desc = "Debug UI" })
set('n', "<leader>ut", dapui.toggle, { desc = "Toggle UI" })
set('n', "<leader>uw", dapui.elements.watches.add, { desc = "Add Watch" })
set('v', "<leader>e", dapui.eval, { desc = "Evaluate Expr." })
set('n', "<F4>", dapui.eval, { desc = "Evaluate Expr." })
set('n', "<leader>ub", dap.toggle_breakpoint, { desc = "Breakpoint" })
set('n', "<leader>ue", evaluate, { desc = "Evaluator" })
set('n', "<leader>ul", dap.run, { desc = "Launch" })
set('n', "<leader>ur", dap.run_last, { desc = "Launch" })
set('n', "<leader>ux", dap.terminate, { desc = "Terminate" })
wk.add({ "<leader>ug", desc = "GDB specific" })
set('n', "<leader>ugb", function () send_to_repl("p/t ") end, { desc = "Print binary" })
set('n', "<leader>ugx", function () send_to_repl("p/x ") end, { desc = "Print hex" })
set('n', "<F5>", function() step_and_center(dap.continue) end, { desc = "DAP: Continue" })
set('n', "<F6>", function() step_and_center(dap.restart) end, { desc = "DAP: Restart" })
set('n', "<F9>", function() step_and_center(dap.step_over) end, { desc = "DAP: Step over" })
set('n', "<F10>", function() step_and_center(dap.step_into) end, { desc = "DAP: Step into" })
set('n', "<F11>", function() step_and_center(dap.step_out) end, { desc = "DAP: Step out" })
set('n', "<F12>", function() step_and_center(dap.run_to_cursor) end, { desc = "DAP: Run to Cursor" })

