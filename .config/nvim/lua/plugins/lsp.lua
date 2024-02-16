return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            {
                "L3MON4D3/LuaSnip",
                lazy = true,
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            "saadparwaiz1/cmp_luasnip",
        },
        keys = {
            { "K", vim.lsp.buf.hover, desc = "hover" },
            { "gd", vim.lsp.buf.definition, desc = "definition"},
            { "gD", vim.lsp.buf.declaration, desc = "declaration"},
            { "gi", vim.lsp.buf.implementation, desc = "implementation"},
            { "gr", vim.lsp.buf.references, desc = "references"},
            { "gt", vim.lsp.buf.type_definition, desc = "type definition"},
            { "<leader>K", vim.lsp.buf.signature_help, desc = "signature help"},
            { "<leader>ca", vim.lsp.buf.code_action, desc = "code action"},
            { "<leader>rn", vim.lsp.buf.rename, desc = "rename"},
            { "<leader>e", vim.diagnostic.open_float, desc = "open float"},
            { "[d", vim.diagnostic.goto_prev, desc = "diag goto prev"},
            { "]d", vim.diagnostic.goto_next, desc = "diag goto next"},
        },
        config = function()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "clangd",
                    "lua_ls",
                    "html",
                    "cssls",
                    "pyright",
                    "yamlls",
                    "texlab",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        })
                    end,
                    ["clangd"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.clangd.setup({
                            server = {
                                cmd = {
                                    "clangd",
                                    "--completion-style=detailed",
                                    "--header-insertion=never",
                                }
                            },
                            on_attach = function()
                                require("clangd_extensions.inlay_hints").setup_autocmd()
                                require("clangd_extensions.inlay_hints").set_inlay_hints()
                            end,
                        })
                    end,
                }
            })

            local cmp_select = { behaviour = cmp.SelectBehavior.Select }
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.close(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                }),
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = require("lspkind").cmp_format({
                        mode = "symbol",
                        maxwidth = 25,
                        ellipsis_char = "...",
                    })
                },
            })

            vim.diagnostic.config({
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "Diagnostics",
                    prefix = "",
                },
            })

        end
    },
    {
        "onsails/lspkind.nvim",
    },
}
