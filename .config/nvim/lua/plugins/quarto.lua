return {
    {
        "quarto-dev/quarto-nvim",
        dev = false,
        ft = { "quarto" },
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                dev = false,
                dependencies = { "neovim/nvim-lspconfig" },
            },
            {"hrsh7th/nvim-cmp"},
            {"neovim/nvim-lspconfig"},
            {"nvim-treesitter/nvim-treesitter"},
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
                        enabled = true
                    },
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                    never_run = { "yaml" },
                },
            })
        end
    },
    {
        "benlubas/molten-nvim",
        lazy = "VeryLazy",
        ft = { "qmd", "quarto", "python" },
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 12
            vim.g.molten_use_border_highlights = true
            vim.g.molten_virt_text_output = true
            vim.keymap.set("n", ",mi", ":MoltenInit<CR>")
        end,
    },
}
