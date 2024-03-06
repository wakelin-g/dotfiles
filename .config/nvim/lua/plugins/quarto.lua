return {
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dependencies = {
			{
				"jmbuhr/otter.nvim",
				dev = false,
				dependencies = { "neovim/nvim-lspconfig" },
			},
			{ "hrsh7th/nvim-cmp" },
			{ "neovim/nvim-lspconfig" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("quarto").setup({
				debug = false,
				closePreviewOnExit = true,
				lspFeatures = {
					enabled = true,
					languages = { "r", "python", "julia", "bash" },
					chunks = "curly",
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
					never_run = { "yaml" },
				},
			})
		end,
	},
	{
		"3rd/image.nvim",
		version = "1.1.0",
		opts = {
			backend = "kitty",
			integrations = {},
			-- max_width = 100,
			-- max_height = 12,
			max_width_window_percentage = math.huge,
			max_height_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		"benlubas/molten-nvim",
		ft = { "quarto", "python" },
		dependencies = { "3rd/image.nvim" },
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_virt_text_output = false
			vim.g.molten_auto_open_output = true
			vim.g.molten_tick_rate = 150
			vim.g.molten_virt_lines_off_by_1 = true
			vim.keymap.set("n", ",mi", ":MoltenInit<CR>")
		end,
	},
}
