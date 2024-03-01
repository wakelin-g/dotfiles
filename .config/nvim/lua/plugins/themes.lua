local theme = require("core.theme").theme

return {
	{
		"rose-pine/neovim",
		enabled = theme == "rose-pine",
		lazy = false,
		priority = 1000,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = false,
				styles = {
					transparency = true,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = theme == "tokyonight",
		lazy = false,
		priority = 1000,
		name = "tokyonight",
		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "dark", -- choose from ["dark", "transparent", "normal"]
					floats = "dark", -- choose from ["dark", "transparent", "normal"]
				},
				sidebars = { "qf", "help" },
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = false,
			})
			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"catppuccin/nvim",
		enabled = theme == "cappuccin",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavor = "mocha",
				transparent_background = true,
				show_end_of_buffer = true,
				integrations = {
					cmp = true,
					nvimtree = true,
					treesitter = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = theme == "kanagawa",
		lazy = false,
		priority = 1000,
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				theme = "wave",
				transparent = true,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"bluz71/vim-nightfly-colors",
		enabled = theme == "nightfly",
		lazy = false,
		priority = 1000,
		name = "nightfly",
		config = function()
			vim.cmd("colorscheme nightfly")
			vim.g.nightflyCursorColor = true
			vim.g.nightflyTransparent = true
		end,
	},
	{
		"savq/melange-nvim",
		enabled = theme == "melange",
		lazy = false,
		priority = 1000,
		name = "melange",
		config = function()
			vim.cmd("colorscheme melange")
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		enabled = theme == "nordic",
		lazy = false,
		priority = 1000,
		name = "nordic",
		config = function()
			vim.cmd("colorscheme nordic")
		end,
	},
}
