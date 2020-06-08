syntax on

set number

set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set smartcase

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch
" Highlight all search results
set hlsearch
" Enable smart-case search
set smartcase

" Highlight matching brace
set showmatch

" Use system clipboard to copy and pase
set clipboard=unnamedplus

" Open files relative to current file
set autochdir

" Command completion
set wildmenu

let g:colorizer_auto_color = 1

cnoremap w!! w !sudo tee %
map <C-o> :NERDTreeToggle<CR>

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'gruvbox-community/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'luochen1990/rainbow'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'

Plug 'LnL7/vim-nix'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'vmchale/dhall-vim'

call plug#end()

" Color scheme
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=None

" Rainbow parentheses
let g:rainbow_active = 1

if executable('rg')
    let g:rg_derive_root = 'true'
endif

let mapleader = ' '
