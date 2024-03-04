-- local Utils = require("rewrite.util")
local Utils = require("lua.rewrite.util")
local M = {}

local function rewrite(server)
	local selection = Utils.get_visual_selection()
	selection = Utils.clean_prompt(selection)

	if string.len(selection) < 30 then
		print("string too short...")
		return
	end

	local preprompt = "Rewrite the following sentences: "
	local prompt = preprompt .. selection
	local command = Utils.get_llm_command_server(prompt, server)
	local result = Utils.execute_command(command)
	Utils.open_text_in_split(result)
end

local function prompt_llm(server)
	vim.ui.input({ prompt = "Enter prompt: "}, function(input)
		input = Utils.clean_prompt(input)
		if string.len(input) < 2 then
			print("string too short...")
			return
		end
		local command = Utils.get_llm_command_server(input, server)
		local result = Utils.execute_command(command)
		Utils.open_text_in_split(result)
	end)
end

function M.setup(opts)
	local server = opts["server"]

	vim.keymap.set("v", "<leader>lr", function()
		rewrite(server)
	end)
	vim.keymap.set("n", "<leader>lp", function()
		prompt_llm(server)
	end)
end

-- local opts = {server = "192.168.178.67:11434"}
-- local opts = {server = "localhost:11434"}
-- M.setup(opts)

return M
