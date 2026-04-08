local plugins = {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        opts = {
            rocks = { "ftcsv" },
        },
    },
}

return plugins
