local plugins = {
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
                stylua = {
                    command = "stylua --indent-width=2",
                },
            },
        },
    },
}
return plugins
