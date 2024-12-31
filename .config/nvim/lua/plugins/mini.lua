local plugins = {
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
    {
        "echasnovski/mini.files",
        version = "*",
        config = function()
            require("mini.files").setup()
        end,
    },
    {
        "echasnovski/mini.pairs",
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "echasnovski/mini.statusline",
        version = "*",
        config = function()
            require("mini.statusline").setup()
        end,
    },
    {
        "echasnovski/mini.tabline",
        version = "*",
        config = function()
            require("mini.tabline").setup()
        end,
    },
    {
        "echasnovski/mini.icons",
        version = "*",
        config = function()
            require("mini.icons").setup({
                use_file_extension = function(ext, _)
                    local suf3, suf4 = ext:sub(-3), ext:sub(-4)
                    return suf3 ~= "scm"
                        and suf3 ~= "txt"
                        and suf3 ~= "yml"
                        and suf4 ~= "json"
                        and suf4 ~= "yaml"
                end,
            })
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
}

return plugins
