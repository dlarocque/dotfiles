call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tomasiser/vim-code-dark'
call plug#end()

if has('termguicolors')
    set termguicolors
endif

set background=dark
colorscheme codedark

set relativenumber 
set showmatch    " show matching brackets
set mouse=v      " middle click paste
set hlsearch   
set fileencoding=utf-8
set showbreak=↪
set visualbell noerrorbells
set history=500
set undofile               " persistent undo
set undofile
set expandtab               " spaces are better than tabs
set shiftwidth=4            " 4 spaces per auto indent
set autoindent
set tabstop=4
set softtabstop=4
set mouse=a
set clipboard=unnamedplus
set noswapfile
filetype plugin on

" nerd commenter configs
let g:NERDSpaceDelims=1
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
