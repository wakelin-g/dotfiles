local util_menu = hs.menubar.new()

local icon = [[
· · · 1 2 · · · · ·
· · · A # # · · · ·
· · · · # # # · · ·
· · · · · # # # · ·
· · · · · · 9 # 3 ·
· · · · · · 8 # 4 ·
· · · · · # # # · ·
· · · · # # # · · ·
· · · 7 # # · · · ·
· · · 6 5 · · · · ·
]]

util_menu:setIcon("ASCII:" .. icon)

local menu = nil

local reload_menu = function()
	util_menu:setMenu(menu)
end

menu = {
	{
		title = "Mount smb://",
		checked = false,
		fn = function(modifiers, menuItem)
			local mount_home = [[
                tell application "Finder"
                mount volume "smb://129.173.205.213/Home"
                end tell
            ]]

			local mount_data = [[
                tell application "Finder"
                mount volume "smb://129.173.205.213/Data"
                end tell
            ]]

			local mount_timemachine = [[
                tell application "Finder"
                mount volume "smb://129.173.205.213/TimeMachine"
                end tell
            ]]

			if string.match(hs.wifi.currentNetwork(), "Dalhousie") ~= nil then
				volumes = hs.fs.volume.allVolumes()
				if volumes["/Volumes/Data/"] == nil then
					hs.osascript.applescript(mount_data)
				end
				if volumes["/Volumes/Home/"] == nil then
					hs.osascript.applescript(mount_home)
				end
				if volumes["/Volumes/TimeMachine/"] == nil then
					hs.osascript.applescript(mount_timemachine)
				end
			else
				hs.notify
					.new({
						title = "Hammerspoon",
						informativeText = "Samba not mounted as not currently connected to 'Dalhousie' network",
					})
					:send()
			end
			reload_menu()
		end,
	},
	{
		title = "-",
	},
}

reload_menu()
