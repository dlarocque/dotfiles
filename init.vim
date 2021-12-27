call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdcommenter'             " better commenting
Plug 'jiangmiao/auto-pairs'                " auto brackets, surrounds
Plug 'tomasiser/vim-code-dark'             " vscode theme
Plug 'morhetz/gruvbox'                     " cozy
call plug#end()

" better colors
if has('termguicolors')
    set termguicolors
endif

set background=dark
colorscheme codedark

set relativenumber                          " relative line numbers
set showmatch                               " highlight matching brackets
set hlsearch                                " highlight search results
set fileencoding=utf-8
set showbreak=↪                             " symbol to show wrapped lines
set visualbell noerrorbells                 " annoying bells
set history=500                             " undo history
set undofile                                " persistent undo
set expandtab                               " spaces are better than tabs
set shiftwidth=4                            " 4 spaces per auto indent
set autoindent                              " auto indent blocks
set tabstop=4                               
set softtabstop=4
set mouse=a                                 " mouse clicking
set clipboard=unnamedplus                   " copy paste from clipboard
set noswapfile                              " no useless swap files
filetype plugin on

" nerd commenter configs
let g:NERDSpaceDelims=1                     " space between comments and text
let g:CompactSexyComs=1

" MAPPINGS
let mapleader = ','
nnoremap ; :
xnoremap ; :

nnoremap H 0
xnoremap H 0
nnoremap L $
xnoremap L $

" Find and replace
nnoremap <C-H> :%s/
xnoremap <C-H> :s/

" Clear highlighting
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Keep cursor position after yanking
nnoremap y myy
xnoremap y myy

" OPTIONS
" Ignore certain files and folders when globing
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase  " ignore file and dir name cases in cmd-completionf
