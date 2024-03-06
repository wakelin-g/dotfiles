return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
						},
					},
				},
			},
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("griffen-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("K", ":Lspsaga hover_doc<cr>", "hover documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "signature help")
					map("gD", ":Lspsaga peek_type_definition<cr>", "goto declaration")
					map("gd", ":Lspsaga peek_definition<cr>", "goto definition")
					map("gr", require("telescope.builtin").lsp_references, "goto references")
					map("gI", require("telescope.builtin").lsp_implementations, "goto implementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "type definition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "document symbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "workspace symbols")
					map("<leader>rn", ":Lspsaga rename<cr>", "rename")
					map("<leader>ca", ":Lspsaga code_action<cr>", "code actions")
					map("[d", ":Lspsaga diagnostic_jump_prev<cr>", "diag goto prev")
					map("]d", ":Lspsaga diagnostic_jump_next<cr>", "diag goto next")
					map("<leader>e", vim.diagnostic.open_float, "show diagnostic error messages")
					map("<leader>q", vim.diagnostic.setloclist, "open diagnostic quickfix list")
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = require("core.servers")

			require("mason").setup({
				log_level = vim.log.levels.DEBUG,
			})

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"shfmt",
				"luacheck",
				"goimports",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						require("lspconfig")[server_name].setup({
							cmd = server.cmd,
							settings = server.settings,
							filetypes = server.filetypes,
							capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
						})
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports" },
				markdown = { "prettier" },
				python = { "isort", "black" },
				cpp = { "clang_format" },
				c = { "clang_format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
			format_after_save = {
				lsp_fallback = true,
			},
			formatters = {
				clang_format = {
					command = "/opt/homebrew/bin/clang-format",
					inherit = true,
					args = { "--style='file:/Users/griffen/.clang-format" },
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			{
				"hrsh7th/nvim-cmp",
				event = { "InsertEnter", "CmdlineEnter" },
			},
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{
				"L3MON4D3/LuaSnip",
				lazy = true,
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").load_standalone({
						path = "~/.config/nvim/snippets/a.code-snippets",
					})
				end,
			},
			"saadparwaiz1/cmp_luasnip",
			"p00f/clangd_extensions.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				enabled = function()
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ behaviour = cmp.ConfirmBehavior.Replace, select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-f>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "nvim_lua" },
					{ name = "path" },
					-- { name = "buffer" },
					{ name = "otter" },
				}),
				formatting = {
					-- fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol",
						menu = {
							buffer = "[Buffer]",
							path = "[Path]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[Lua]",
							luasnip = "[LuaSnip]",
						},
						maxwidth = 20,
					}),
				},
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				-- window = {
				-- 	completion = cmp.config.window.bordered(),
				-- 	documentation = cmp.config.window.bordered(),
				-- },
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
