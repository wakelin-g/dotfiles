return {
    {
        "m4xshen/autoclose.nvim",
        opts = {
            disabled = false,
            options = {
                disabled_filetypes = { "text" },
                disable_when_touch = false,
                touch_regex = "[%w(%[{]",
                pair_spaces = true,
                auto_indent = true,
                disable_command_mode = false,
            },
            keys = {

                ["("] = { escape = false, close = true, pair = "()" },
                ["["] = { escape = false, close = true, pair = "[]" },
                ["{"] = { escape = false, close = true, pair = "{}" },

                [">"] = { escape = true, close = false, pair = "<>" },
                [")"] = { escape = true, close = false, pair = "()" },
                ["]"] = { escape = true, close = false, pair = "[]" },
                ["}"] = { escape = true, close = false, pair = "{}" },

                ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "markdown" } },
                ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = { "markdown" } },
                ["`"] = { escape = true, close = true, pair = "``" },

                [" "] = { escape = false, close = true, pair = "  " },

                ["<BS>"] = {},
                ["<C-H>"] = {},
                ["<C-W>"] = {},
                ["<CR>"] = { disable_command_mode = true },
                ["<S-CR>"] = { disable_command_mode = true },

            },
        },
    },
}
