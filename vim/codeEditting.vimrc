"""""""""" Tagbar
nnoremap <F8> :TagbarToggle<CR>

"""""""""" GitGutter
let g:gitgutter_map_keys = 0

"""""""""" IndentLine
let g:indentLine_conceallevel = 0


"""""""" Ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


"""""""" Fugitive
" Delete hidden buffer opened by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" rhubarb, for github enterprise setup
let g:github_enterprise_urls = ['https://github.cldsvcs.com']

" """""""" CtrlP
" " ignore files that git ignores
" " from https://github.com/kien/ctrlp.vim/issues/273
" " let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_working_path_mode = 'ra'
" " temporarily? disable the custom ignore, it seems to be messed up on go projects
" let g:ctrlp_custom_ignore = 'node_modules\|git\|venv\|.pyc\|dist/\|target\|bower_components'
" let g:ctrlp_map = '<c-space>'
"
" " :h ctrlp-options
" let g:ctrlp_root_markers = ['.git, .svn']
" let g:ctrlp_match_window = 0
" let g:ctrl_switch_buffer = 0
" nmap <leader>b :CtrlPBuffer<CR>


"""""""" FZF
nmap <c-space> :GFiles .<CR>
nmap <leader><b> :Buffers<CR>


"""""""""" undotree and persistent undo
nnoremap <F4> :UndotreeToggle<CR>


" """""""""" Syntastic & linting
let g:ale_lint_delay = 500  " in ms

let g:ale_linters = {
\  'haskell': ['hlint']
\}

" \  'haskell': ['hdevtools', 'hlint', 'stack-build', 'stack-ghc', 'stack-ghc-mod']

" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_python_python_exec = '/usr/local/bin/python3'
" let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_python_flake8_exe = 'python3 -m flake8'
" " need msg_id for pylint, too much hassle to find details otherwise
" let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'
" let g:syntastic_aggregate_errors = 1
"
" let g:syntastic_javascript_checkers = ['jshint', 'jscs']
" let g:syntastic_haskell_checkers = ['hlint']
" " disable java checkers, nothing is setup and if maven is present it hangs for
" " a while before error
" let g:syntastic_java_checkers = []
" let g:syntastic_idris_checkers = ['idris']



"""""" Haskell stuff
augroup haskellMaps
  " " Type of expression under cursor
  " autocmd FileType haskell nmap <silent> <leader>ht :GhcModType<CR>
  " " Insert type of expression under cursor
  " autocmd FileType haskell nmap <silent> <leader>hT :GhcModTypeInsert<CR>
  " " GHC errors and warnings
  " autocmd FileType haskell nmap <silent> <leader>hc :Neomake ghcmod<CR>
  " " Clear ghc-mod highlight
  " autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>

  autocmd FileType haskell setlocal shiftwidth=2 tabstop=2
  autocmd FileType haskell let g:haskell_indent_disable=1

  autocmd FileType haskell let g:hindent_on_save=0
  autocmd FileType haskell let g:hindent_indent_size=2
  autocmd FileType haskell setlocal equalprg=brittany
  autocmd FileType haskell let g:hamlet_prevent_invalid_nesting=0

  " autocmd FileType haskell nmap <silent> gd :call LanguageClient_textDocument_hover()

  autocmd FileType haskell nmap <silent> <leader>ht :HdevtoolsType<CR>
  autocmd FileType haskell nmap <silent> <leader>hc :HdevtoolsClear<CR>

augroup END

" https://gist.github.com/kcsongor/b6b503c7338c64162d5c85199229e3a2#file-haskell-vim-L174
function! AddLanguagePragma()
  let line = max([0, search('^{-# LANGUAGE', 'n') - 1])

  :call fzf#run({
  \ 'source': 'ghc --supported-languages',
  \ 'sink': {lp -> append(line, "{-# LANGUAGE " . lp . " #-}")},
  \ 'options': '--multi --ansi --reverse --prompt "LANGUAGE> "
               \ --color fg:245,bg:233,hl:255,fg+:15,bg+:235,hl+:255
               \ --color info:250,prompt:255,spinner:108,pointer:35,marker:35',
  \ 'down': '25%'})
endfunction

"""""" Clojure
" no special indentation following these forms
autocmd FileType clojure let &lispwords .= ',GET,POST,fact,facts'
autocmd FileType clojure RainbowParentheses
" vim-sexp uses localleader for a bunch of things
autocmd FileType clojure let localleader = "\\"


"""""" NerdTree
map <F2> :NERDTreeToggle<CR>


"""""" Terraform
" to play nice with vim-commentary
autocmd FileType terraform setlocal commentstring=#%s

"""""" Bazel
autocmd BufRead *.bazel set ft=bzl
