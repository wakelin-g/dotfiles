local plugins = {
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
                group = vim.api.nvim_create_augroup(
                    "griffen-lsp-attach",
                    { clear = true }
                ),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(
                            mode,
                            keys,
                            func,
                            { buffer = event.buf, desc = "LSP: " .. desc }
                        )
                    end
                    map("K", vim.lsp.buf.hover, "hover documentation")
                    map("<C-k>", vim.lsp.buf.signature_help, "signature help")
                    map("gD", vim.lsp.buf.declaration, "goto declaration")
                    map("gd", vim.lsp.buf.definition, "goto definition")
                    map("gr", vim.lsp.buf.references, "goto references")
                    map("gI", vim.lsp.buf.implementation, "goto implementation")
                    map(
                        "<leader>D",
                        vim.lsp.buf.type_definition,
                        "type definition"
                    )
                    map(
                        "<leader>ds",
                        vim.lsp.buf.document_symbol,
                        "document symbols"
                    )
                    map(
                        "<leader>ws",
                        vim.lsp.buf.workspace_symbol,
                        "workspace symbols"
                    )
                    map("<leader>rn", vim.lsp.buf.rename, "rename")
                    map(
                        "<leader>ca",
                        vim.lsp.buf.code_action,
                        "code actions",
                        { "n", "x" }
                    )
                    map("[d", vim.diagnostic.goto_prev, "diag goto prev")
                    map("]d", vim.diagnostic.goto_next, "diag goto next")
                    map(
                        "<leader>e",
                        vim.diagnostic.open_float,
                        "show diagnostic error messages"
                    )
                    map(
                        "<leader>q",
                        vim.diagnostic.setloclist,
                        "open diagnostic quickfix list"
                    )
                    vim.keymap.set({ "n", "i", "s" }, "<C-f>", function()
                        if not require("noice.lsp").scroll(4) then
                            return "<C-f>"
                        end
                    end, {
                        silent = true,
                        expr = true,
                    })

                    vim.keymap.set({ "n", "i", "s" }, "<C-b>", function()
                        if not require("noice.lsp").scroll(-4) then
                            return "<C-b>"
                        end
                    end, {
                        silent = true,
                        expr = true,
                    })

                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client.supports_method(
                            vim.lsp.protocol.Methods.textDocument_documentHighlight
                        )
                    then
                        local highlight_augroup = vim.api.nvim_create_augroup(
                            "griffen-lsp-highlight",
                            { clear = false }
                        )
                        vim.api.nvim_create_autocmd(
                            { "CursorHold", "CursorHoldI" },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )

                        vim.api.nvim_create_autocmd(
                            { "CursorMoved", "CursorMovedI" },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup(
                                "griffen-lsp-detach",
                                { clear = true }
                            ),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({
                                    group = "griffen-lsp-highlight",
                                    buffer = event2.buf,
                                })
                            end,
                        })
                    end

                    if
                        client
                        and client.supports_method(
                            vim.lsp.protocol.Methods.textDocument_inlayHint
                        )
                    then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({
                                    bufnr = event.buf,
                                })
                            )
                        end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            local servers = require("core.servers")

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
        end,
    },
    {
        "stevearc/conform.nvim",
        enabled = true,
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "black", "ruff" },
                cpp = { "clang_format" },
                tex = { "tex_fmt" },
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
                    args = { "--style=file:/Users/griffen/.clang-format" },
                },
                tex_fmt = {
                    command = "/Users/griffen/.cargo/bin/tex-fmt",
                    inherit = true,
                    args = { "-s" },
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
                "zbirenbaum/copilot-cmp",
                enabled = false,
                config = function()
                    require("copilot_cmp").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end,
            },
            {
                "hrsh7th/nvim-cmp",
                event = { "InsertEnter", "CmdlineEnter" },
            },
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
            local kind_icons = require("lib.icons").kind
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
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end,
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({
                        behaviour = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Select,
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
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "copilot" },
                    { name = "path" },
                    -- { name = "buffer" },
                    { name = "otter" },
                }),
                formatting = {
                    fields = { "abbr", "kind", "menu" },
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
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
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
                        winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
                        col_offset = 1,
                    }),
                    documentation = {
                        winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
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
