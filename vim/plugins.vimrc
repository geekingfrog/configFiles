""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

""""" Theming and eye candy
" hack to get 'correct' colors on vim terminal
" Plug 'vim-scripts/CSApprox'
" Plug 'flazz/vim-colorschemes'
Plug 'srcery-colors/srcery-vim'

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Show visual marker for indentation
Plug 'Yggdroot/indentLine'
" Highlight trailing whitespaces
Plug 'bronson/vim-trailing-whitespace'
" Highlight css color in the code
Plug 'ap/vim-css-color'


""""" File utilities
" Plug 'mileszs/ack.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'danro/rename.vim'
Plug 'scrooloose/nerdtree'

""""" General utilities for code editting
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/Improved-AnsiEsc'
Plug 'wesQ3/vim-windowswap'
Plug 'vim-scripts/DrawIt'

" " completion
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" See :h NCM-install for some requirements (python3 and some python modules
" for some features)
" Plug 'roxma/nvim-completion-manager'
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp' " required by ncm2
Plug 'ervandew/supertab'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

""""" Git utilities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fubitive'
Plug 'airblade/vim-gitgutter'

""""" Linting
Plug 'w0rp/ale'


""""" Fuzzy file searcher
" Plug 'ctrlpvim/ctrlp.vim'
Plug '~/dev/go/fzf/bin/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

""""" languages specific plugins
" markdown (github flavored)
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

Plug 'hashivim/vim-terraform', { 'for': 'terraform' }


" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'flowtype/vim-flow', { 'for': 'javascript' }


"""""""" Python """"""""
" Plug 'klen/python-mode'
" NeoBundle 'https://github.com/vim-scripts/vim-django.vim'
Plug 'vim-scripts/django.vim', { 'for': 'python' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }


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

Plug 'pbrisbin/vim-syntax-shakespeare', { 'for': ['hamlet', 'julius', 'cassius', 'lucius']}

" """""""" Elm """"""""
" " Plug 'elmcast/elm-vim'
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }


" """""""" Scala """"""""
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }


""""""""" Clojure """""""""
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'Olical/conjure', {'tag': 'v2.1.2', 'do': 'bin/compile'}

""""""""" Idris   """""""""
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }

""""""""" Idris  """"""""""
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'Shougo/vimshell.vim', { 'for': 'idris' }

""""""""" Go   """""""""
Plug 'fatih/vim-go' , { 'do': ':GoUpdateBinaries'}

""""""""" Purescript """""""""
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }

""""""""" Rust """""""""
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

""""""""" Fish (shell) """""""""
Plug 'dag/vim-fish'

call plug#end()
