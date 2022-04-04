call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdcommenter'             " better commenting
Plug 'jiangmiao/auto-pairs'                " auto brackets, surrounds
Plug 'tomasiser/vim-code-dark'             " vscode theme
Plug 'morhetz/gruvbox'                     " cozy
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'sickill/vim-monokai'
Plug 'vim-airline/vim-airline'             " better status/tabline
Plug 'tpope/vim-fugitive'                  " git integration
Plug 'zhou13/vim-easyescape'               " no delay when going into cmd mode
Plug 'fatih/vim-go'                        " vim go tools, i love this
Plug 'altercation/vim-colors-solarized'    " solarized color theme that doesn't work 
Plug 'lifepillar/vim-solarized8'           " solarized color theme that actually works
Plug 'vim-airline/vim-airline-themes'      " themes for vim-airline status bar
Plug 'neovim/nvim-lspconfig'               " language server protocol!
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'                    " language server protocol!
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua require("dlarocque")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

" better colors
if has('termguicolors')
    set termguicolors
endif

syntax enable
set background=dark
colorscheme codedark

set relativenumber                          " relative line numbers
set nu                                      " show the actual line number
set hidden
set nowrap                                  " no wrapping
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
set scrolloff=8                             " dont go all the way down before scrolling
set signcolumn=yes                          " show the sign column on the lhs
filetype plugin on

" netrw
let g:netrw_liststyle=3                     " tree view
let g:netrw_banner=0                        " no stupid banner
let g:netrw_browse_split=0                  " open new files in a new buffer in the previous window

" nerdcommenter configs
let g:NERDSpaceDelims=1                     " space between comments and text
let g:CompactSexyComs=1

" vim-airline
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme="base16_solarized_dark"


" vim-fugitive
nnoremap <leader>gs :G<CR>                   " git status

" vim-easyescape
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

" MAPPINGS
let mapleader = ' '
nnoremap ; :
xnoremap ; :

nnoremap H 0
xnoremap H 0
nnoremap L $
xnoremap L $

" window management
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>  " open file tree on lhs at size 30
nnoremap <leader>t :Ex<CR> " open file tree

nnoremap<leader>rc :e $MYVIMRC<CR>

" quick source
nnoremap <leader><CR> :w<bar>:so %<CR> " save and source


" Find and replace
nnoremap <C-H> :%s/
xnoremap <C-H> :s/

" NERDTree
nnoremap <C-N> NERDTreeToggle<CR>


" Clear highlighting
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Keep cursor position after yanking
nnoremap y myy
xnoremap y myy

" maintain cursor position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

" gopls and vim-go
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'

" OPTIONS
" Ignore certain files and folders when globing
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase  " ignore file and dir name cases in cmd-completionf

" MISC
au BufNewFile,BufRead Jenkinsfile setf groovy " Jenkinsfile syntax highlighting
