local inspect = require("inspect")
local db = hs.sqlite3.open("main.sqlite")

for row in db:rows("SELECT * FROM TMTask") do
	print(row[1])
end

db:close()

local things_menu = hs.menubar.new()
things_menu:setIcon("icons/things_macos_bigsur_icon_189646.png")

local menu = nil

local reload_menu = function()
	util_menu:setMenu(menu)
end

menu = {
	title = "Things 3",
	checked = false,
	fn = function(modifiers, menuItem)
		print("yay")
	end,
}

reload_menu()
