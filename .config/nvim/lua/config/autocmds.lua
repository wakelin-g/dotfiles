-- only highlight when searching
vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = function()
        local cmd = vim.v.event.cmdtype
        if cmd == "/" or cmd == "?" then
            vim.opt.hlsearch = true
        end
    end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        local cmd = vim.v.event.cmdtype
        if cmd == "/" or cmd == "?" then
            vim.opt.hlsearch = false
        end
    end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = { c = false, r = false, o = false }
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.md" },
    callback = function()
        local map = vim.keymap.set
        vim.opt.wrap = true
        map({'n'}, 'j', 'gj', {noremap = true})
        map({'n'}, 'k', 'gk', {noremap = true})
        map({'n'}, 'gk', 'k', {noremap = true})
        map({'n'}, 'gj', 'j', {noremap = true})
    end,
})

-- keymap for .py file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.py" },
    callback = function()
        vim.keymap.set(
            "n",
            "<Leader>e",
            ":terminal python3 %<CR>",
            { silent = true }
        )
    end,
})
