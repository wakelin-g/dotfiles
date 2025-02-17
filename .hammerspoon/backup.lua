local obsidian_path = "/Users/griffen/knowledgebase"
local dotfiles_path = "/Users/griffen/.config"

local function sync(path)
  if hs.fs.chdir(path) then
    output, status = hs.execute("git add . && git commit -am update", true)
    if status then
      output, status = hs.execute("git push -u origin main", true)
      if not status then
        hs.notify.show("Notes Sync", "Git Push Error", output)
      end
    end
  else
    hs.notify.show("Notes Sync", "Cannot Change Path", obsidian_path)
  end
end

local function notes_sync()
  sync(notes_path)
end

local function dotfiles_sync()
  sync(dotfiles_path)
end

--[[
not using watchers for this as I think would definitely
cause performance issues, and also would be quite annoying
to have 999999 messageless commits
]] --
-- notes_watcher = hs.pathwatcher.new(notes_path, notes_sync):start()
-- dotfiles_watcher = hs.pathwatcher.new(dotfiles_path, dotfiles_sync):start()

notes_timer = hs.timer.doEvery(300, notes_sync)
dotfiles_timer = hs.timer.doEvery(300, dotfiles_sync)
