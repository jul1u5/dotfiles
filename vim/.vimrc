syntax on

let mapleader=' '

set clipboard=unnamedplus
set relativenumber
" Show current line number
set nu rnu

set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set smartcase

set autoread

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
" set clipboard=unnamedplus

" Open files relative to current file
set autochdir

" Command completion
set wildmenu

let g:colorizer_auto_color = 1

cnoremap w!! w !sudo tee %
map <leader><C-o> :NERDTreeToggle<CR>

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'gruvbox-community/gruvbox'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'luochen1990/rainbow'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'aymericbeaumet/vim-symlink'
Plug 'mbbill/undotree'

Plug 'sheerun/vim-polyglot'

call plug#end()

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

if !exists('g:vscode')
    " Color scheme
    set background=dark
    colorscheme gruvbox
    highlight Normal ctermbg=None
end

" Rainbow parentheses
let g:rainbow_active = 1

nnoremap <C-p> :<C-u>FZF<CR>
nmap <leader>= gg=G``

if executable('rg')
    let g:rg_derive_root = 'true'
endif

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> k
        silent! nunmap <buffer> j
        silent! nunmap <buffer> 0
        silent! nunmap <buffer> $
        silent! iunmap <buffer> k
        silent! iunmap <buffer> j
        silent! iunmap <buffer> 0
        silent! iunmap <buffer> $
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap <silent> k gk
        noremap <silent> j gj
        noremap <silent> 0 g0
        noremap <silent> $ g$
    endif
endfunction

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

cnoremap <C-d> <Del>
cnoremap d <S-Right>
cnoremap b <S-Left>
cnoremap f <S-Right>
