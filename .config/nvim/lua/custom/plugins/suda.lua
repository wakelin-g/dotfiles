local plugins = {
    {
        "lambdalisue/suda.vim",
        config = function()
            vim.g["suda#prompt"] = "Enter administrator password: "
        end,
    },
}
return plugins
