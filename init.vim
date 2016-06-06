""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" Code editing goodness
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/loremipsum'

Plug 'SirVer/UltiSnips'
Plug 'honza/vim-snippets'


" Git related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Tags and navigation
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'  " required by easytags
Plug 'xolox/vim-easytags'
Plug 'ctrlpvim/ctrlp.vim'

" Visual
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
Plug 'ap/vim-css-color'


" FS utils

" This requires ag to be installed
Plug 'rking/ag.vim'
Plug 'danro/rename.vim'


" Syntax and language specific things
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

"github flavored markdown
Plug 'tpope/vim-markdown'

"""""""" Python """"""""
Plug 'klen/python-mode'
" NeoBundle 'https://github.com/vim-scripts/vim-django.vim'
Plug 'vim-scripts/django.vim'


"""""""" Haskell """"""""
" stack install hdevtools hlint
" hdevtools requires `ghc` and `ghc-pkg` binaries on the path
" `stack path` will show where they are, just need to symlink them
Plug 'eagletmt/neco-ghc'
Plug 'bitc/vim-hdevtools'

"""""""" Elm """"""""
" Plug 'elmcast/elm-vim'
Plug 'lambdatoast/elm.vim'


call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal nvim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" per project .vimrc
set exrc

" remap leaderkey to ,
let mapleader = ","

" copy to and from system clipboard
set clipboard+=unnamedplus

" w is far far away on a bépo layout
noremap è w
noremap È W
noremap <c-è> <c-w>
noremap <c-È> <c-W>

" Avoid the escape key
imap jj <Esc>
imap qq <Esc>

" j and k as line wise movement
nnoremap <silent> j gj
nnoremap <silent> k gk

" jumping to tag is better
nnoremap gD <C-]>

" quick save shortcut with <leader>s
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
noremap <leader>s :update<cr>
inoremap <leader>s <esc>:update<cr>
nnoremap <leader>q :q<cr>

"disable creation of .swp files
set noswapfile

"set the terminal title
set title

"Display line number on the left
set number

"showmatch: Show the matching bracket for the last ')'?
set showmatch

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

"to clear highlight search
nnoremap <F5> :let @/ = ""<CR>

"clear higlight search when opening a file
autocmd BufNewFile,BufReadPost *  let @/ = ""

" open all folds when opening a file
set foldlevelstart=99
set foldmethod=indent

"search is case insensitive. If the search pattern contains
"upper case letter, then it's case sensitive
set ignorecase
set smartcase

" no more W is not a command !
nnoremap :W :w
nnoremap :Q :q

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" " different color for the 90th column
" if exists("&colorcolumn")
"   highlight ColorColumn ctermbg=grey guibg=orange
"   call matchadd('ColorColumn', '\%81v', 90)
"   " let &colorcolumn=join(range(90, 90),",")
"   " highlight ColorColumn ctermbg=235 guibg=#2c2d27
" endif

set textwidth=80
set cc=+1  " highlight column after 'textwidth'

" page up and down more accessible
noremap <BS> <C-B>
noremap <Space> <C-F>

" more natural splits
set splitbelow
set splitright

" easier move between splits
" See https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
" if c-h (and only this one) doesn't work
map <C-h> <c-w>h
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-l> <c-w>l

" usefull stuff found here: http://vimbits.com/bits
" Make Y behave like other capitals
map Y y$

" Edit the init.vim config file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>ov :so $MYVIMRC<CR>

" Don't update the display while executing macros
set lazyredraw

" " Show the current mode
" set showmode

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 2 lines from the top and 2
" lines from the bottom
set scrolloff=2

" Read gzip files without unzipping
" See :h gzip-example
augroup gzip
 autocmd!
 autocmd BufReadPre,FileReadPre *.gz set bin
 autocmd BufReadPost,FileReadPost   *.gz '[,']!gunzip
 autocmd BufReadPost,FileReadPost   *.gz set nobin
 autocmd BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
 autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
 autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r
 autocmd FileAppendPre      *.gz !gunzip <afile>
 autocmd FileAppendPre      *.gz !mv <afile>:r <afile>
 autocmd FileAppendPost     *.gz !mv <afile> <afile>:r
 autocmd FileAppendPost     *.gz !gzip <afile>:r
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""" Tagbar
nnoremap <F8> :TagbarToggle<CR>

"""""""" Fugitive
" Delete hidden buffer opened by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

"""""""" CSApprox and colorschemes
" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
"set t_Co=88
" let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
" colorscheme corporation
" colorscheme railscasts
" colorscheme inkpot
" silent! colorscheme luna
colorscheme molokai

"""""""" CtrlP
" ignore files that git ignores
" from https://github.com/kien/ctrlp.vim/issues/273
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '.git\|node_modules\|git\|venv\|.pyc\|dist/'
" let g:ctrlp_map = '<leader>p'
nnoremap <leader>p :CtrlP .<cr>
nnoremap <c-p> :CtrlP .<cr>
" nnoremap <leader>b :CtrlPBuffer <cr>
" :h ctrlp-options
let g:ctrlp_root_markers = ['.git, .svn']
let g:ctrlp_match_window = 0
let g:ctrl_switch_buffer = 0

"""""""" CtrlP
" :au BufWritePost *.elm ElmMakeCurrentFile
nnoremap <leader>el :ElmEvalLine<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>


"""""""""" undotree and persistent undo
set undofile
silent !mkdir -p ~/.vim/undodir
set undodir=~/.vim/undodir
nnoremap <F4> :UndotreeToggle<CR>


"""""""""" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_python_pyflakes_exe = 'python3 ~/.local/bin/pyflakes'
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
" let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_flake8_exe = 'python3 -m flake8'
let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'
let g:syntastic_aggregate_errors = 1

let g:syntastic_javascript_checkers = ['eslint']
