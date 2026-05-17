" Markdown-specific overrides — loaded automatically for .md buffers.

setlocal wrap                 " soft-wrap long lines (don't insert newlines)
setlocal linebreak            " wrap at word boundary, not mid-word
setlocal breakindent          " preserve indent on wrapped lines
setlocal showbreak=↪\         " visual marker for wrapped continuation
setlocal textwidth=0          " no hard wrap
setlocal spell spelllang=en
setlocal conceallevel=2       " render _italic_ / **bold** markers as styling
setlocal concealcursor=

" Toggle spellcheck per-buffer
nnoremap <buffer> <leader>s :setlocal spell!<CR>

" j/k navigate visual lines (so cursor moves through wrapped text naturally)
nnoremap <buffer> j gj
nnoremap <buffer> k gk
xnoremap <buffer> j gj
xnoremap <buffer> k gk
