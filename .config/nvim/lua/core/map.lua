vim.keymap.set(
    "n",
    "<Esc>",
    "<cmd>set nohlsearch<CR>",
    { desc = "clear search hl on <Esc> in normal mode" }
)
vim.keymap.set("n", "Y", "y$", { desc = "edit: Yank text to EOL" })
vim.keymap.set("n", "D", "d$", { desc = "edit: Delete text to EOL" })
vim.keymap.set(
    "n",
    "n",
    "nzzzv",
    { noremap = true, desc = "edit: next search result" }
)
vim.keymap.set(
    "n",
    "N",
    "Nzzzv",
    { noremap = true, desc = "edit: prev search result" }
)
vim.keymap.set(
    "n",
    "J",
    "mzJ`z",
    { noremap = true, desc = "edit: join next line" }
)
vim.keymap.set(
    "n",
    "<C-h>",
    "<C-w>h",
    { noremap = true, desc = "window: focus left" }
)
vim.keymap.set(
    "n",
    "<C-l>",
    "<C-w>l",
    { noremap = true, desc = "window: focus right" }
)
vim.keymap.set(
    "n",
    "<C-j>",
    "<C-w>j",
    { noremap = true, desc = "window: focus down" }
)
vim.keymap.set(
    "n",
    "<C-k>",
    "<C-w>k",
    { noremap = true, desc = "window: focus up" }
)

vim.keymap.set(
    "n",
    "tn",
    "tabnew",
    { noremap = true, silent = true, desc = "tab: create new" }
)
vim.keymap.set(
    "n",
    "tk",
    "tabnext",
    { noremap = true, silent = true, desc = "tab: move to next" }
)
vim.keymap.set(
    "n",
    "tj",
    "tabprevious",
    { noremap = true, silent = true, desc = "tab: move to previous" }
)
vim.keymap.set(
    "n",
    "to",
    "tabonly",
    { noremap = true, silent = true, desc = "tab only keep current tab" }
)

vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set(
    "i",
    "<C-b>",
    "<Left>",
    { noremap = true, desc = "edit: move cursor to left" }
)
vim.keymap.set(
    "i",
    "<C-a>",
    "<ESC>^i",
    { noremap = true, desc = "edit: move cursor to line start" }
)
vim.keymap.set(
    "i",
    "<C-s>",
    "<Esc>:w<CR>",
    { noremap = true, silent = true, desc = "edit: save file" }
)
vim.keymap.set(
    "i",
    "<C-q>",
    "<Esc>:wq<CR>",
    { noremap = true, silent = true, desc = "edit: save file + quit" }
)
vim.keymap.set(
    "i",
    "<Right>",
    "<Nop>",
    { noremap = true, silent = true, desc = "" }
)
vim.keymap.set(
    "i",
    "<Left>",
    "<Nop>",
    { noremap = true, silent = true, desc = "" }
)
vim.keymap.set(
    "i",
    "<Up>",
    "<Nop>",
    { noremap = true, silent = true, desc = "" }
)
vim.keymap.set(
    "i",
    "<Down>",
    "<Nop>",
    { noremap = true, silent = true, desc = "" }
)
vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true, desc = "edit: left" })
vim.keymap.set(
    "c",
    "<C-f>",
    "<Right>",
    { noremap = true, desc = "edit: right" }
)
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true, desc = "edit: home" })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true, desc = "edit: end" })
vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true, desc = "edit: delete" })
vim.keymap.set(
    "c",
    "<C-h>",
    "<BS>",
    { noremap = true, desc = "edit: backspace" }
)
vim.keymap.set(
    "c",
    "<C-t>",
    [[<C-R>=expand("%:p:h") . "/" <CR>]],
    { noremap = true, desc = "edit: Complete path of current file" }
)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})
vim.keymap.set("v", "<", "<gv", { desc = "edit: Decrease indent" })
vim.keymap.set("v", ">", ">gv", { desc = "edit: increase indent" })

vim.keymap.set(
    "n",
    "zm",
    "<cmd>ZenMode<CR>",
    { noremap = true, silent = true, desc = "zen-mode: toggle" }
)

vim.keymap.set(
    "n",
    "<A-q>",
    "bd! %",
    { noremap = true, silent = false, desc = "delete current buffer" }
)
vim.keymap.set(
    "n",
    "<S-h>",
    "<cmd>bprev<cr>",
    { noremap = true, silent = true, desc = "navigate to previous buffer" }
)
vim.keymap.set(
    "n",
    "<S-l>",
    "<cmd>bnext<cr>",
    { noremap = true, silent = true, desc = "navigate to next buffer" }
)
vim.keymap.set(
    "n",
    "<C-n>",
    "<cmd>lua MiniFiles.open()<cr>",
    { noremap = true, silent = true, desc = "open file navigator" }
)
vim.keymap.set(
    "n",
    "<leader>s",
    "<cmd>Scratch<cr>",
    { noremap = true, silent = true, desc = "open scratch buffer" }
)
vim.keymap.set(
    "n",
    "<leader>so",
    "<cmd>ScratchOpen<cr>",
    { noremap = true, silent = true, desc = "open scratch buffer" }
)
