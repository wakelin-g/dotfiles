-- if require('zk.util').notebook_root(vim.fn.expand('%:p')) ~= nil then
--     local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
--     local opts = { noremap = true, silent = true }
--
--     map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
--     map("n","<leader>zn","<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
--     map("v","<leader>znt",":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
--     map("v","<leader>znc",":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
--     map("n","<leader>zb","<Cmd>ZkBackLinks<CR>", opts)
--     map("n","<leader>zl","<Cmd>ZkLinks<CR>", opts)
--     map("n","K","<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
--     map("v","<leader>za",":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
-- end

vim.opt.conceallevel = 2
vim.opt.wrap = true
vim.opt.textwidth = 80

local opts = { noremap = true, silent = true }
local function map(...)
    vim.api.nvim_buf_set_keymap(0, ...)
end

map("n", "<leader>on", "<cmd>ObsidianNew<cr>", opts)
map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", opts)
map("n", "<leader>os", "<cmd>ObsidianSearch<cr>", opts)
map("v", "<leader>l", ":'<,'>ObsidianLink<cr>", opts)
map("v", "<leader>ln", ":'<,'>ObsidianLinkNew<cr>", opts)

