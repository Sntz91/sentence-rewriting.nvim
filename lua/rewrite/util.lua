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

function Utils.get_llm_command_server(prompt, server)
	local command = 'curl http://'..server..'/api/generate -d \'{ "model": "llama2", "prompt": "' .. prompt .. '", "stream": false}\''
	return command
end

function Utils.get_llm_command(prompt)
	local command = 'ollama run llama2 "' .. prompt .. '"'
	return command
end

function Utils.clean_prompt(prompt)
	-- get rid of control characters like ^I
	local cleansed_prompt = prompt:gsub("%c", " ")
	-- get rid of double quotes 
	cleansed_prompt = cleansed_prompt:gsub('"', '\\"')
	cleansed_prompt = cleansed_prompt:gsub("'", "'\\''")
	return cleansed_prompt
end

function Utils.execute_command(command)
	local json = require("lunajson")
	local handle = io.popen(command)
	local response = handle:read("*a")
	handle:close()
	local data = json.decode(response)
	local result = data["response"]
	return result
end

return Utils
