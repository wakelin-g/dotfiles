set history=500
filetype plugin on
filetype indent on
set autoread
au FocusGained,BufEnter * silent! checktime

let mapleader=" "
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
set so=7     " set scroll-off to 7 (buffer scrolls when cursor is 7 from top/bottom)
set wildmenu " command-line completion
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set ruler " shows `<row>,<col>\t\t<percent_file>` in bottom right (redundant if lightline)
set number " shows line number in column to left of code
set cmdheight=2 " change height of bottom cmd bar
set hid " does not unload buffers when they are abandoned
set backspace=eol,start,indent
set whichwrap+=<,>,h,l " allows moving to next/prev line when using h/l at start/end of line
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1
syntax enable
set regexpengine=0
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai
set si
set wrap

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

set laststatus=2

" PLUGINS ----------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'rose-pine/vim'
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" PLUGIN-SPECIFIC COMMANDS -----------------------------------
nnoremap <C-n> :NERDTreeToggle<CR>
filetype plugin indent on
let g:lightline = { 'colorscheme': 'rosepine' }
colorscheme rosepine_moon
set background=dark

" USE ag TO SEARCH IF POSSIBLE -------------------------------
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif

" MISC -------------------------------------------------------
map <leader>pp :setlocal paste!<cr>

" HELPER FUNCTIONS -------------------------------------------
function! HasPaste()
    if &paste
        return 'PASTE MODE '
    endif
    return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
