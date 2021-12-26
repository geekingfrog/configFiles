"""""""""" GitGutter
let g:gitgutter_map_keys = 0
nmap <leader>gh <Plug>(GitGutterPreviewHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>gn <Plug>(GitGutterNextHunk)


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

"""""""" FZF
nmap <c-g> :GFiles .<CR>


"""""""""" undotree and persistent undo
nnoremap <F4> :UndotreeToggle<CR>


" """""""""" Syntastic & linting
let g:ale_lint_delay = 500  " in ms

let g:ale_linters = {
\  'haskell': ['hlint'],
\  'python': ['mypy', 'prospector'],
\  'rust': ['cargo', 'analyzer'],
\}

let g:ale_rust_cargo_check_all_targets=1
let g:ale_rust_cargo_use_clippy=executable('cargo-clippy')
" let g:ale_rust_cargo_clippy_options='--deny warnings'
let g:ale_python_mypy_options='--config-file mypy.ini'

nmap <silent> <M-k> <Plug>(ale_previous_wrap)
nmap <silent> <M-j> <Plug>(ale_next_wrap)

" Various formatting tools, when lsp cannot do that
autocmd FileType python nnoremap <buffer> <F9> :Black<CR>
autocmd FileType json nnoremap <buffer> <F9> :%!jq .<CR>

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
" let g:sexp_enable_insert_mode_mappings=0

" Taken from vim-sexp help doc
" Disable mapping hooks
let g:sexp_filetypes = ''

function! s:vim_sexp_mappings()
    xmap <silent><buffer> af              <Plug>(sexp_outer_list)
    omap <silent><buffer> af              <Plug>(sexp_outer_list)
    xmap <silent><buffer> if              <Plug>(sexp_inner_list)
    omap <silent><buffer> if              <Plug>(sexp_inner_list)
    xmap <silent><buffer> aF              <Plug>(sexp_outer_top_list)
    omap <silent><buffer> aF              <Plug>(sexp_outer_top_list)
    xmap <silent><buffer> iF              <Plug>(sexp_inner_top_list)
    omap <silent><buffer> iF              <Plug>(sexp_inner_top_list)
    xmap <silent><buffer> as              <Plug>(sexp_outer_string)
    omap <silent><buffer> as              <Plug>(sexp_outer_string)
    xmap <silent><buffer> is              <Plug>(sexp_inner_string)
    omap <silent><buffer> is              <Plug>(sexp_inner_string)
    xmap <silent><buffer> ae              <Plug>(sexp_outer_element)
    omap <silent><buffer> ae              <Plug>(sexp_outer_element)
    xmap <silent><buffer> ie              <Plug>(sexp_inner_element)
    omap <silent><buffer> ie              <Plug>(sexp_inner_element)
    nmap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
    xmap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
    omap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
    nmap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
    xmap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
    omap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
    nmap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
    xmap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
    omap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
    nmap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
    xmap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
    omap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
    nmap <silent><buffer> g<M-e>          <Plug>(sexp_move_to_prev_element_tail)
    xmap <silent><buffer> g<M-e>          <Plug>(sexp_move_to_prev_element_tail)
    omap <silent><buffer> g<M-e>          <Plug>(sexp_move_to_prev_element_tail)
    nmap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
    xmap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
    omap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
    nmap <silent><buffer> [[              <Plug>(sexp_move_to_prev_top_element)
    xmap <silent><buffer> [[              <Plug>(sexp_move_to_prev_top_element)
    omap <silent><buffer> [[              <Plug>(sexp_move_to_prev_top_element)
    nmap <silent><buffer> ]]              <Plug>(sexp_move_to_next_top_element)
    xmap <silent><buffer> ]]              <Plug>(sexp_move_to_next_top_element)
    omap <silent><buffer> ]]              <Plug>(sexp_move_to_next_top_element)
    nmap <silent><buffer> [e              <Plug>(sexp_select_prev_element)
    xmap <silent><buffer> [e              <Plug>(sexp_select_prev_element)
    omap <silent><buffer> [e              <Plug>(sexp_select_prev_element)
    nmap <silent><buffer> ]e              <Plug>(sexp_select_next_element)
    xmap <silent><buffer> ]e              <Plug>(sexp_select_next_element)
    omap <silent><buffer> ]e              <Plug>(sexp_select_next_element)
    nmap <silent><buffer> ==              <Plug>(sexp_indent)
    nmap <silent><buffer> =-              <Plug>(sexp_indent_top)
    nmap <silent><buffer> <LocalLeader>i  <Plug>(sexp_round_head_wrap_list)
    xmap <silent><buffer> <LocalLeader>i  <Plug>(sexp_round_head_wrap_list)
    nmap <silent><buffer> <LocalLeader>I  <Plug>(sexp_round_tail_wrap_list)
    xmap <silent><buffer> <LocalLeader>I  <Plug>(sexp_round_tail_wrap_list)
    nmap <silent><buffer> <LocalLeader>[  <Plug>(sexp_square_head_wrap_list)
    xmap <silent><buffer> <LocalLeader>[  <Plug>(sexp_square_head_wrap_list)
    nmap <silent><buffer> <LocalLeader>]  <Plug>(sexp_square_tail_wrap_list)
    xmap <silent><buffer> <LocalLeader>]  <Plug>(sexp_square_tail_wrap_list)
    nmap <silent><buffer> <LocalLeader>{  <Plug>(sexp_curly_head_wrap_list)
    xmap <silent><buffer> <LocalLeader>{  <Plug>(sexp_curly_head_wrap_list)
    nmap <silent><buffer> <LocalLeader>}  <Plug>(sexp_curly_tail_wrap_list)
    xmap <silent><buffer> <LocalLeader>}  <Plug>(sexp_curly_tail_wrap_list)
    nmap <silent><buffer> <LocalLeader>w  <Plug>(sexp_round_head_wrap_element)
    xmap <silent><buffer> <LocalLeader>w  <Plug>(sexp_round_head_wrap_element)
    nmap <silent><buffer> <LocalLeader>W  <Plug>(sexp_round_tail_wrap_element)
    xmap <silent><buffer> <LocalLeader>W  <Plug>(sexp_round_tail_wrap_element)
    nmap <silent><buffer> <LocalLeader>e[ <Plug>(sexp_square_head_wrap_element)
    xmap <silent><buffer> <LocalLeader>e[ <Plug>(sexp_square_head_wrap_element)
    nmap <silent><buffer> <LocalLeader>e] <Plug>(sexp_square_tail_wrap_element)
    xmap <silent><buffer> <LocalLeader>e] <Plug>(sexp_square_tail_wrap_element)
    nmap <silent><buffer> <LocalLeader>e{ <Plug>(sexp_curly_head_wrap_element)
    xmap <silent><buffer> <LocalLeader>e{ <Plug>(sexp_curly_head_wrap_element)
    nmap <silent><buffer> <LocalLeader>e} <Plug>(sexp_curly_tail_wrap_element)
    xmap <silent><buffer> <LocalLeader>e} <Plug>(sexp_curly_tail_wrap_element)
    nmap <silent><buffer> <LocalLeader>h  <Plug>(sexp_insert_at_list_head)
    nmap <silent><buffer> <LocalLeader>l  <Plug>(sexp_insert_at_list_tail)
    nmap <silent><buffer> <LocalLeader>@  <Plug>(sexp_splice_list)
    nmap <silent><buffer> <LocalLeader>o  <Plug>(sexp_raise_list)
    xmap <silent><buffer> <LocalLeader>o  <Plug>(sexp_raise_list)
    nmap <silent><buffer> <LocalLeader>O  <Plug>(sexp_raise_element)
    xmap <silent><buffer> <LocalLeader>O  <Plug>(sexp_raise_element)
    nmap <silent><buffer> <M-k>           <Plug>(sexp_swap_list_backward)
    xmap <silent><buffer> <M-k>           <Plug>(sexp_swap_list_backward)
    nmap <silent><buffer> <M-j>           <Plug>(sexp_swap_list_forward)
    xmap <silent><buffer> <M-j>           <Plug>(sexp_swap_list_forward)
    nmap <silent><buffer> <M-h>           <Plug>(sexp_swap_element_backward)
    xmap <silent><buffer> <M-h>           <Plug>(sexp_swap_element_backward)
    nmap <silent><buffer> <M-l>           <Plug>(sexp_swap_element_forward)
    xmap <silent><buffer> <M-l>           <Plug>(sexp_swap_element_forward)
    nmap <silent><buffer> <M-S-j>         <Plug>(sexp_emit_head_element)
    xmap <silent><buffer> <M-S-j>         <Plug>(sexp_emit_head_element)
    nmap <silent><buffer> <M-S-k>         <Plug>(sexp_emit_tail_element)
    xmap <silent><buffer> <M-S-k>         <Plug>(sexp_emit_tail_element)
    nmap <silent><buffer> <M-S-h>         <Plug>(sexp_capture_prev_element)
    xmap <silent><buffer> <M-S-h>         <Plug>(sexp_capture_prev_element)
    nmap <silent><buffer> <M-S-l>         <Plug>(sexp_capture_next_element)
    xmap <silent><buffer> <M-S-l>         <Plug>(sexp_capture_next_element)
    imap <silent><buffer> <BS>            <Plug>(sexp_insert_backspace)
    " imap <silent><buffer> "               <Plug>(sexp_insert_double_quote)
    imap <silent><buffer> (               <Plug>(sexp_insert_opening_round)
    imap <silent><buffer> )               <Plug>(sexp_insert_closing_round)
    imap <silent><buffer> [               <Plug>(sexp_insert_opening_square)
    imap <silent><buffer> ]               <Plug>(sexp_insert_closing_square)
    imap <silent><buffer> {               <Plug>(sexp_insert_opening_curly)
    imap <silent><buffer> }               <Plug>(sexp_insert_closing_curly)
endfunction

augroup VIM_SEXP_MAPPING
    autocmd!
    autocmd FileType clojure,scheme,lisp,timl call s:vim_sexp_mappings()
augroup END


" " conjure settings
" let g:conjure_log_direction="horizontal"
" let g:conjure_quick_doc_normal_mode=v:false
" let g:conjure_quick_doc_insert_mode=v:false

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
autocmd FileType rust setlocal shiftwidth=4 tabstop=4
autocmd FileType rust nnoremap <buffer> <silent> <F9> :RustFmt <CR>


" """""" some Easymotion mappings
" map <leader><leader>L <Plug>(easymotion-bd-jk)
" nmap <leader><leader>L <Plug>(easymotion-overwin-line)
" " modify the default because ; isn't super accessible. Check
" " the plugin's help for the actual default
" let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjfà'

"""""" vim-easy-align
xmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)


" """""" Treesitter config
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = {
"     "python",
"     "rust",
"     "json",
"     "javascript",
"     "lua",
"     "clojure",
"     "toml",
"     "bash",
"   }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     -- disable = { "c", "rust" },  -- list of language that will be disabled
"   },
" 
"   incremental_selection = {
"     enable = true,
"     -- somehow it works, but I get an error when enabled and opening a clojure
"     -- file. And annoyingly, it seems to interfere in weird ways with other
"     -- bits of the editor. For example, :GFiles will fail to open a new file
"     -- in a new tab the first time, but would work on second+ tries.
"     disable = { "clojure" },
"     keymaps = {
"       init_selecton = '<CR>',
"       scope_incremental = '<CR>',
"       node_incremental = '<TAB>',
"       node_decremental = '<S-TAB>',
"     }
"   }
" 
" }
" EOF

" """""" Treesitter text objects config
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   textobjects = {
"     select = {
"       enable = true,
"
"       -- Automatically jump forward to textobj, similar to targets.vim
"       lookahead = true,
"
"       keymaps = {
"         -- You can use the capture groups defined in textobjects.scm
"         ["af"] = "@function.outer",
"         ["if"] = "@function.inner",
"         ["ac"] = "@class.outer",
"         ["ic"] = "@class.inner",
"
"         -- Or you can define your own textobjects like this
"         ["iF"] = {
"           python = "(function_definition) @function",
"           -- cpp = "(function_definition) @function",
"           -- c = "(function_definition) @function",
"           -- java = "(method_declaration) @function",
"         },
"       },
"
"       move = {
"         enable = true,
"         set_jumps = true, -- set jumps in the jumplist
"
"         goto_next_start = {
"           ["]["] = "@function.outer",
"           ["]m"] = "@class.outer",
"         },
"         goto_next_end = {
"           ["]]"] = "@function.outer",
"           ["]M"] = "@class.outer",
"         },
"         goto_previous_start = {
"           ["[["] = "@function.outer",
"           ["[m"] = "@class.outer",
"         },
"         goto_previous_end = {
"           ["[]"] = "@function.outer",
"           ["[M"] = "@class.outer",
"         },
"       }
"     },
"   },
" }
" EOF


"""""" Hop
lua <<EOF
require'hop'.setup({

  keys = 'hklyuiopnm,qwertzxcvbasdgjfà',
  jump_on_sole_occurence = true,
  teasing = false,

})

-- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

vim.api.nvim_set_keymap('', ' j', "<cmd>lua require'hop'.hint_lines_skip_whitespace({})<cr>", {})
vim.api.nvim_set_keymap('', ' k', "<cmd>lua require'hop'.hint_lines_skip_whitespace({})<cr>", {})


EOF
