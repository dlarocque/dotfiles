" Vim color file
" Name: dlarocque
" Based on: solarized8

" 1. Clear existing highlights
" This is required for a :colorscheme file.
hi clear
if exists("syntax_on")
  syntax reset
endif

" 2. Set background type
set background=dark

" 3. Load the base 'solarized8' theme script
" We use 'runtime!' to find and source the file.
" This avoids the nested :colorscheme error.
" This will set g:colors_name = "solarized8"
try
  runtime! colors/solarized8.vim
catch
  echom "Error: Cannot find 'colors/solarized8.vim' in runtimepath."
  finish
endtry

" 4. Set the name back to this new scheme
" Must be done *after* sourcing solarized8.
let g:colors_name = "dlarocque"

" --- Theme Modifications ---
" These overrides are now applied on top of the loaded solarized8.

" Set the main background color
hi Normal guibg=#00141a ctermbg=232

" Set the line number background to match the Normal background
hi LineNr guibg=#00141a ctermbg=232

" Update other elements that should match the new background
hi EndOfBuffer guifg=#00141a ctermfg=232
hi SignColumn guibg=#00141a ctermbg=232
hi FoldColumn guibg=#00141a ctermbg=232
hi ColorColumn guibg=#00141a ctermbg=232
