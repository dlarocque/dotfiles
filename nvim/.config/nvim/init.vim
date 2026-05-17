call plug#begin('~/.config/nvim/plugged')
" Search / nav
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Tags
Plug 'ludovicchabant/vim-gutentags'

" Linting
Plug 'dense-analysis/ale'

" Languages
Plug 'fatih/vim-go'
call plug#end()

lua << EOF
require('gitsigns').setup({
  signs = {
    add          = { text = '▎' },
    change       = { text = '▎' },
    delete       = { text = '▎' },
    topdelete    = { text = '▔' },
    changedelete = { text = '▎' },
    untracked    = { text = '▎' },
  },
  signcolumn = true,
  numhl = false,
})
EOF

if has('termguicolors')
  set termguicolors
endif

syntax on
set background=dark
augroup transparent_bg
  autocmd!
  autocmd ColorScheme * hi Normal       guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi NormalNC     guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi NormalFloat  guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi SignColumn   guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi LineNr       guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi EndOfBuffer  guibg=NONE ctermbg=NONE
augroup END
hi Normal       guibg=NONE ctermbg=NONE
hi NormalFloat  guibg=NONE ctermbg=NONE
hi SignColumn   guibg=NONE ctermbg=NONE
hi LineNr       guibg=NONE ctermbg=NONE
hi EndOfBuffer  guibg=NONE ctermbg=NONE

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
set signcolumn=yes
set updatetime=300
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

" vim-fugitive
nnoremap <leader>gs :G<CR>                   " git status

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

" ALE
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fix_on_save = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error   = '●'
let g:ale_sign_warning = '○'
let g:ale_sign_info    = '•'
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
nnoremap <leader>ad :ALEDetail<CR>

" gutentags
let g:gutentags_cache_dir = expand('~/.cache/nvim/gutentags')
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git', '.hg', 'package.json', 'Cargo.toml', 'go.mod', 'pyproject.toml']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
