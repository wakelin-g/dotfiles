--[[ basic window manager --

My monitors (2x DELL SE2719HR) at home are set up
in the macOS display menu (arrange) like:

   ┌───────────────────┐┌───────────────────┐
   │                   ││                   │
   │ DELL SE2719HR (1) ││ DELL SE2719HR (2) │
   │                   ││                   │
   └───────────────────┘└───────────────────┘

which is very confusing because hammerspoon's window
module seems to see the exact reverse of this.

The main purposes of this simple "window manager" code
is to allow windows to be easily positioned where I
most prefer them to be. All commands act on the currently-
focused window. The relevant keymaps are:

  | keymap       | description                       |
  | ------------ | --------------------------------- |
  | shift+ctrl+h | resize+move window to left half   |
  | shift+ctrl+j | resize+move window to bottom half |
  | shift+ctrl+k | resize+move window to top half    |
  | shift+ctrl+l | resize+move window to right half  |
  | shift+ctrl+c | center window (no resize)         |
  | shift+ctrl+f | make window fullscreen            |
  | shift+ctrl+m | resize to 80% + center window     |
  | shift+ctrl+n | cycle window between displays     |

When the window is already on the left- or right-sided position
and shift+ctrl+h/l are pressed again, the window is supposed to
move to the closest left side of the next window.

e.g., left screen to right screen
   ┌───────────────────┐┌───────────────────┐
   │         ┌────────┐││                   │
   │         │   -->  │││                   │
   │         └────────┘││                   │
   └───────────────────┘└───────────────────┘
   ┌───────────────────┐┌───────────────────┐
   │                   ││┌────────┐         │
   │                   │││        │         │
   │                   ││└────────┘         │
   └───────────────────┘└───────────────────┘

this feature seems to be buggy so far, given that hammerspoon
thinks the monitors are in reversed orientation to their true
positions.

UPDATE: above issue seems to work when hard-coding positions
by using hs.window.focusedWindow():screen():next() to put the
logic underlying finding the "other" monitor in the hands of
hammerspoon. There probably exists a better way to do it but
for now this works.

]] --
local debug = false
local x_gaps, y_gaps = 0.003, 0.003

local monitor_left = "78311F70-11F2-4796-AFAF-A2DEB5CAAE60"
local monitor_left_size = hs.screen.find(monitor_left):frame()
local monitor_right = "7359B8B8-F946-4DA5-B0A3-CB9B4B097163"
local monitor_right_size = hs.screen.find(monitor_left):frame()

local function debug_print(message, is_debug)
  if is_debug == nil then
    is_debug = debug
  end

  if is_debug then
    print(message)
  end
end

local function get_rect(_x_gaps, _y_gaps, side)
  if side == "left" then
    return {
      x = _x_gaps,
      y = _y_gaps,
      h = 1 - 2 * _y_gaps,
      w = 1 / 2 - _x_gaps * 3 / 2,
    }
  elseif side == "right" then
    return {
      x = 1 / 2 + _x_gaps / 2,
      y = _y_gaps,
      h = 1 - 2 * _y_gaps,
      w = 1 / 2 - _x_gaps * 3 / 2,
    }
  elseif side == "top" then
    return {
      x = _x_gaps,
      y = _y_gaps,
      w = 1 - 2 * _x_gaps,
      h = 1 / 2 - _y_gaps * 3 / 2,
    }
  elseif side == "bottom" then
    return {
      x = _x_gaps,
      y = 1 / 2 + _y_gaps / 2,
      w = 1 - 2 * _x_gaps,
      h = 1 / 2 - _y_gaps * 3 / 2,
    }
  end
end

local function window_mover(movement)
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  local halfsize_right = hs.geometry.size(951.0, 1048.0)
  local halfsize_left = hs.geometry.size(951.0, 1073.0)
  local left_monitor_right_side = hs.geometry.rect({ -958.0, 3.0, 951.0, 1073.0 })
  local right_monitor_left_side = hs.geometry.rect({ 5.0, 28.0, 951.0, 1048.0 })

  if screen:getUUID() == monitor_right then
    debug_print("screen name: " .. screen:name())
    if movement == 'left' and win:topLeft() == hs.geometry.point(5.0, 28.0) and win:size() == halfsize_right then
      debug_print("if 1 passed (left)")
      win:move(left_monitor_right_side, screen:next(), true, 0.1)
      win:moveToUnit(get_rect(x_gaps, y_gaps, "right"))
      return
    end
  elseif screen:getUUID() == monitor_left then
    debug_print("screen name: " .. screen:name())
    if movement == 'right' and win:topLeft() == hs.geometry.rect(-958.0, 3.0) and win:size() == halfsize_left then
      debug_print("if 1 passed (right)")
      win:move(right_monitor_left_side, screen:next(), true, 0.1)
      win:moveToUnit(get_rect(x_gaps, y_gaps, "left"))
      return
    end
  end
  if movement == 'left' then
    win:moveToUnit(get_rect(x_gaps, y_gaps, "left"))
  elseif movement == 'right' then
    win:moveToUnit(get_rect(x_gaps, y_gaps, "right"))
  end
end

--[[
vim movements for focused windows
]] --
hs.hotkey.bind({ "shift", "ctrl" }, "h", function()
  -- hs.window.focusedWindow():moveToUnit(get_rect(x_gaps, y_gaps, "left"))
  window_mover("left")
end)
hs.hotkey.bind({ "shift", "ctrl" }, "j", function()
  hs.window.focusedWindow():moveToUnit(get_rect(x_gaps, y_gaps, "bottom"))
end)
hs.hotkey.bind({ "shift", "ctrl" }, "k", function()
  hs.window.focusedWindow():moveToUnit(get_rect(x_gaps, y_gaps, "top"))
end)
hs.hotkey.bind({ "shift", "ctrl" }, "l", function()
  -- hs.window.focusedWindow():moveToUnit(get_rect(x_gaps, y_gaps, "right"))
  window_mover("right")
end)

--[[
make focused window fill display
]] --
hs.hotkey.bind({ "shift", "ctrl" }, "f", function()
  hs.window.focusedWindow():moveToUnit({ x1 = x_gaps, y1 = y_gaps, x2 = 1 - x_gaps, y2 = 1 - y_gaps })
end)

--[[
move focused window to center of display while preserving current size
]] --
hs.hotkey.bind({ "shift", "ctrl" }, "c", function()
  hs.window.focusedWindow():centerOnScreen()
end)

--[[
center focused window non-maximized
]] --
hs.hotkey.bind({ "shift", "ctrl" }, "m", function()
  local prop = 0.1
  hs.window.focusedWindow():moveToUnit({
    x1 = x_gaps + prop,
    y1 = y_gaps + prop,
    x2 = 1 - x_gaps - prop,
    y2 = 1 - y_gaps - prop
  })
end)

--[[
cycles focused window between screens
]] --
hs.hotkey.bind({ "shift", "ctrl" }, "n", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)
