call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'bling/vim-airline'
Plug 'cespare/vim-toml'
Plug 'chrisbra/Colorizer'

call plug#end()

syntax on			" Syntax highlighting
colorscheme gruvbox		" Color scheme
set background=dark
highlight Normal ctermbg=None
set number			" Show line numbers
set showbreak=+++		" Wrap-broken line prefix
set textwidth=100		" Line wrap (number of cols)
set showmatch			" Highlight matching brace

set hlsearch			" Highlight all search results
set smartcase			" Enable smart-case search
set ignorecase			" Always case-insensitive
set incsearch			" Searches for strings incrementally

set autoindent			" Auto-indent new lines
set shiftwidth=4		" Number of auto-indent spaces
set smartindent			" Enable smart-indent
set smarttab			" Enable smart-tabs
set softtabstop=4		" Number of spaces per Tab

set ruler			" Show row and column ruler information

set undolevels=1000		" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set clipboard=unnamedplus	" Use system clipboard to copy and pase

" set path+=**			" Search down into subfolders
set wildmenu			" Display suggestions when using autocompletion

let g:colorizer_auto_color = 1
