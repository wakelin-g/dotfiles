local plugins = {
    {
        "stevearc/oil.nvim",
        config = function()
            function _G.get_oil_winbar()
                local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
                local dir = require("oil").get_current_dir(bufnr)
                if dir then
                    return vim.fn.fnamemodify(dir, ":~")
                else
                    return vim.api.nvim_buf_get_name(0)
                end
            end
            require("oil").setup({
                keymaps = {
                    ["<leader>d"] = {
                        desc = "toggle file detail view",
                        callback = function()
                            detail = not detail
                            if detail then
                                require("oil").set_columns({
                                    "icon",
                                    "permissions",
                                    "size",
                                    "mtime",
                                })
                            else
                                require("oil").set_columns({ "icon" })
                            end
                        end,
                    },
                },
                win_options = {
                    winbar = "%!v:lua.get_oil_winbar()",
                },
            })
        end,
    },
}
return plugins
