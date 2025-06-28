call plug#begin('~/.config/nvim/plugged')
" General
Plug 'lewis6991/gitsigns.nvim'
" Plug 'vim-airline/vim-airline'             " better status/tabline
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Languages
Plug 'fatih/vim-go'

" Snippets
Plug 'SirVer/ultisnips'

" Color Schemes
Plug 'dlarocque/balance'
Plug 'craftzdog/solarized-osaka.nvim'
Plug 'nordtheme/vim'
Plug 'vim-airline/vim-airline-themes'  
Plug 'plan9-for-vimspace/acme-colors'
call plug#end()

syntax on
set background=dark
colorscheme balance

" set relativenumber                          " relative line numbers
" set nu                                      " show the actual line number
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
" set colorcolumn=80
set signcolumn=no                          " show the sign column on the lhs
" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:ver100-iCursor
" set guicursor+=n-v-c:blinkon0
" set guicursor+=i:blinkwait10
" set guicursor=i:block
set autowrite
set splitright
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
" let g:airline_theme="base16_darktooth"
let g:airline_theme="monochrome"

" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura' " use zathura as pdf viewer
let g:vimtex_quickfix_mode=0
hi clear Conceal

" vim tex conceal
set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none

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
nnoremap <leader>d :Ex<CR>

nnoremap<leader>vrc :e $MYVIMRC<CR>

" quick source
nnoremap <leader><CR> :w<bar>:so %<CR> " save and source

nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>

" Find and replace
nnoremap <C-H> :%s/
xnoremap <C-H> :s/

" NERDTree
" nnoremap <leader>t <CMD>NERDTreeToggle<CR> 
" let NERDTreeShowHidden=1

" trouble
nnoremap <leader>e <CMD>TroubleToggle<CR>

" File search
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>

let g:vimtex_view_method = 'zathura'

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
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>t  <Plug>(go-test)

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
