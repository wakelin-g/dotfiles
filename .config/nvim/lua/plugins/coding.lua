local plugins = {
    {
        "lambdalisue/suda.vim",
        config = function()
            vim.g["suda#prompt"] = "Enter administrator password: "
        end,
    },
    {
        "nvimdev/template.nvim",
        cmd = { "Template", "TemProject" },
        config = function()
            require("template").setup({
                temp_dir = "~/.config/nvim/template/",
                author = "Griffen Wakelin",
                email = "wakelin@dal.ca",
            })
        end,
    },
    {
        "amitds1997/remote-nvim.nvim",
        enabled = IS_MACOS,
        verison = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = true,
    },
    {
        "zbirenbaum/copilot.lua",
        enabled = IS_MACOS,
        version = "*",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
}

return plugins
