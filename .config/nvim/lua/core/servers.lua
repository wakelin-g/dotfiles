local M = {
    clangd = {
        cmd = {
            "clangd",
            "--completion-style=detailed",
            "--header-insertion=never",
        },
        on_attach = function()
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
        end,
    },
    bashls = {},
    yamlls = {},
    texlab = {},
    -- pylsp = {},
    -- pyright = {},
    basedpyright = {
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = "standard",
                },
            },
        },
    },
    rust_analyzer = {},
    lua_ls = {
        settings = {
            Lua = {
                telemetry = { enable = false },
                runtime = { version = "LuaJIT" },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        "${3rd}/luv/library",
                        unpack(vim.api.nvim_get_runtime_file("", true)),
                    },
                },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    },
}

return M
