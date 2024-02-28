local Utils = require("rewrite.util")
local M = {}

local function rewrite()
	local selection = Utils.get_visual_selection()
	selection = Utils.clean_selection(selection)

	if string.len(selection) < 30 then
		print("string too short..")
		return
	end

	local command = Utils.get_command(selection)
	local result = Utils.execute_command(command)
	Utils.open_text_in_split(result)
end

function M.setup()
	vim.keymap.set("v", "<leader>l", function()
		rewrite()
	end)
end

M.setup()

return M
