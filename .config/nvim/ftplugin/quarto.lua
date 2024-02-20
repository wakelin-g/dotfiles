local config = require("quarto.config").config

local b = vim.api.nvim_get_current_buf()
local function set(lhs, rhs)
    vim.api.nvim_buf_set_keymap(b, "n", lhs, rhs, { silent = true, noremap = true })
end

set(config.keymap.definition, ":lua require'otter'.ask_definition()<CR>")
set(config.keymap.type_definition, ":lua require'otter'.ask_type_definition()<CR>")
set(config.keymap.hover, ":lua require'otter'.ask_hover()<CR>")
set(config.keymap.rename, ":lua require'otter'.ask_rename()<CR>")
set(config.keymap.references, ":lua require'otter'.ask_references()<CR>")
set(config.keymap.document_symbols, ":lua require'otter'.ask_document_symbols()<CR>")
set(config.keymap.format, ":lua require'otter'.ask_format()<CR>")

local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "molten init", silent = false })
vim.keymap.set("n", "<localleader>qa", ":QuartoActivate<CR>", { desc = "quarto activate", silent = false })
vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })


