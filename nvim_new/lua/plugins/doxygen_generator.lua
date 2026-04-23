-- Doxygen stub generator/updater for C/C++ files
-- Put this in your init.lua or a sourced Lua module.

local M = {}

-- Configuration: recognized C/C++ filetypes and extensions
local c_filetypes = { c = true, cpp = true, objc = true, objcpp = true, ["c++"] = true }
local c_extensions = {
	c = true,
	h = true,
	hh = true,
	hpp = true,
	hxx = true,
	cpp = true,
	cc = true,
	cxx = true,
	["c++"] = true,
	inl = true,
	ipp = true
}

local function is_c_cpp_buf(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local ok, ft = pcall(vim.api.nvim_buf_get_option, bufnr, "filetype")
	if ok and ft and c_filetypes[ft] then return true end
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then return false end
	local ext = vim.fn.fnamemodify(name, ":e"):lower()
	return ext ~= "" and c_extensions[ext] == true
end

-- Get the line of the signature (best-effort: current line or next non-empty)
local function get_signature_line(bufnr, row)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	row = row or (vim.api.nvim_win_get_cursor(0)[1] - 1)
	local total = vim.api.nvim_buf_line_count(bufnr)
	for r = row, math.min(row + 6, total - 1) do
		local line = vim.api.nvim_buf_get_lines(bufnr, r, r + 1, false)[1]
		if line and line:match("%S") then return line, r end
	end
	return vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1], row
end

-- Parse parameter names from a signature line (best-effort)
local function parse_params_from_signature(sig)
	local args = sig:match("%b()")
	local params = {}
	if args then
		args = args:sub(2, -2)
		for p in args:gmatch("([^,]+)") do
			local name = p:match("([%w_]+)%s*$") or p:match("([%w_]+)%s*[%[%]]")
			if name and name ~= "void" then table.insert(params, name) end
		end
	end
	return params
end

-- Build a canonical doxygen block table (array of lines) from params and a flag for return
local function build_doc_lines(params, has_return)
	local lines = { "/**", " * @brief ", " *", " * @details " }
	for _, p in ipairs(params) do table.insert(lines, " * @param " .. p .. " ") end
	if has_return then
		table.insert(lines, " * @return ")
	end
	table.insert(lines, " */")
	return lines
end

-- Detect an existing Doxygen block immediately above sig_row. Returns start_row, end_row, lines or nil.
local function find_existing_doxygen(bufnr, sig_row)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local start = nil
	local finish = nil
	-- scan up from sig_row-1 to a reasonable limit (e.g., 20 lines)
	local limit = math.max(0, sig_row - 20)
	for r = sig_row - 1, limit, -1 do
		local line = vim.api.nvim_buf_get_lines(bufnr, r, r + 1, false)[1] or ""
		if line:match("%/%*%*") then
			start = r
			break
		elseif line:match("%S") and not line:match("^%s*%*") and not line:match("^%s*//") then
			-- encountered code or non-doc comment before a /** start → no doc block
			break
		end
	end
	if not start then return nil end
	-- find end from start forward
	local total = vim.api.nvim_buf_line_count(bufnr)
	for r = start, math.min(start + 40, total - 1) do
		local line = vim.api.nvim_buf_get_lines(bufnr, r, r + 1, false)[1] or ""
		if line:match("%*/") then
			finish = r
			break
		end
	end
	if not finish then return nil end
	local lines = vim.api.nvim_buf_get_lines(bufnr, start, finish + 1, false)
	return start, finish, lines
end

-- Parse which tags exist in an existing doc block: brief, details, params set, return
local function analyze_doc_block(lines)
	local has_brief = false
	local has_details = false
	local params = {}
	local has_return = false
	for _, l in ipairs(lines) do
		if l:match("@brief") then has_brief = true end
		if l:match("@details") then has_details = true end
		local p = l:match("@param%s+([%w_]+)")
		if p then params[p] = true end
		if l:match("@return") then has_return = true end
	end
	return { brief = has_brief, details = has_details, params = params, ret = has_return }
end

-- Merge existing doc block with desired doc block: keep existing lines, add missing tags in reasonable places
local function merge_doc(existing_lines, desired_params, desired_has_return)
	local info = analyze_doc_block(existing_lines)
	local out = {}
	local inserted_params = {}
	local params_to_add = {}
	for _, p in ipairs(desired_params) do
		if not info.params[p] then table.insert(params_to_add, p) end
	end

	for _, line in ipairs(existing_lines) do
		table.insert(out, line)
		-- after @details (or after the initial header if no details), insert missing @param lines and @return if needed
		if line:match("@details") then
			for _, p in ipairs(params_to_add) do table.insert(out, " * @param " .. p .. " ") end
			if desired_has_return and not info.ret then table.insert(out, " * @return ") end
			-- clear so we don't insert again
			params_to_add = {}
			desired_has_return = false
		end
	end

	-- If we didn't find @details to anchor insertion, try placing params before closing */
	if #params_to_add > 0 or (desired_has_return and not info.ret) then
		-- remove final " */" from out, add missing lines, then re-add " */"
		if #out > 0 and out[#out]:match("%*/") then
			local last = table.remove(out)
			for _, p in ipairs(params_to_add) do table.insert(out, " * @param " .. p .. " ") end
			if desired_has_return and not info.ret then table.insert(out, " * @return ") end
			table.insert(out, last)
		else
			for _, p in ipairs(params_to_add) do table.insert(out, " * @param " .. p .. " ") end
			if desired_has_return and not info.ret then table.insert(out, " * @return ") end
			table.insert(out, " */")
		end
	end

	return out
end

-- Main entry: insert or update Doxygen stub for function at cursor
function M.InsertDoxygenStub()
	local bufnr = vim.api.nvim_get_current_buf()
	if not is_c_cpp_buf(bufnr) then
		vim.api.nvim_echo({ { "Doxygen: not a C/C++ buffer", "WarningMsg" } }, false, {})
		return
	end

	local row = vim.api.nvim_win_get_cursor(0)[1] - 1
	local sig, sig_row = get_signature_line(bufnr, row)
	if not sig then
		vim.api.nvim_echo({ { "Doxygen: cannot find signature line", "WarningMsg" } }, false, {})
		return
	end

	local params = parse_params_from_signature(sig)
	-- crude detection of whether function returns void: if signature contains ") void" or "void " before name isn't helpful
	-- instead, if signature contains "void)" or params only "void" then assume no return; otherwise assume possible return.
	local has_return = not sig:match("%)%s*;?$") or not sig:match("%) *void") -- conservative; set true for insertion
	-- better heuristic: if signature text contains "void" immediately before ')', treat as no return
	if sig:match("%b()"):match("%f[%w]void%f[%W]") then has_return = false end

	local start, finish, existing = find_existing_doxygen(bufnr, sig_row)
	if start and finish and existing then
		local merged = merge_doc(existing, params, has_return)
		-- replace existing block
		vim.api.nvim_buf_set_lines(bufnr, start, finish + 1, false, merged)
		vim.api.nvim_echo({ { "Doxygen: updated existing comment", "MoreMsg" } }, false, {})
	else
		-- insert new block above sig_row
		local doc_lines = build_doc_lines(params, has_return)
		vim.api.nvim_buf_set_lines(bufnr, sig_row, sig_row, false, doc_lines)
		vim.api.nvim_echo({ { "Doxygen: inserted new comment", "MoreMsg" } }, false, {})
	end
end

-- Register a user command
vim.api.nvim_create_user_command("DoxygenStub", function() M.InsertDoxygenStub() end, {})

return M
