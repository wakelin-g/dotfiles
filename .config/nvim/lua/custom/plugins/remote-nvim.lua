local plugins = {
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
}

return plugins
