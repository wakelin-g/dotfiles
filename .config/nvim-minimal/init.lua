vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.keymap.set("n", "<leader>tt", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "lsp actions",
	callback = function(event)
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = event.buf }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		bufmap("i", "<C-Space>", "<C-x><C-o>")
		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
		bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<cr>")
		bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
	end,
})

vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.shortmess:append("c")

local function tab_complete()
	if vim.fn.pumvisible() == 1 then
		return "<Down>"
	end
	local c = vim.fn.col(".") - 1
	local is_whitespace = c == 0 or vim.fn.getline("."):sub(c, c):match("%s")
	if is_whitespace then
		return "<Tab>"
	end
	local lsp_completion = vim.bo.omnifunc == "v:lua.vim.lsp.omnifunc"
	if lsp_completion then
		return "<C-x><C-o>"
	end
	return "<C-x><C-n>"
end
local function tab_prev()
	if vim.fn.pumvisible() == 1 then
		return "<Up>"
	end
	return "<Tab>"
end

vim.keymap.set("i", "<Tab>", tab_complete, { expr = true })
vim.keymap.set("i", "<S-Tab>", tab_prev, { expr = true })

vim.lsp.set_log_level("debug")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ -- You can easily change to a different colorscheme.
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "nvim_lua" },
                    { name = "buffer" },
				},
			})
		end,
	},
    {
        "neovim/nvim-lspconfig",
    },
}, {})
