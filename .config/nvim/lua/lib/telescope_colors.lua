local colors = {
	_nc = "#1f1d30",
	base = "#232136",
	surface = "#2a273f",
	overlay = "#393552",
	muted = "#6e6a86",
	subtle = "#908caa",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ea9a97",
	pine = "#3e8fb0",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight_low = "#2a283e",
	highlight_med = "#44415a",
	highlight_high = "#56526e",
	none = "NONE",
}

local hlgroups = {
	TelescopeBorder = { fg = colors._nc, bg = colors._nc },
	TelescopePromptBorder = { fg = colors._nc, bg = colors._nc },
	TelescopePreviewBorder = { fg = colors._nc, bg = colors._nc },
	TelescopeResultsBorder = { fg = colors._nc, bg = colors._nc },

	TelescopeNormal = { fg = colors.subtle, bg = colors._nc },

	TelescopePreviewTitle = { fg = colors.base, bg = colors.rose, bold = true },
	TelescopePromptTitle = { fg = colors.base, bg = colors.foam, bold = true },
	TelescopeResultsTitle = { fg = colors.base, bg = colors._nc },

	TelescopeSelection = { bg = colors.base, fg = colors.text, bold = true },

	TelescopeResultsDiffAdd = { fg = colors.love },
	TelescopeResultsDiffChange = { fg = colors.gold },
	TelescopeResultsDiffDelete = { fg = colors.foam },

	TelescopePromptPrefix = { fg = colors.text, bg = colors._nc },
	TelescopePromptNormal = { fg = colors.text, bg = colors._nc },
}

for hl, col in pairs(hlgroups) do
	vim.api.nvim_set_hl(0, hl, col)
end
