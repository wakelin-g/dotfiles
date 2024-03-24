-- following is for image.nvim to work
package.path = package.path
    .. ";"
    .. vim.fn.expand("$HOME")
    .. "/.luarocks/share/lua/5.1/magick/init.lua"
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

require("core.options")
require("core.map")
require("core.autocmds")
require("core.servers")
require("core.lazy")
require("core.globals")
require("lib.telescope_colors")

pcall(require, "user")
