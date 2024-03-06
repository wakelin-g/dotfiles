local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugin
local plugins = "plugins"
require("lazy").setup(plugins, {
	dev = {
		path = "~/.config/plugs/",
		fallback = false,
	},
	ui = {
		border = "none",
	},
	change_detection = {
		notify = false,
	},
})
