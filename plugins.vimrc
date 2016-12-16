""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'neomake/neomake'

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
" This requires ag to be installed
Plug 'rking/ag.vim'
Plug 'danro/rename.vim'


""""" General utilities for code editting
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'


" completion
" requires python3 (`:echo has(`python3')' should return 1) and the python
" package to interface with neovim (pip install --user neovim)
Plug 'Shougo/deoplete.nvim'
Plug 'ervandew/supertab'
" Plug 'Valloric/YouCompleteMe'


""""" Git utilities
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

""""" Linting
Plug 'scrooloose/syntastic'


""""" Tags and navigation
" Plug 'xolox/vim-misc'  " required by easytags
" Plug 'xolox/vim-easytags'
Plug 'ctrlpvim/ctrlp.vim'


""""" languages specific plugins
" markdown (github flavored)
Plug 'tpope/vim-markdown'


" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'


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
" Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
Plug 'alx741/vim-hindent', { 'for': 'haskell' }

"
" """""""" Elm """"""""
" " Plug 'elmcast/elm-vim'
" Plug 'lambdatoast/elm.vim'


" """""""" Scala """"""""
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }


""""""""" Clojure """""""""
Plug 'vim-scripts/VimClojure', { 'for': 'clojure' }

call plug#end()
