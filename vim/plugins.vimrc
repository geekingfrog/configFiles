""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" Plug 'Shougo/vimproc.vim', { 'do': 'make' }

""""" neovim 0.5 onward only
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'RRethy/nvim-treesitter-textsubjects'

Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
" Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'L3MON4D3/LuaSnip'

" Plug 'RRethy/nvim-base16'

""""" Theming and eye candy
" hack to get 'correct' colors on vim terminal
" Plug 'vim-scripts/CSApprox'
" Plug 'flazz/vim-colorschemes'
" Plug 'srcery-colors/srcery-vim'
" Plug 'Soares/base16.nvim'

" Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Show visual marker for indentation
Plug 'Yggdroot/indentLine'
" Highlight trailing whitespaces
Plug 'bronson/vim-trailing-whitespace'
" Highlight css color in the code
Plug 'ap/vim-css-color'


""""" File utilities
Plug 'jremmen/vim-ripgrep'
Plug 'danro/rename.vim'
Plug 'scrooloose/nerdtree'
Plug 'wsdjeg/vim-fetch'

""""" General utilities for code editting
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-abolish'
Plug 'michaeljsmith/vim-indent-object'
Plug 'easymotion/vim-easymotion'
" Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
" Plug 'vim-scripts/DrawIt'

" " this plugin annoyingly define mapping for <leader>swp and <leader>rwp
" " in a seemingly unrelated file (plugin/cecutil.vim). If I ever need
" " this plugin at some point, re-enable it and manually get rid of this file?
" Plug 'vim-scripts/Improved-AnsiEsc'


Plug 'lifepillar/vim-mucomplete'
Plug 'neovim/nvim-lspconfig'
Plug 'gfanto/fzf-lsp.nvim'

""""" Git utilities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

""""" Linting
Plug 'dense-analysis/ale'

""""" Fuzzy file searcher
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

""""" languages specific plugins
" markdown (github flavored)
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

Plug 'hashivim/vim-terraform', { 'for': 'terraform' }


" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

"""""""" Python """"""""
" Plug 'davidhalter/jedi-vim'
Plug 'psf/black', { 'tag': '20.8b1', 'for': 'python' }
" Plug 'puremourning/vimspector'
Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'pappasam/jedi-language-server', { 'for': 'python' }

" """""""" Haskell """"""""
" " stack install hdevtools hlint
" " hdevtools requires `ghc` and `ghc-pkg` binaries on the path
" " `stack path` will show where they are, just need to symlink them
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
" Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
" Plug 'alx741/vim-hindent', { 'for': 'haskell' }
" Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim', 'for': 'haskell' }
" Plug 'bitc/vim-hdevtools'
Plug 'vmchale/dhall-vim'

Plug 'pbrisbin/vim-syntax-shakespeare', { 'for': ['hamlet', 'julius', 'cassius', 'lucius']}

" """""""" Elm """"""""
" " Plug 'elmcast/elm-vim'
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }


" """""""" Scala """"""""
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }


""""""""" Clojure """""""""
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'luochen1990/rainbow'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'Olical/conjure', {'tag': 'v2.1.2', 'do': 'bin/compile'}

""""""""" Idris   """""""""
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }

""""""""" Idris  """"""""""
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'Shougo/vimshell.vim', { 'for': 'idris' }

""""""""" Purescript """""""""
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }

""""""""" Rust """""""""
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml'

call plug#end()
