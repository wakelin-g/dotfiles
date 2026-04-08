local plugins = {
    "wakelin-g/run.nvim",
    enabled = false,
    dev = false,
    name = "run.nvim",
    event = "VeryLazy",
    config = function()
        require("run").setup({
            commands = {
                ["c"] = {
                    "clang " .. vim.fn.expand("%") .. " && ./a.out",
                    "gcc-13 " .. vim.fn.expand("%") .. " && ./a.out",
                },
                ["cpp"] = {
                    "clang++ " .. vim.fn.expand("%") .. " && ./a.out",
                },
                ["python"] = { "python3 " .. vim.fn.expand("%") },
                ["rust"] = { "cargo run" },
                ["go"] = { "go run " .. vim.fn.expand("%") },
                ["lua"] = {
                    "lua " .. vim.fn.expand("%"),
                    "luafile " .. vim.fn.expand("%"),
                },
            },
            win_width = 40,
            set_wrap = true,
            use_default_bindings = true,
        })
    end,
}

return plugins
