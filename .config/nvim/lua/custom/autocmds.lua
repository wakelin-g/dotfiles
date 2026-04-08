local autocmd = vim.api.nvim_create_autocmd

--[[ general qol autocmds ]]
--
-- only highlight when searching
autocmd("CmdlineEnter", {
    callback = function()
        local cmd = vim.v.event.cmdtype
        if cmd == "/" or cmd == "?" then
            vim.opt.hlsearch = true
        end
    end,
})
autocmd("CmdlineLeave", {
    callback = function()
        local cmd = vim.v.event.cmdtype
        if cmd == "/" or cmd == "?" then
            vim.opt.hlsearch = false
        end
    end,
})

-- Highlight when yanking
autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Disable auto comment
autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = { c = false, r = false, o = false }
    end,
})

-- remap j/k to gj/gk in markdown files
autocmd("BufEnter", {
    pattern = { "*.md" },
    callback = function()
        local map = vim.keymap.set
        vim.opt.wrap = true
        map({ "n" }, "j", "gj", { noremap = true })
        map({ "n" }, "k", "gk", { noremap = true })
        map({ "n" }, "gk", "k", { noremap = true })
        map({ "n" }, "gj", "j", { noremap = true })
    end,
})

-- close specified filetypes with <q> (no :bd required)
autocmd("FileType", {
    group = vim.api.nvim_create_augroup(
        "griffen_close_with_q",
        { clear = true }
    ),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "Jaq",
        "lir",
        "DressingSelect",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(opts)
        vim.bo[opts.buf].buflisted = false
        -- vim.keymap.set(
        --   "n",
        --   "q",
        --   "<cmd>close<cr>",
        --   { buffer = opts.buf, silent = true }
        -- )
        vim.keymap.set(
            "n",
            "q",
            "<cmd>bd<cr>",
            { buffer = opts.buf, silent = true }
        )
    end,
})

-- jump to last known position
autocmd("BufRead", {
    callback = function(opts)
        vim.api.nvim_create_autocmd("BufWinEnter", {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line =
                    vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match("commit") and ft:match("rebase"))
                    and last_known_line > 1
                    and last_known_line
                        <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], "nx", false)
                end
            end,
        })
    end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("griffen_last_loc", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- strip trailing spaces before write
autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup(
        "griffen_strip_spaces",
        { clear = true }
    ),
    pattern = { "*" },
    callback = function()
        vim.cmd([[ %s/\s\+$//e ]])
    end,
})

--[[ mini.nvim-related config options ]]
--
-- move title of mini.files window to center
autocmd("User", {
    group = vim.api.nvim_create_augroup(
        "griffen_change_minifiles_ui",
        { clear = true }
    ),
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
        local config = vim.api.nvim_win_get_config(args.data.win_id)
        config.title_pos = "center"
        vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
})
-- change title padding of mini-files window
autocmd("User", {
    group = vim.api.nvim_create_augroup(
        "griffen_change_minifiles_titlepadding",
        { clear = true }
    ),
    pattern = "MiniFilesWindowUpdate",
    callback = function(args)
        local config = vim.api.nvim_win_get_config(args.data.win_id)
        config.height = 10
        if config.title[#config.title][1] ~= " " then
            table.insert(config.title, { " ", "NormalFloat" })
        end
        if config.title[1][1] ~= " " then
            table.insert(config.title, 1, { " ", "NormalFloat" })
        end
        vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
})
-- disable mini.surround in elisp files
autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup(
        "griffen_disable_minisurround_elisp",
        { clear = true }
    ),
    pattern = { "*.el" },
    callback = function(opts)
        if vim.bo[opts.buf].filetype == "lisp" then
            vim.b.minisurround_disable = true
        end
    end,
})

--[[ lsp-related autocmds ]]
--
autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("griffen-lsp-attach", { clear = true }),
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
        map("<leader>D", vim.lsp.buf.type_definition, "type definition")
        map("<leader>ds", vim.lsp.buf.document_symbol, "document symbols")
        map("<leader>ws", vim.lsp.buf.workspace_symbol, "workspace symbols")
        map("<leader>rn", vim.lsp.buf.rename, "rename")
        map("<leader>ca", vim.lsp.buf.code_action, "code actions", { "n", "x" })
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
        -- vim.keymap.set({ "n", "i", "s" }, "<C-f>", function()
        --   if not require("noice.lsp").scroll(4) then
        --     return "<C-f>"
        --   end
        -- end, {
        --   silent = true,
        --   expr = true,
        -- })
        --
        -- vim.keymap.set({ "n", "i", "s" }, "<C-b>", function()
        --   if not require("noice.lsp").scroll(-4) then
        --     return "<C-b>"
        --   end
        -- end, {
        --   silent = true,
        --   expr = true,
        -- })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
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
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

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
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                    bufnr = event.buf,
                }))
                print("inlay hints enabled")
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})
