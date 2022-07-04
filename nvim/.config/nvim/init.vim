call plug#begin('~/.config/nvim/plugged')
" General
" Plug 'preservim/nerdcommenter'             " better commenting
Plug 'jiangmiao/auto-pairs'                " auto brackets, surrounds
" Plug 'tpope/vim-fugitive'                  " git integration
Plug 'zhou13/vim-easyescape'               " no delay when going into cmd mode
Plug 'fatih/vim-go'                        " vim go tools, i love this
Plug 'vim-airline/vim-airline'             " better status/tabline
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'                       " LaTeX support in vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Completion, Syntax highlighting
" Plug 'neovim/nvim-lspconfig'               
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'                   
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Color Schemes
Plug 'tomasiser/vim-code-dark'           
" Plug 'mswift42/vim-themes'
" Plug 'morhetz/gruvbox'                  
" Plug 'joshdick/onedark.vim'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'w0ng/vim-hybrid'
" Plug 'arcticicestudio/nord-vim'
" Plug 'sickill/vim-monokai'
" Plug 'ErichDonGubler/vim-sublime-monokai'
" Plug 'lifepillar/vim-solarized8'        
" Plug 'jeffkreeftmeijer/vim-dim'
" Plug 'doums/darcula'
Plug 'vim-airline/vim-airline-themes'  
call plug#end()

" lua require("dlarocque")
" lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

" better colors
if has('termguicolors')
    set termguicolors
endif

syntax on
set background=dark
colorscheme codedark

" set relativenumber                          " relative line numbers
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
" set signcolumn=yes                          " show the sign column on the lhs
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
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
let g:airline_theme="minimalist"

" vimtex
let g:vimtex_view_method = 'zathura' " use zathura as pdf viewer
" nnoremap <leader>v <plug>(vimtex-view)

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

nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>

" Find and replace
nnoremap <C-H> :%s/
xnoremap <C-H> :s/

" NERDTree
nnoremap <C-N> NERDTreeToggle<CR>

" File search
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>

" Clear highlighting
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Restore cursor shape to beam on exit
" augroup restore_cursor_shape
"   autocmd!
"   au VimLeave * set guicursor=a:ver10-blinkoff0
" augroup END

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
