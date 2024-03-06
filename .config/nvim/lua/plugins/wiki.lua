return {
	-- {
	--     "mickael-menu/zk-nvim",
	--     opts = {
	--         picker = "telescope",
	--         lsp = {
	--             config = {
	--                 cmd = { "zk", "lsp" },
	--                 name = "zk",
	--             },
	--             auto_attach = true,
	--             filetypes = { "markdown" },
	--         },
	--     },
	--     config = function()
	--         require("zk").setup({})
	--         local map = vim.keymap.set
	--         map("n", "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { silent = true, desc = "zk: new note" })
	--         map("n", "<leader>zt", "<cmd>ZkTags<CR>", { silent = true, desc = "zk: tags" })
	--         map("v", "<leader>zm", "<cmd>ZkMatch<CR>", { silent = true, desc = "zk: match under cursor" })
	--     end,
	-- },
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		-- ft = { "markdown" },
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/knowledgebase/**.*",
			"BufNewFile " .. vim.fn.expand("~") .. "/knowledgebase/**.*",
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "vault",
						path = "/Users/griffen/knowledgebase/",
					},
				},
				notes_subdir = "2_Notes",
				log_level = vim.log.levels.INFO,
				completion = {
					nvim_cmp = true,
					min_chars = 1,
					prepend_note_id = true,
				},
				preferred_link_style = "wiki",
				new_notes_location = "current_dir",
				mappings = {
					["<CR>"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = true, expr = true, buffer = true },
					},
				},
				note_id_func = function(title)
					local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
					local ret = {}
					math.randomseed(os.time())
					for _ = 1, 4 do
						local r = math.random(1, #charset)
						table.insert(ret, charset:sub(r, r))
					end
					return tostring(table.concat(ret))
				end,
				disable_frontmatter = false,
				backlinks = {
					height = 10,
					wrap = true,
				},
				tags = {
					height = 10,
					wrap = true,
				},
				use_advanced_uri = false,
				open_app_background = false,

				note_frontmatter_func = function(note)
					if note.title then
						note:add_alias(note.title)
					end

					local out = { id = note.id, aliases = note.aliases, tags = note.tags }
					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end

					return out
				end,
				picker = {
					name = "telescope.nvim",
					mappings = {
						new = "<C-x>",
						insert_link = "<C-l>",
					},
				},
				wiki_link_func = function(opts)
					if opts.id == nil then
						return string.format("[[%s]]", opts.label)
					elseif opts.label ~= opts.id then
						return string.format("[[%s|%s]]", opts.id, string.lower(opts.label))
					else
						return string.format("[[%s]]", opts.id)
					end
				end,
				sort_by = "modified",
				sort_reversed = true,
				open_notes_in = "current",
				ui = {
					enable = true,
					update_debounce = 200,
					checkboxes = {
						[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
						["x"] = { char = "", hl_group = "ObsidianDone" },
						[">"] = { char = "", hl_group = "ObsidianRightArrow" },
						["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					},
					bullets = { char = "•", hl_group = "ObsidianBullet" },
					external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					reference_text = { hl_group = "ObsidianRefText" },
					highlight_text = { hl_group = "ObsidianHighlightText" },
					tags = { hl_group = "ObsidianTag" },
					hl_groups = {
						ObsidianTodo = { bold = true, fg = "#f78c6c" },
						ObsidianDone = { bold = true, fg = "#89ddff" },
						ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
						ObsidianTilde = { bold = true, fg = "#ff5370" },
						ObsidianBullet = { bold = true, fg = "#89ddff" },
						ObsidianRefText = { underline = true, fg = "#c792ea" },
						ObsidianExtLinkIcon = { fg = "#c792ea" },
						ObsidianTag = { italic = true, fg = "#89ddff" },
						ObsidianHighlightText = { bg = "#75662e" },
					},
				},
				yaml_parser = "native",
			})
		end,
	},
}
