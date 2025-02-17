local hyper = { "cmd", "alt", "ctrl" }
local shift_hyper = { "cmd", "alt", "ctrl", "shift" }

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

Install:andUse("KSheet", {
	hotkeys = {
		toggle = { hyper, "/" },
	},
})

Install:andUse("TimeMachineProgress", {
	start = true,
})

Install:andUse("EjectMenu", {
	config = {
		eject_on_lid_close = false,
		eject_on_sleep = false,
		show_in_menubar = true,
		notify = true,
	},
	start = true,
})

Install:andUse("EmmyLua")
