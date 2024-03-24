local M = {}

local u = require("eln.utils")

M.config = {
	eln_dir = "/Users/griffen/scratch/eln/",
}

-- function M.setup(args)
-- 	args = args or {}
-- 	local config = {}
-- 	config.eln_dir = args.eln_dir
-- 	M.config = config
-- end

local get_current_dir = function()
	local cur_dir = vim.fn.getcwd()
	return "[eln.nvim]: current dir = " .. cur_dir
end

local get_eln_dir = function()
	local config_dir = M.config["eln_dir"]
	return "[eln.nvim]: config dir = " .. config_dir
end

M.in_eln_dir = function()
	local cur_dir = get_current_dir()
	local eln_dir = get_eln_dir()

	if cur_dir == eln_dir then
		return "[eln.nvim]: in eln dir!"
	else
		return "[eln.nvim]: not in eln dir!"
	end
end

return M
