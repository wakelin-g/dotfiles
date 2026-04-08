local plugins = {
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
}
return plugins
