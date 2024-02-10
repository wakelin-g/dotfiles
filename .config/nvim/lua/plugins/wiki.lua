return {
    {
        "mickael-menu/zk-nvim",
        opts = {
            picker = "telescope",
            lsp = {
                config = {
                    cmd = { "zk", "lsp" },
                    name = "zk",
                },
                auto_attach = true,
                filetypes = { "markdown" },
            },
        },
        config = function()
            require("zk").setup({})
            local map = vim.keymap.set
            map("n", "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { silent = true, desc = "zk: new note" })
            map("n", "<leader>zt", "<cmd>ZkTags<CR>", { silent = true, desc = "zk: tags" })
            map("v", "<leader>zm", "<cmd>ZkMatch<CR>", { silent = true, desc = "zk: match under cursor" })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
}
