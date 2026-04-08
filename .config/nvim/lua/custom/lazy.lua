local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "custom.plugins",
    change_detection = {
        notify = false,
    },
    dev = {
        path = "~/.config/plugs/",
        fallback = false,
    },
    ui = {
        border = "none",
    },
    checker = {
        enabled = true,
        concurrency = 8,
        frequency = 24 * 60 * 60,
        notify = true,
    },
    concurrency = 8,
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    rocks = {
        enabled = true,
    },
})
