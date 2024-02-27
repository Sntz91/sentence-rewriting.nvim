local M = {}

local function test()
	print("test")
end

function M.setup()
	vim.keymap.set("n", "<leader>l", function()
		test()
	end)
	print('setup')
end

-- M.go()

return M
