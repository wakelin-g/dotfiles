set nocompatible
filetype plugin on
filetype plugin indent on
set path+=.
set path+=,,
set history=300
set number
set relativenumber
set wrap
set showmode
set ruler
set laststatus=2
set showcmd
set report=0
set nrformats-=octal
set wildmenu
set wildmode=full
set hidden
set cursorline
set fileformat=unix
set spelllang=en_us
set ignorecase
set infercase
set nojoinspaces
set hlsearch
set incsearch
set showmatch
set matchtime=8
set tabstop=4 softtabstop=8 shiftwidth=4 expandtab
set background=dark
let mapleader=' '
let maplocalleader=' '

call plug#begin()
  Plug 'jiangmiao/auto-pairs'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sleuth'
  Plug 'tribela/vim-transparent'
  Plug 'Yggdroot/indentLine'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'rose-pine/vim'
  Plug 'cdelledonne/vim-cmake'
call plug#end()

colorscheme rosepine
nmap <leader>? :History<CR>
nmap <leader><space> :Buffers<CR>
nmap <leader>/ :BLines<CR>
nmap <leader>ff :Files<CR>
nmap <leader>fh :Helptags<CR>
nnoremap <Esc> :nohlsearch<Esc>
nmap <S-h> :bp<CR>
nmap <S-l> :bn<CR>
vmap K :m '<-2<CR>gv=gv'
vmap J :m '>+1<CR>gv=gv'

let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1

source ~/.vimrc_functions
