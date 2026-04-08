local plugins = {
    {
        "quarto-dev/quarto-nvim",
        ft = { "quarto" },
        enabled = true,
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                dev = false,
                dependencies = { "neovim/nvim-lspconfig" },
            },
            { "hrsh7th/nvim-cmp" },
            { "neovim/nvim-lspconfig" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("quarto").setup({
                debug = false,
                closePreviewOnExit = true,
                lspFeatures = {
                    enabled = true,
                    languages = { "r", "python", "julia", "bash" },
                    chunks = "curly",
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                    never_run = { "yaml" },
                },
            })
        end,
    },
}

return plugins
