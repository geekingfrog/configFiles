""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme, status bar and other eye candy things
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
set termguicolors
" set background=light

"set t_Co=88
" these require the plugin flazz/vim-colorschemes
" colorscheme corporation
" colorscheme railscasts
" colorscheme inkpot
" colorscheme molokai
" colorscheme delek
" colorscheme srcery


" Visual selection is sometimes hard to spot
" hi Visual ctermbg=238

" disable airline separators. Custom fonts are a pain to get working
" consistently across platform
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

" only show the tail of the branch
let g:airline#extensions#branch#format = 1

" disable hunk info
let g:airline#extensions#hunks#enabled = 0

" default below
" [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#checks = [ 'indent', 'long', 'mixed-indent-file' ]

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_theme='papercolor'

