Utils = {}

function Utils.get_visual_selection()
    vim.cmd('normal! "vy"')
    return vim.fn.getreg('v')
end

function Utils.open_text_in_split(text)
	vim.cmd('botright vnew | vertical resize 85')
	vim.bo[0].swapfile = false
	vim.bo[0].buftype = 'nofile'
	vim.bo[0].filetype = 'markdown'
	for line in text:gmatch("[^\r\n]+") do
		vim.api.nvim_put({line}, 'l', true, true)
	end
	vim.cmd('normal! gg')
end

function Utils.get_command(selection)
	local preprompt = "Rewrite the following sentences: "
	local input = preprompt .. selection
	local command = 'python $HOME/Projects/sentence-rewriting/main.py "' .. input .. '"'
	return command
end


function Utils.clean_selection(selection)
	-- get rid of control characters like ^I
	local cleansed_selection = selection:gsub("%c", " ")
	-- get rid of double quotes 
	cleansed_selection = cleansed_selection:gsub('"', "'")
	return cleansed_selection
end


function Utils.execute_command(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	return result
end

return Utils
