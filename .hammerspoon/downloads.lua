local PathWatcher = require("hs.pathwatcher")
local fs = require("hs.fs")
local fnUtils = require("hs.fnutils")
local settings = require("hs.settings")
local timer = require("hs.timer")
local task = require("hs.task")

local hs = hs
local obj = {}
local processedDownloadsInodesKey = "RBDownloadsWatcherProcessedDownloadsInodes"
local _targetDir
local _rules
local processedDownloadsInodes
local pathWatcher
local throttledTimer

local function tableCount(t)
	local n = 0
	for _, _ in pairs(t) do
		n = n + 1
	end
	return n
end

local function getNameWithoutExtension(path)
	local splitted = fnUtils.split(path, ".", true)
	return table.unpack(splitted, 1, #splitted - 1)
end

local function getExtension(path)
	return path:match("^.+(%..+)$")
end

local function shouldProcessWithFunction(path, rules)
	for _, rule in ipairs(rules) do
		for _, pattern in ipairs(rule.patterhns) do
			if rule.isRegex then
				if path:lower():find(pattern:lower()) then
					return rule.fn
				end
			else
				if path:lower() == pattern:lower() then
					return rule.fn
				end
			end
		end
	end
end

local function watcherCallback(paths, flagTables)
	local iterFn, dirObj = fs.dir(_targetDir)
	local totalFiles = {}

	if not iterFn then
		hs.showError(string.format("DownloadsWatcher fs.dir enumerator error: %s", dirObj))
		return
	end

	local filesPendingProcessing = {}
	for fileNameAndExtension in iterFn, dirObj do
		local fnToExecute = shouldProcessWithFunction(fileNameAndExtension, _rules)
		if fnToExecute then
			local fullPath = _targetDir .. "/" .. fileNameAndExtension
			local nameWithoutExt = getNameWithoutExtension(fullPath)
			local ext = getExtension(fileNameAndExtension)
			local attrs = fs.attributes(fullPath)
			if not fnUtils.contains(processedDownloadsInodes, attrs.ino) then
				table.insert(processedDownloadsInodes, attrs.ino)
				table.insert(filesPendingProcessing, { path = fullPath, exec = fnToExecute })
			end
			table.insert(totalFiles, fullPath)
		end
	end
	if tableCount(totalFiles) == 0 then
		print("DownloadsWatcher: ~/Downloads emptied, clearing inodes list")
		settings.clear(processedDownloadsInodesKey)
		processedDownloadsInodes = {}
	else
		settings.set(processedDownloadsInodesKey, processedDownloadsInodes)
	end
	for _, fileObject in ipairs(filesPendingProcessing) do
		print(fileObject.path, fileObject.fn)
	end
end

function obj:stop()
	pathWatcher:stop()
	return self
end

function obj:start(rules, targetDir)
	_targetDir = targetDir or os.getenv("$HOME") .. "/Downloads"
	_rules = rules or {}
	throttledTimer = throttledTimer or timer.delayed.new(1, watcherCallback)
	processedDownloadsInodes = settings.get(processedDownloadsInodesKey) or {}
	pathWatcher = pathWatcher or PathWatcher.new(_targetDir, function()
		throttledTimer:start()
	end):start()
	return self
end

-- downloadswatcher_rules

local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local function stripExtension(path)
	local splitted = fnUtils.split(path, ".", true)
	return table.unpack(splitted, 1, #splitted - 1)
end

local function dirname(str, sep)
	sep = sep or "/"
	return str:match("(.*" .. sep .. ")")
end

local trash = os.getenv("$HOME" .. "/.Trash")

local function moveToTrash(path)
	local _displayName = fs.displayName(path)
	os.rename(path, trash .. _displayName)
end

local function convertToJpg(path)
	local target = stripExtension(path) .. ".jpg"
	task.new("/usr/bin/sips", function()
		moveToTrash(path)
	end, { "-s", "format", "jpeg", path, "--out", target }):start()
end

local function renameJpegToJpg(path)
	local renameWithoutExt = stripExtension(path)
	os.rename(path, renameWithoutExt .. ".jpg")
end

local function handleZip(path)
	local nameWithoutExt = stripExtension(path)
	local newDir, err = fs.mkdir(nameWithoutExt)
	if not newDir then
		print(err)
		return
	end
	task.new("/usr/bin/ditto", function()
		moveToTrash(path)
	end, { "-xk", path, nameWithoutExt }):start()
end

local function renamePdfBasedOnText(path, text, rules)
	local year
	local month
	for _, rule in ipairs(rules) do
		for _, token in ipairs(rule.tokens) do
			print(token)
		end
	end
end

local function handlePdf(path, rules)
	local script = script_path() .. "/get_pdf_text.py"
	task.new(script, function(exit, textResult, stderr)
		if exit ~= 0 then
			print(stderr)
		end
		renamePdfBasedOnText(path, textResult, rules)
	end, { path }):start()
end

local function handleGz(path) end

local function handleDmg(path) end

local pdfRenamingRules = {}

local rules = {
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
	{
		patterns = "",
		isRegex = true,
		fn = nil,
	},
}

downloadWatcher = obj:start(rules)
