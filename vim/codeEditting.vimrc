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
\}

" let g:ale_linters = {'python': ['mypy', 'prospector']}
" let g:ale_linters = {'haskell': ['hlint']}

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
autocmd FileType rust setlocal shiftwidth=4 tabstop=4
autocmd FileType rust nnoremap <buffer> <silent> <F9> :RustFmt <CR>


"""""" some Easymotion mappings
map <leader><leader>L <Plug>(easymotion-bd-jk)
nmap <leader><leader>L <Plug>(easymotion-overwin-line)
" modify the default because ; isn't super accessible. Check
" the plugin's help for the actual default
let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjfà'

"""""" vim-easy-motion
xmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)


"""""" Treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "python",
    "rust",
    "json",
    "javascript",
    "lua",
    "clojure",
    "toml",
    "bash",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

"""""" Treesitter text objects config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          -- cpp = "(function_definition) @function",
          -- c = "(function_definition) @function",
          -- java = "(method_declaration) @function",
        },
      },

      move = {
        enable = true,
        set_jumps = true, -- set jumps in the jumplist

        goto_next_start = {
          ["]["] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]]"] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      }
    },
  },
}
EOF

lua<<EOF
require'nvim-treesitter.configs'.setup {
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            ['à'] = 'textsubjects-container-outer',
        }
    },
}
EOF


" """""" Snippets

" imap <silent><expr> <C-C> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''
" inoremap <silent> <C-T> <cmd>lua require'luasnip'.jump(-1)<Cr>
"
" " imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" " inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
"
" snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
" snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
"
" imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
" smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
"
" lua<<EOF
" local ls = require("luasnip")
" -- some shorthands...
" local s = ls.snippet
" local sn = ls.snippet_node
" local t = ls.text_node
" local i = ls.insert_node
" local f = ls.function_node
" local c = ls.choice_node
" local d = ls.dynamic_node
" local l = require("luasnip.extras").lambda
" local r = require("luasnip.util.functions").rep
" local p = require("luasnip.util.functions").partial
"
" -- args is a table, where 1 is the text in Placeholder 1, 2 the text in
" -- placeholder 2,...
" local function copy(args)
"   return args[1]
" end
"
" ls.snippets = {
"   all = {
"     s("fn", {
"       -- Simple static text.
"       t("//Parameters: "),
"       -- function, first parameter is the function, second the Placeholders
"       -- whose text it gets as input.
"       f(copy, 2),
"       t({ "", "function " }),
"       -- Placeholder/Insert.
"       i(1),
"       t("("),
"       -- Placeholder with initial text.
"       i(2, "int foo"),
"       -- Linebreak
"       t({ ") {", "\t" }),
"       -- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
"       i(0),
"       t({ "", "}" }),
"     }),
"   }
" }
"
" EOF
