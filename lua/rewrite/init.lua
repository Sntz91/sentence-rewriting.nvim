local M = {}

local function get_visual_selection()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	local selection = table.concat(lines)
	selection = selection:gsub("[\t\n]", "")
	return selection
end

local function open_text_in_split(text)
	vim.cmd('botright vnew | vertical resize 85')
	vim.bo[0].swapfile = false
	vim.bo[0].buftype = 'nofile'
	vim.bo[0].filetype = 'markdown'
	for line in text:gmatch("[^\r\n]+") do
		vim.api.nvim_put({line}, 'l', true, true)
	end
	vim.cmd('normal! gg')
end

local function isempty(s)
	return s == nil or s == ''
end

local function rewrite()
	local selection = get_visual_selection()
	if selection == '' then
		print("nothing selected")
		return
	end
	local preprompt = "Rewrite the following sentences: "
	local input = preprompt .. selection
	-- TODO
	local command = 'python $HOME/Projects/sentence-rewriting/main.py "' .. input .. '"'

	local handle = io.popen(command)
	if isempty(handle) then
		print("empty handle")
		return
	end
	local result = handle:read("*all")
	handle:close()
	if isempty(result) then
		print("empty result")
		return
	end

	open_text_in_split(result)
end

function M.setup()
	vim.keymap.set("n", "<leader>l", function()
		rewrite()
	end)
	print('setup')
end

-- M.go()

return M
