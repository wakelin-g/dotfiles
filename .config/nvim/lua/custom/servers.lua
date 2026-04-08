local M = {
    clangd = {
        cmd = {
            "/opt/homebrew/opt/llvm/bin/clangd",
            "--log=verbose",
            "--pretty",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--enable-config",
            "--completion-style=detailed",
        },
        filetypes = { "c", "cpp" },
        on_attach = function()
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
        end,
    },
    bashls = {
        filetypes = { "bash", "sh", "zsh" },
    },
    yamlls = {},
    texlab = {},
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
                diagnostics = {
                    globals = { "vim" },
                },
                hover = { expandAlias = false },
            },
        },
    },
}

return M
