local M = {}

print("loaded")


 function M.go()
	print(".")
end

function M.setup()
	vim.keymap.set("n", "<leader>l", function()
		print("test")
	end)
	print('setup')
end

-- M.go()

return M
