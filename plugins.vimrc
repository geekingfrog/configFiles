""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

""""" Theming and eye candy
" hack to get 'correct' colors on vim terminal
" Plug 'vim-scripts/CSApprox'
Plug 'flazz/vim-colorschemes'
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
Plug 'mileszs/ack.vim'
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

" completion
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'roxma/nvim-completion-manager'
Plug 'ervandew/supertab'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

""""" Git utilities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

""""" Linting
Plug 'w0rp/ale'


""""" Fuzzy file searcher
Plug 'ctrlpvim/ctrlp.vim'

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
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim', 'for': 'haskell' }

Plug 'pbrisbin/vim-syntax-shakespeare', { 'for': ['hamlet', 'julius', 'cassius', 'lucius']}

" """""""" Elm """"""""
" " Plug 'elmcast/elm-vim'
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }


" """""""" Scala """"""""
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }


""""""""" Clojure """""""""
" To have the interactive part of vimClojure, install Nailgun, see some tuto
" below:
" http://naleid.com/blog/2011/12/19/getting-a-clojure-repl-in-vim-with-vimclojure-nailgun-and-leiningen/
" Plug 'vim-scripts/VimClojure', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'venantius/vim-eastwood', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }


""""""""" Idris   """""""""
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }

""""""""" Idris  """"""""""
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'Shougo/vimshell.vim', { 'for': 'idris' }

""""""""" Go   """""""""
Plug 'fatih/vim-go' , { 'for': 'go' }

""""""""" Purescript """""""""
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }

""""""""" Rust """""""""
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

call plug#end()
