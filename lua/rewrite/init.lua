local M = {}

print("loaded")

function M.setup()
	vim.keymap.set("v", "<leader>l", function()
		print('ay')
	end)
end

function M.go()
	print(".")
end

-- M.go()

return M
