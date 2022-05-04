""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme, status bar and other eye candy things
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" a handy one-liner to display all 256 colors
" for i in {0..255}; do print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'}; done # one liner for all the colors


" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
set termguicolors

"set t_Co=88
" these require the plugin flazz/vim-colorschemes
" colorscheme corporation
" colorscheme railscasts
" colorscheme inkpot
" colorscheme molokai
" colorscheme delek
" colorscheme srcery

set background=light
colorscheme gruvbox

" default colorscheme works well with solarized-alacrity
" except some of the diff themes
" https://vi.stackexchange.com/questions/10897/how-do-i-customize-vimdiff-colors
" neovim uses gui colors, even for terminals
hi DiffText guibg=lightMagenta " same as DiffChange guibg

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
" let g:airline#extensions#branch#displayed_head_limit = 40
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
  if len(a:name) > 30
    return a:name[0:6] . '…' . a:name[-25:]
  else
    return a:name
  endif
endfunction

" disable hunk info
let g:airline#extensions#hunks#enabled = 0

" default below
" [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#checks = [ 'indent', 'long', 'mixed-indent-file' ]

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_theme='papercolor'

" fix gitgutter for light theme
highlight SignColumn      guibg=transparent
highlight! link SignColumn LineNr

highlight GitGutterAdd    guifg=green
highlight GitGutterChange guifg=black
highlight GitGutterDelete guifg=red

let g:gitgutter_sign_removed = '−'
let g:gitgutter_sign_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '{'

highlight DiagnosticHint guifg=#2E2E2E;
