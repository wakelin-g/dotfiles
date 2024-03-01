return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"lambdalisue/suda.vim",
		config = function()
			vim.g["suda#prompt"] = "Enter administrator password: "
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			auto_reload_on_write = true,
			disable_netrw = true,
			hijack_cursor = true,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = true,
			open_on_tab = false,
			respect_buf_cwd = true,
			sort_by = "name",
			sync_root_with_cwd = false,
			view = {
				adaptive_size = true,
				centralize_selection = true,
				width = 25,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				float = {
					enable = false,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 30,
						height = 30,
						row = 1,
						col = 1,
					},
				},
			},
			renderer = {
				add_trailing = false,
				group_empty = true,
				highlight_git = true,
				full_name = false,
				highlight_opened_files = "none",
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
				symlink_destination = true,
				indent_markers = {
					enable = true,
				},
				root_folder_label = ":.:s?.*?/..?",
			},
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = {},
			},
			filters = {
				dotfiles = false,
				custom = { ".DS_Store" },
				exclude = {},
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
				},
				open_file = {
					quit_on_open = false,
					resize_window = false,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "terminal", "help" },
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			diagnostics = {
				enable = false,
				show_on_dirs = false,
				debounce_delay = 50,
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
			},
			git = {
				enable = true,
				ignore = true,
				show_on_dirs = true,
				timeout = 400,
			},
			trash = {
				cmd = "gio trash",
				require_confirm = true,
			},
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		},
	},
	-- {
	--     "NvChad/nvterm",
	--     config = function()
	--         require("nvterm").setup({
	--             terminals = {
	--                 shell = vim.o.shell,
	--                 list = {},
	--                 type_opts = {
	--                     float = {
	--                         relative = 'editor',
	--                         row = 0.125,
	--                         col = 0.125,
	--                         width = 0.75,
	--                         height = 0.75,
	--                         border = 'single',
	--                     },
	--                     horizontal = {
	--                         location = 'rightbelow',
	--                         split_ratio = .2,
	--                     },
	--                     vertical = {
	--                         location = 'rightbelow',
	--                         split_ratio = .3,
	--                     },
	--                 },
	--             },
	--             behaviour = {
	--                 autoclose_on_quit = {
	--                     enabled = false,
	--                     confirm = true,
	--                 },
	--                 close_on_exit = true,
	--                 auto_insert = true,
	--             },
	--         })
	--         local nvt = require("nvterm.terminal")
	--         local toggle_modes = { 'n', 't' }
	--         local mappings = {
	--             {toggle_modes, '<C-g>', function () nvt.toggle('float') end},
	--             {toggle_modes, '<C-\\>', function () nvt.toggle('horizontal') end},
	--         }
	--         local opts = { noremap = true, silent = true }
	--         for _, mapping in ipairs(mappings) do
	--             vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
	--         end
	--     end,
	-- },
	{
		"windwp/nvim-autopairs",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
		event = "InsertEnter",
	},
	{
		"nvimdev/template.nvim",
		cmd = { "Template", "TemProject" },
		config = function()
			require("template").setup({
				temp_dir = "~/.config/nvim/template/",
				author = "Griffen Wakelin",
				email = "wakelin@dal.ca",
			})
		end,
	},
	{
		"wakelin-g/run.nvim",
		dev = true,
		name = "run.nvim",
		event = "VeryLazy",
		config = function()
			require("run").setup({})
		end,
	},
	{
		dir = "~/.config/plugs/scratch-buffer/",
		enabled = false,
		name = "scratch-buffer",
		config = function()
			require("scratch-buffer").setup({})
		end,
	},
}
