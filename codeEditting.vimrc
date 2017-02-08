"""""""""" Tagbar
nnoremap <F8> :TagbarToggle<CR>

"""""""""" GitGutter
let g:gitgutter_map_keys = 0

"""""""""" IndentLine
let g:indentLine_conceallevel = 0


"""""""" Fugitive
" Delete hidden buffer opened by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

"""""""" CtrlP
" ignore files that git ignores
" from https://github.com/kien/ctrlp.vim/issues/273
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '.git\|node_modules\|git\|venv\|.pyc\|dist/\|target/'
" nnoremap <leader>p :CtrlP .<cr>
nnoremap <c-p> :CtrlP .<cr>
" nnoremap <leader>b :CtrlPBuffer <cr>
" :h ctrlp-options
let g:ctrlp_root_markers = ['.git, .svn']
let g:ctrlp_match_window = 0
let g:ctrl_switch_buffer = 0

"""""""""" undotree and persistent undo
nnoremap <F4> :UndotreeToggle<CR>


"""""""""" Syntastic & linting
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_flake8_exe = 'python3 -m flake8'
" need msg_id for pylint, too much hassle to find details otherwise
let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'
let g:syntastic_aggregate_errors = 1

let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:syntastic_haskell_checkers = ['hlint']
" disable java checkers, nothing is setup and if maven is present it hangs for
" a while before error
let g:syntastic_java_checkers = []
let g:syntastic_idris_checkers = ['idris']

"""""" Haskell stuff
" Type of expression under cursor
autocmd FileType haskell nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
autocmd FileType haskell nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
autocmd FileType haskell nmap <silent> <leader>hc :Neomake ghcmod<CR>
" Clear ghc-mod highlight
autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>

autocmd FileType haskell setlocal shiftwidth=4 tabstop=4
autocmd FileType haskell.hspec setlocal shiftwidth=4 tabstop=4
let g:haskell_indent_disable = 1

let g:hindent_on_save = 0
let g:hindent_indent_size = 4
autocmd FileType haskell setlocal equalprg=hindent

autocmd FileType json setlocal conceallevel=0

"""""" Clojure
let vimclojure#WantNailgun = 0


"""""" NerdTree
map <F2> :NERDTreeToggle<CR>
