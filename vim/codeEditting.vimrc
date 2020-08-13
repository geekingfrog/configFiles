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
nmap <c-g> :GFiles .<CR>
nmap <leader><b> :Buffers<CR>


"""""""""" undotree and persistent undo
nnoremap <F4> :UndotreeToggle<CR>


" """""""""" Syntastic & linting
let g:ale_lint_delay = 500  " in ms

let g:ale_linters = {
\  'haskell': ['hlint'],
\  'python': ['mypy', 'prospector'],
\}

" let g:ale_linters = {'python': ['mypy', 'prospector']}
" let g:ale_linters = {'haskell': ['hlint']}

" let g:ale_python_mypy_options='--strict'
let g:ale_python_mypy_options='--config-file mypy.ini'

nmap <silent> <M-k> <Plug>(ale_previous_wrap)
nmap <silent> <M-j> <Plug>(ale_next_wrap)

augroup pythonMaps
  autocmd FileType python nnoremap <buffer> <F9> :Black<CR>
augroup END

autocmd FileType json nnoremap <buffer> <F9> :%!jq .<CR>

" \  'haskell': ['hdevtools', 'hlint', 'stack-build', 'stack-ghc', 'stack-ghc-mod']

function! FormatOrmolu()
  mark `
  :%!ormolu
  normal ``
endfunction

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

  autocmd FileType haskell nnoremap <F9> :call FormatOrmolu() <CR>

augroup END

" https://gist.github.com/kcsongor/b6b503c7338c64162d5c85199229e3a2#file-haskell-vim-L174
function! AddLanguagePragma()
  let line = max([0, search('^{-# LANGUAGE', 'n') - 1])

  :call fzf#run({
  \ 'source': 'stack ghc -- --supported-languages',
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

" conjure settings
let g:conjure_log_direction="horizontal"
let g:conjure_quick_doc_normal_mode=v:false
let g:conjure_quick_doc_insert_mode=v:false

"""""" NerdTree
map <F2> :NERDTreeToggle<CR>


"""""" Terraform
" to play nice with vim-commentary
autocmd FileType terraform setlocal commentstring=#%s

"""""" Bazel
autocmd BufRead *.bazel set ft=bzl


"""""" Python

" to work even in virtualenv without the pynvim package
let g:python3_host_prog="/usr/bin/python"

" Neovim doesn't recognize shift-Fn or ctrl-Fn, instead, it recognize
" respectively F(n+12) and F(n+24)
" So to map shift-F9 for example, map F21
" https://github.com/neovim/neovim/issues/7384

" This remap vimspector HUMAN mappings, adding shift before every F key
" to avoid collision with existing shift mappings (I have a few)

" F15 = S-F3
" F17 = S-F5
nmap <F17>         <Plug>VimspectorContinue
nmap <F15>         <Plug>VimspectorStop
nmap <F16>         <Plug>VimspectorRestart
nmap <F18>         <Plug>VimspectorPause
nmap <F21>         <Plug>VimspectorToggleBreakpoint
nmap <leader><F9>  <Plug>VimspectorToggleConditionalBreakpoint
nmap <F20>         <Plug>VimspectorAddFunctionBreakpoint
nmap <F22>         <Plug>VimspectorStepOver
nmap <F23>         <Plug>VimspectorStepInto
nmap <F24>         <Plug>VimspectorStepOut


"""""" Rust
function! FormatRustfmt()
  mark `
  :%!rustfmt
  normal ``
endfunction

autocmd FileType rust nnoremap <buffer> <F9> :call FormatRustfmt() <CR>
