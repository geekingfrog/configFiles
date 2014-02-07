" to get vundle: git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible               " be iMproved
filetype off                   " required!

" Setting up Vundle - the vim plugin bundler (inspired from github's fisadev/fisa-vim-config)
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My bundles below
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" front-end plugins, coffeescript, less and jst (ejs) templates
Bundle 'kchmck/vim-coffee-script'
Bundle 'nono/vim-handlebars'
Bundle 'groenewege/vim-less'
Bundle 'briancollins/vim-jst'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'elzr/vim-json'
Bundle 'tomtom/tcomment_vim'
Bundle 'git://github.com/scrooloose/nerdtree'
Bundle 'git://github.com/rbgrouleff/bclose.vim'
" Bundle 'scrooloose/syntastic'

Bundle 'vim-scripts/UltiSnips'
Bundle 'honza/vim-snippets'
" my snippets
Bundle 'geekingfrog/configFiles'


"Tim Pope is the man !
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-abolish'

Bundle 'gregsexton/gitv'

" make vim puppet frindly
Bundle 'rodjek/vim-puppet'
" align characters to create tables (used by vim-puppet)
Bundle 'godlygeek/tabular'

" fuzzy finder, best plugin for file ever !
Bundle 'git://github.com/kien/ctrlp.vim'

" a bazillion of colorscheme
Bundle 'flazz/vim-colorschemes'

" hack to get 'correct' colors on vim terminal
Bundle 'vim-scripts/CSApprox'

Bundle 'Lokaltog/vim-easymotion'

" guide for indentation
Bundle 'Yggdroot/indentLine'

" Highlight trailing whitespaces
Bundle 'bronson/vim-trailing-whitespace'

"fancy status line
Bundle 'Lokaltog/powerline'


set t_Co=256
syntax on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

Bundle 'vim-scripts/AnsiEsc.vim'

Bundle 'danro/rename.vim'
" Bundle 'plasticboy/vim-markdown'

" github flavored markdown
Bundle 'tpope/vim-markdown'
Bundle 'jtratner/vim-flavored-markdown'

" see css colors
Bundle 'ap/vim-css-color'

" lorem ipsum generator
Bundle 'vim-scripts/loremipsum'

" Installing plugins the first time
if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif

filetype plugin indent on     " required! (vundle)

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" personal vimrc config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

" per project .vimrc
set exrc

" w is far far away on a bépo layout
noremap è w
noremap È W
noremap <c-è> <c-w>
noremap <c-È> <c-W>


"""""""" CSApprox plugin
" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
"set t_Co=88
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
colorscheme darkocean
" colorscheme corporation

" Avoid the escape key
:imap jj <Esc>
:imap ,, <Esc>

"remap the leaderkey to ,
:let mapleader = ","

" let be serious !
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
map <C-up> <nop>
map <C-down> <nop>
map <C-left> <nop>
map <C-right> <nop>
imap <C-up> <nop>
imap <C-down> <nop>
imap <C-left> <nop>
imap <C-right> <nop>

" j and k as line wise movement
nnoremap <silent> j gj
nnoremap <silent> k gk


"copy from system clipboard with p
"yank and allow to paste from system clipboard in other application
set clipboard=unnamedplus

"disable creation of .swp files
set noswapfile

"set the terminal title
set title

"Display line number on the left
set number

"in an xterm, allow the use of the mouse
set mouse=a

"showmatch: Show the matching bracket for the last ')'?
set showmatch

" treat numerals as decimal instead of octals (practical vim tip11)
set nrformats=

"causes left and right arrow to change line when reaching the end/beginning
"< and > for normal mode, [ and ] for insert mode
set whichwrap+=<,>,[,]

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saved restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,n~/.viminfo

" Get back to last position.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"remember modified buffer when opening a new one with unsaved modif in the current buffer
set hidden



"set indentation to 2 spaces
set shiftwidth=2
set smartindent

"replace <tab> by spaces
set expandtab
set tabstop=2


"always paste with respect to indentation
nnoremap p ]p

"highlight search results
set hlsearch

"to clear highlight search
nnoremap <F5> :let @/ = ""<CR>

"clear higlight search when opening a file
"the last search is remembered in viminfo
"and I didn't find a way to disable that
autocmd BufNewFile,BufReadPost *  let @/ = ""

"quick save shortcut with <leader>s
"If the current buffer has never been saved, it will have no name,
"call the file browser to save it, otherwise just save it.
noremap <leader>s :update<cr>
inoremap <leader>s <esc>:update<cr>
nnoremap <leader>q :q<cr>

"select all the document, less keystroke
nnoremap <leader>a ggVG

"indent folding with manual folds
" augroup vimrc
"   au BufReadPre * setlocal foldmethod=indent
"   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END
set foldmethod=indent

" open all folds when opening a file
set foldlevelstart=20

"search is case insensitive. If the search pattern contains
"upper case letter, then it's case sensitive
set ignorecase
set smartcase

" no more W is not a command !
nnoremap :W :w
nnoremap :Q :q

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" different color for the 90th column
if exists("&colorcolumn")
  highlight ColorColumn ctermbg=grey guibg=orange
  call matchadd('ColorColumn', '\%81v', 100)
  " let &colorcolumn=join(range(90, 90),",")
  " highlight ColorColumn ctermbg=235 guibg=#2c2d27
endif

" page up and down more accessible
noremap <BS> <C-B>
noremap <Space> <C-F>
noremap <enter> zz

" Buffer and splits
nnoremap <F3> :bp<cr>
nnoremap <F4> :bn<cr>

" more natural splits
set splitbelow
set splitright

" move between splits
map <C-h> <c-w>h
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-l> <c-w>l

" usefull stuff found here: http://vimbits.com/bits
" Make Y behave like other capitals
map Y y$


" automatically reload vimrc when it's saved
" au BufWritePost .vimrc so ~/.vimrc


"""""""" the following is inspired by Derek Wyatt vimrc
" https://github.com/derekwyatt/vim-config/blob/master/vimrc

" set the search scan to wrap lines
set wrapscan

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>ov :so $MYVIMRC<CR>

" Don't update the display while executing macros
set lazyredraw

" Show the current mode
set showmode

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 2 lines from the top and 2
" lines from the bottom
set scrolloff=2


" Allow the cursor to go in to "invalid" places
" set virtualedit=all

" Make the command-line completion better
set wildmenu

" Wipe out all buffers
nmap <silent> ,wa :1,9000bwipeout<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""" Markdown
" augroup markdown
"     au!
"     au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
" augroup END
au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown

"""""""" NERDTree
" map F2 to toggle NERDTree
map <F2> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"Correct a display bug
let g:NERDTreeDirArrows=0


"""""""" coffeescript
noremap <leader>cm :w <bar> CoffeeMake<CR>
inoremap <leader>cm <esc>:w <bar> CoffeeMake<CR>

"map <F7> to save and compile the file in bare mode
nmap <F7> :w <bar> CoffeeMake -b<CR>
imap <F7> <c-o>:w <bar> CoffeeMake -b<CR>

"""""""" BClose
nnoremap <F12> :Bclose<cr>


"""""""" CtrlP
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.svg,*.eot,*.jar
let g:ctrlp_custom_ignore = 'node_modules\|git\|target\|bin\/src'
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_map = '<leader>p'
noremap <leader>p :CtrlP .<cr>
noremap <c-p> :CtrlP .<cr>
let g:ctrlp_root_markers = ['.git, .svn']

"""""""""" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-snippets/UltiSnips"]
let g:UltiSnipsSnippetDirectories=["bundle/vim-snippets/UltiSnips", "bundle/configFiles/frogSnippets"]

"""""""""" JSHint
" shortcut to toggle the highlight of error'd lines
" func! ToggleJSHintHighlight()
"   if g:JSHintHighlightErrorLine == 0
"     let g:JSHintHighlightErrorLine = 1
"   else
"     let g:JSHintHighlightErrorLine = 0
"   endif
"   return
" endfunc
"
" nnoremap <F6> :call ToggleJSHintHighlight()<CR>
