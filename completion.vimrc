" Dont't show completion menu automatically
let g:cm_auto_popup = 0
imap <C-Space> <Plug>(cm_force_refresh)

" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabDefaultCompletionType = "context"
set completeopt=longest,menuone

nnoremap <silent> <leader>hh :Hoogle<CR>

" Check clojure-lsp to perhaps replace that
" or https://github.com/clojure-vim/async-clj-omni
autocmd FileType clojure let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

autocmd FileType rust let g:racer_cmd = "/home/greg/.cargo/bin/racer"
autocmd FileType rust let g:racer_experimental_completer = 1


" For haskell: requires hie on the path: https://github.com/haskell/haskell-ide-engine
" `stack install` from the git repo
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ }
