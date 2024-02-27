local M = {}

print("loaded")


local function go()
	print(".")
end

function M.setup()
	vim.keymap.set("n", "<leader>l", go())
	print('setup')
end

-- M.go()

return M
