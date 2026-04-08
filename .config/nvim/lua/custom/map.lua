vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local map = function(mode, lhs, rhs, desc, silent)
  local opts = {
    noremap = true,
    desc = desc,
  }
  if silent then
    opts = vim.tbl_extend("force", opts, { silent = silent })
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Esc>", "<cmd>set nohlsearch<CR>", "")
map("n", "Y", "y$", "edit: Yank text to EOL")
map("n", "D", "d$", "edit: Delete text to EOL")
map("n", "n", "nzzzv", "edit: next search result")
map("n", "N", "Nzzzv", "edit: prev search result")
map("n", "J", "mzJ`z", "edit: join next line")
map("n", "<C-h>", "<C-w>h", "window: focus left")
map("n", "<C-l>", "<C-w>l", "window: focus right")
map("n", "<C-j>", "<C-w>j", "window: focus down")
map("n", "<C-k>", "<C-w>k", "window: focus up")

map("n", "<Up>", "<Nop>", "", true)
map("n", "<Down>", "<Nop>", "", true)
map("n", "<Left>", "<Nop>", "", true)
map("n", "<Right>", "<Nop>", "", true)
map("i", "<Right>", "<Nop>", "", true)
map("i", "<Left>", "<Nop>", "", true)
map("i", "<Up>", "<Nop>", "", true)
map("i", "<Down>", "<Nop>", "", true)

map("c", "<C-b>", "<Left>", "edit: left")
map("c", "<C-f>", "<Right>", "edit: right")
map("c", "<C-a>", "<Home>", "edit: home")
map("c", "<C-e>", "<End>", "edit: end")
map("c", "<C-d>", "<Del>", "edit: delete")
map("c", "<C-h>", "<BS>", "edit: backspace")
map("v", "J", ":m '>+1<CR>gv=gv", "")
map("v", "K", ":m '<-2<CR>gv=gv", "")
map("v", "<", "<gv", "edit: Decrease indent")
map("v", ">", ">gv", "edit: increase indent")

map("n", "<S-h>", "<cmd>bprev<cr>", "navigate to previous buffer", true)
map("n", "<S-l>", "<cmd>bnext<cr>", "navigate to next buffer", true)
map("n", "<C-n>", "<cmd>lua MiniFiles.open()<cr>", "open file navigator", true)
map("n", "<leader>s", "<cmd>Scratch<cr>", "open scratch buffer", true)
map("n", "<leader>so", "<cmd>ScratchOpen<cr>", "open scratch buffer", true)

-- emacs-like keybindings
map({ "n", "i" }, "<C-x><C-s>", "<cmd>:w<cr>", "write file")
map({ "n", "i" }, "<C-x>k", "<cmd>:bd<cr>", "kill buffer")
map({ "n", "i" }, "<C-x><C-c>", "<cmd>:qa<cr>", "kill frame")
