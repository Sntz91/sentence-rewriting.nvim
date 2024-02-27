local M = {}

print("loaded")

function M.setup()
	vim.keymap.set("v", "<leader>l", function()
		print('ay')
	end)
	print('setup')
end

function M.go()
	print(".")
end

-- M.go()

return M
