return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            position = "right",
            width = 50,
            icons = true,
        },
        config = function()
            require("trouble").setup({icons = false})
            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)
            vim.keymap.set("n", "[d", function()
                require("trouble").next({skip_groups=true, jump=true});
            end)
            vim.keymap.set("n", "]d", function()
                require("trouble").previous({skip_groups=true, jump=true});
            end)
        end,
    },
}
