return {
    {
        "echasnovski/mini.surround",
        branch = "stable",
        config = function()
            require("mini.surround").setup({})
        end,
    },
    {
        "echasnovski/mini.comment",
        version = "*",
        config = function()
            require("mini.comment").setup({
                custom_surroundings = nil,
                highlight_duration = 500,
                mappings = {
                    add = "sa",
                    delete = "sd",
                    replace = "sr",
                    find = "sf",
                    find_left = "sF",
                    highlight = "sh",
                    suffix_last = "l",
                    suffix_next = "n",
                },
                n_lines = 20,
                respect_selection_type = false,
                search_method = "cover",
                silent = false,
            })
        end,
    },
}
