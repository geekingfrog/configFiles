" let g:jedi#popup_on_dot=0
" let g:jedi#usages_command="<leader>u"
" let g:jedi#goto_stubs_command="<leader>t"

" Check clojure-lsp to perhaps replace that
" or https://github.com/clojure-vim/async-clj-omni
autocmd FileType clojure let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Required for operations modifying multiple buffers like rename.
set hidden

" For python, install the provider: pipx install jedi-language-server
let g:LanguageClient_serverCommands = {
  \ 'haskell': [],
  \ 'python': ['jedi-language-server'],
  \ 'rust': ['rust-analyzer'],
  \ }

let g:LanguageClient_diagnosticsList = "Location"

nnoremap <F6> :call LanguageClient_contextMenu()<CR>
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

nmap <silent> <F6> <Plug>(lcn-menu)
nmap <silent> <leader>d <Plug>(lcn-definition)
nmap <silent> <leader>i <Plug>(lcn-hover)
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> <leader>t <Plug>(lcn-type-definition)
nmap <silent> <leader>r <Plug>(lcn-rename)
nmap <silent> <leader>a <Plug>(lcn-code-action)
nmap <silent> <leader>l <Plug>(lcn-code-lens-action)
nmap <silent> <leader>u <Plug>(lcn-references)
nmap <silent> <leader>e <Plug>(lcn-explain-error)
nmap <silent> <leader>p <Plug>(lcn-implementation)
nmap <silent> <leader>f <Plug>(lcn-symbols)
nnoremap <silent> <leader>F :call LanguageClient#workspace_symbol()<CR>

nmap <silent> <leader><F9> <Plug>(lcn-format)
nnoremap <silent> <leader>h :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <leader>H :call LanguageClient#clearDocumentHighlight()<CR>

set completeopt=menuone,noselect
set completefunc=mucomplete#list#completefunc
" <c-space> is simpler than <c-x><c-o> to invoke omnicompletion
inoremap <expr> <c-space> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p>'
