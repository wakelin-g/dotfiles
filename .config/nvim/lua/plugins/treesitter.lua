return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = {
                    "c","cpp","bash","lua","markdown","markdown_inline","python","julia",
                    "yaml","vim","query","vimdoc","latex","html","css","dot",
                },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                    additional_vim_regex_highlighting = { "latex", "c", "cpp", "markdown", "markdown_inline", "python" },
                },
                indent = { enable = true },
                sync_install = false,
            })
        end,
    },
}
