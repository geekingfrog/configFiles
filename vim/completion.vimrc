" Dont't show completion menu automatically (ncm)
let g:cm_auto_popup = 0
" trigger completion on <c-space>
imap <C-Space> <Plug>(cm_force_refresh)
set shortmess+=c

" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
" let g:SuperTabDefaultCompletionType = "context"
set completeopt=longest,menuone

nnoremap <silent> <leader>hh :Hoogle<CR>

" Check clojure-lsp to perhaps replace that
" or https://github.com/clojure-vim/async-clj-omni
autocmd FileType clojure let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

autocmd FileType rust let g:racer_cmd = "/home/greg/.cargo/bin/racer"
autocmd FileType rust let g:racer_experimental_completer = 1


" For haskell: requires hie on the path: https://github.com/haskell/haskell-ide-engine
" `stack install` from the git repo
" \ 'haskell': ['hie', '--lsp'],
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls']
    \ }

" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>


" " deoplete options
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
"
" " disable autocomplete by default
" let b:deoplete_disable_auto_complete=1
" let g:deoplete_disable_auto_complete=1
" call deoplete#custom#buffer_option('auto_complete', v:false)
"
" if !exists('g:deoplete#omni#input_patterns')
"     let g:deoplete#omni#input_patterns = {}
" endif
"
" inoremap <expr> <C-n> deoplete#mappings#manual_complete()
"
" " Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])
"
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"
" " set sources
" let g:deoplete#sources = {}
" let g:deoplete#sources.vim = ['vim']
" let g:deoplete#sources.haskell = ['LanguageClient']
" let g:deoplete#sources.python = ['LanguageClient']
" let g:deoplete#sources.python3 = ['LanguageClient']
" let g:deoplete#sources.rust = ['LanguageClient']
