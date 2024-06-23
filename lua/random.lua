-- Define your color schemes
local colorschemes = { "rose-pine", "cyberdream", "oldworld" }

-- Path to store the current colorscheme index
local index_file = vim.fn.stdpath("cache") .. "/colorscheme_index"

-- Function to read the current index from the file
local function read_index()
	local f = io.open(index_file, "r")
	if f then
		local index = tonumber(f:read("*all"))
		f:close()
		return index or 1
	end
	return 1
end

-- Function to write the current index to the file
local function write_index(index)
	local f = io.open(index_file, "w")
	if f then
		f:write(tostring(index))
		f:close()
	end
end

-- Get the current index, increment it, and cycle if necessary
local current_index = read_index()
local next_index = current_index % #colorschemes + 1

-- Set the color scheme
vim.cmd("colorscheme " .. colorschemes[next_index])

-- Save the next index for the next session
write_index(next_index)
