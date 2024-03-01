local M = {
	clangd = {
		server = {
			cmd = {
				"clangd",
				"--completion-style=detailed",
				"--header-insertion=never",
			},
		},
		on_attach = function()
			require("clangd_extensions.inlay_hints").setup_autocmd()
			require("clangd_extensions.inlay_hints").set_inlay_hints()
		end,
	},
	gopls = {},
	bashls = {},
	yamlls = {},
	["cmake-language-server"] = {},
	texlab = {},
	pylsp = {},
	-- pyright = {
	-- 	settings = {
	-- 		python = {
	-- 			analysis = {
	-- 				autoImportCompletions = true,
	-- 				autoSearchPaths = true,
	-- 				diagnosticMode = "openFilesOnly",
	-- 			},
	-- 		},
	-- 	},
	-- 	single_file_support = true,
	-- },
	rust_analyzer = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
				},
			},
		},
	},
}

return M
