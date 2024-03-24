local opt = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python_host_prog = "/Users/griffen/mambaforge/envs/nvim/bin/python"
vim.g.python3_host_prog = "/Users/griffen/mambaforge/envs/nvim/bin/python3"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.autoindent = true
opt.autoread = true
opt.autowrite = false
opt.backspace = "indent,eol,start"
opt.backup = false
opt.backupskip =
    "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
opt.breakat = [[\ \   ;:,!?]]
opt.breakindent = true
opt.breakindentopt = "shift:2,min:20"
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.cmdwinheight = 5
opt.complete = ".,w,b,k"
opt.completeopt = "menuone,noselect"
opt.concealcursor = "niv"
opt.conceallevel = 0
opt.cursorcolumn = false
opt.cursorline = true
opt.cursorlineopt = "number"
opt.diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience"
opt.display = "lastline"
opt.encoding = "utf-8"
opt.equalalways = false
opt.errorbells = true
opt.fileformats = "unix,mac,dos"
opt.foldenable = true
opt.foldlevelstart = 99
opt.formatoptions = "1jcroql"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --hidden --vimgrep --smart-case --"
opt.helpheight = 12
opt.hidden = true
opt.history = 2000
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.infercase = true
opt.jumpoptions = "stack"
opt.laststatus = 2
opt.linebreak = true
opt.list = true
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
opt.magic = true
opt.mousescroll = "ver:3,hor:6"
opt.number = true
opt.previewheight = 12
opt.pumheight = 15
opt.redrawtime = 1500
opt.relativenumber = true
opt.ruler = true
opt.scrolloff = 5
opt.sessionoptions = "buffers,curdir,help,tabpages,winsize"
opt.shada = "!,'300,<50,@100,s10,h"
opt.shiftround = true
opt.shortmess = "aoOTIcF"
opt.showbreak = "↳  "
opt.showcmd = false
opt.showmode = false
opt.showtabline = 2
opt.sidescrolloff = 5
opt.signcolumn = "yes"
opt.smartcase = true
opt.smarttab = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.startofline = false
opt.swapfile = false
opt.switchbuf = "usetab,uselast"
opt.synmaxcol = 2500
opt.termguicolors = true
opt.timeout = true
opt.timeoutlen = 300
opt.ttimeout = true
opt.ttimeoutlen = 0
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 250
opt.viewoptions = "folds,cursor,curdir,slash,unix"
opt.virtualedit = "block"
opt.visualbell = false
opt.whichwrap = "h,l,<,>,[,],~"
opt.wildignore =
    ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
opt.wildignorecase = true
opt.wrap = false
opt.wrapscan = true
opt.writebackup = false
