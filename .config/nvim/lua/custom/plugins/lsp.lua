vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

---@diagnostic disable: missing-fields
local plugins = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        path = "${3rd}/luv/library",
                        words = { "vim%.uv" },
                    },
                },
            },
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
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            local servers = require("custom.servers")

            require("mason").setup({})

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua",
                "prettier",
                "black",
                "shfmt",
                "ruff",
            })

            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
                run_on_start = true,
            })
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        require("lspconfig")[server_name].setup({
                            cmd = server.cmd,
                            settings = server.settings,
                            filetypes = server.filetypes,
                            capabilities = vim.tbl_deep_extend(
                                "force",
                                {},
                                capabilities,
                                server.capabilities or {}
                            ),
                        })
                    end,
                },
            })
            require("lspconfig")["r_language_server"].setup({
                cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
                filetypes = { "r", "rmd" },
                root_dir = function(fname)
                    return vim.fs.dirname(
                        vim.fs.find(".git", { path = fname, upward = true })[1]
                    ) or vim.loop.os_homedir()
                end,
                log_level = vim.lsp.protocol.MessageType.Warning,
            })
            require("lspconfig")["sourcekit"].setup({
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
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
        },
        config = function()
            local cmp = require("cmp")
            local kind_icons = require("custom.icons").kind
            local luasnip = require("luasnip")
            luasnip.config.setup({})
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                enabled = function()
                    local context = require("cmp.config.context")
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end,
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({
                        behaviour = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Insert,
                    }),
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Insert,
                    }),
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
                sources = {
                    {
                        name = "lazydev",
                        group_index = 0,
                    },
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "render-markdown" },
                    { name = "neorg" },
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    expandable_indicator = true,
                    format = function(entry, vim_item)
                        local function trim(text)
                            local max = 15
                            if text and #text > max then
                                text = text:sub(1, max)
                            end
                            return text
                        end

                        local kind = vim_item.kind
                        vim_item.kind = (kind_icons[kind] or "?") .. " " .. kind
                        local source = entry.source.name
                        vim_item.menu = " [" .. source .. "] "
                        vim_item.abbr = trim(vim_item.abbr:match("[^(]+"))
                        return vim_item
                    end,
                },
                view = {
                    entries = {
                        name = "custom",
                        selection_order = "near_cursor",
                    },
                },
                experimental = {
                    ghost_text = true,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "none",
                        scrollbar = false,
                        winhighlight = "FloatShadow:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
                        col_offset = 1,
                    }),
                    documentation = {
                        winhighlight = "FloatShadow:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
                        border = "none",
                        scrolloff = 10,
                        -- max_width = 80,
                        -- max_height = 40,
                    },
                },
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}

return plugins

-- vim: ts=2 sts=2 sw=2 et
