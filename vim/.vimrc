call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'bling/vim-airline'
Plug 'cespare/vim-toml'
Plug 'chrisbra/Colorizer'

call plug#end()

" Syntax highlighting
syntax on

" Color scheme
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=None

" Show line numbers
set number

" Wrap-broken line prefix
set showbreak=+++

" Line wrap (number of cols)
set textwidth=100

" Highlight matching brace
set showmatch

" Highlight all search results
set hlsearch

" Enable smart-case search
set smartcase

" Always case-insensitive
set ignorecase

" Searches for strings incrementally
set incsearch

" Auto-indent new lines
set autoindent

" Number of auto-indent spaces
set shiftwidth=2

" Enable smart-indent
set smartindent

" Enable smart-tabs
set smarttab

" Number of spaces per tab
set softtabstop=2

" Show row and column ruler information
set ruler

" Number of undo levels
set undolevels=1000

" Backspace behaviour
set backspace=indent,eol,start

" Use system clipboard to copy and pase
set clipboard=unnamedplus

" Search down into subfolders
" set path+=**

" Display suggestions when using autocompletion
set wildmenu

let g:colorizer_auto_color = 1
