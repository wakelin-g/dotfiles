--[[
when opening new emacs frame via `emacsclient -c`, the created
window opens below all other open windows. this script watches
for newly-created windows and focuses them if they are emacs
]] --

local emacs_filter = hs.window.filter.new("Emacs")

local function focus_new_emacs_window(win, name, _)
  if name == "Emacs" then
    win:focus()
  end
end

emacs_filter:subscribe(hs.window.filter.windowCreated, focus_new_emacs_window)

--[[
* fn - function or list of functions, the callback(s) to add for the event(s); each will be passed 3 parameters
  * a `hs.window` object referring to the event's window
  * a string containing the application name (`window:application():name()`) for convenience
  * a string containing the event that caused the callback, i.e. (one of) the event(s) you subscribed to
]] --
