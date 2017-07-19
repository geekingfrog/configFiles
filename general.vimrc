""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global vim settings for generic text editting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" per project .vimrc
set exrc

" remap leaderkey to ,
let mapleader = ","
let localleader = ","

" copy to and from system clipboard
set clipboard+=unnamedplus

"disable creation of .swp files
set noswapfile

"set the terminal title
set title

"Display line number on the left
set number

"showmatch: Show the matching bracket for the last ')'?
set showmatch

" show some 'invisible' characters (:h listchars)
set list

" treat numerals as decimal instead of octals (practical vim tip11)
set nrformats=

"causes left and right arrow to change line when reaching the end/beginning
"< and > for normal mode, [ and ] for insert mode
set whichwrap+=<,>,h,l,[,]

"remember modified buffer when opening a new one with unsaved modif in the current buffer
set hidden

"set indentation to 2 spaces
set shiftwidth=2
set smartindent

"replace <tab> by spaces
set expandtab
set tabstop=2

"clear higlight search when opening a file
autocmd BufNewFile,BufReadPost *  let @/ = ""

" open all folds when opening a file
set foldlevelstart=99
set foldmethod=indent

"search is case insensitive. If the search pattern contains
"upper case letter, then it's case sensitive
set ignorecase
set smartcase

" more natural splits
set splitbelow
set splitright

" Don't update the display while executing macros
set lazyredraw

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 2 lines from the top and 2
" lines from the bottom
set scrolloff=2

" persistent undo/redo history
set undofile
silent !mkdir -p ~/.vim/undodir
set undodir=~/.vim/undodir

" mouse scrolling in vim in tmux
" https://superuser.com/questions/610114/tmux-enable-mouse-scrolling-in-vim-instead-of-history-buffer
set mouse=a

" don't automatically fold json files
autocmd FileType json setlocal conceallevel=0
