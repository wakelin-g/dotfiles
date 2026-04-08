local plugins = {
    dir = "~/.config/plugs/nvim-todoist/",
    name = "todoist",
    enabled = true,
    config = function()
        require("todoist").setup({})
    end,
}

return plugins
