let g:deoplete#enable_at_startup = 0

" do not automatically show completion window
let g:deoplete#disable_auto_complete = 1
" inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#manual_complete()

" let g:deoplete#keyword_patterns = {}
" let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabDefaultCompletionType = "context"
set completeopt=longest,menuone

" deoplete tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" flowtype for js
autocmd FileType javascript nnoremap <leader>t :call flow#get_type()<CR>

" completion for haskell
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
autocmd FileType haskell.hspec setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell.hspec let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1
" Resolve ghcmod base directory
au FileType haskell let g:ghcmod_use_basedir = getcwd()

nnoremap <silent> <leader>hh :Hoogle<CR>

autocmd FileType clojure let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

autocmd FileType rust let g:racer_cmd = "/home/greg/.cargo/bin/racer"
autocmd FileType rust let g:racer_experimental_completer = 1
