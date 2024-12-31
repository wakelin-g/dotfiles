local plugins = {
    dir = "~/.config/plugs/scratch.nvim",
    name = "scratch",
    enabled = true,
    config = function()
        require("scratch").setup({
            scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch",
            window_cmd = "edit",
            use_telescope = false,
            file_picker = "fzflua",
            filetypes = { "md", "lua", "py", "c", "cpp" },
        })
    end,
    event = "VeryLazy",
    dependencies = {
        { "ibhagwan/fzf-lua", event = "VeryLazy" },
    },
}

return plugins
