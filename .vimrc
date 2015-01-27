set nocompatible
filetype off

" Inspired from https://github.com/tony/vim-config/blob/master/bundles.vim
" If NeoBundle is not installed, pull it from github.
" Inspired from github's fisadev/fisa-vim-config
let iCanHazNeoBundle=1
let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  let iCanHazNeoBundle=0
endif

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  " Required:
  set runtimepath+=/home/greg/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/greg/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'groenewege/vim-less'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'git://github.com/scrooloose/nerdtree'
NeoBundle 'git://github.com/rbgrouleff/bclose.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'vim-scripts/JavaScript-Indent'
NeoBundle "pangloss/vim-javascript"
NeoBundle "mxw/vim-jsx"

NeoBundle 'digitaltoad/vim-jade'

" Some snippets
NeoBundle 'vim-scripts/UltiSnips'
NeoBundle 'honza/vim-snippets'

"Tim Pope is the man !
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-jdaddy'

NeoBundle 'gregsexton/gitv'

" align characters to create tables
NeoBundle 'godlygeek/tabular'

" fuzzy finder, best plugin for file ever !
NeoBundle 'git://github.com/kien/ctrlp.vim'

" a bazillion of colorscheme
NeoBundle 'flazz/vim-colorschemes'

" hack to get 'correct' colors on vim terminal
NeoBundle 'vim-scripts/CSApprox'

" guide for indentation
NeoBundle 'Yggdroot/indentLine'

" Highlight trailing whitespaces
NeoBundle 'bronson/vim-trailing-whitespace'

" This requires ag to be installed
" https://github.com/rking/ag.vim
NeoBundle 'rking/ag.vim'

" "fancy status line
NeoBundle 'Lokaltog/powerline'
NeoBundle 'bling/vim-airline'
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''


set t_Co=256
syntax on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs


NeoBundle 'tpope/vim-markdown'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" personal vimrc config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set conceallevel=0

" per project .vimrc
set exrc

"remap the leaderkey to ,
:let mapleader = ","

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
" colorscheme darkocean
" colorscheme corporation
" colorscheme railscasts
" colorscheme inkpot
colorscheme luna

" monokai, tomorrow night, tomorrow night bright

" Avoid the escape key
:imap jj <Esc>
:imap qq <Esc>

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
au BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown

"""""""" NERDTree
" map F2 to toggle NERDTree
map <F2> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"Correct a display bug
let g:NERDTreeDirArrows=0


"""""""" coffeescript
" noremap <leader>cm :w <bar> CoffeeMake<CR>
" inoremap <leader>cm <esc>:w <bar> CoffeeMake<CR>

"map <F7> to save and compile the file in bare mode
" nmap <F7> :w <bar> CoffeeMake -b<CR>
" imap <F7> <c-o>:w <bar> CoffeeMake -b<CR>

"""""""" BClose
nnoremap <F12> :Bclose<cr>


"""""""" CtrlP
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.svg,*.eot,*.jar
let g:ctrlp_custom_ignore = 'node_modules\|git\|target\|bin\/src\|dist\|build'
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_map = '<leader>p'
nnoremap <leader>p :CtrlP .<cr>
nnoremap <c-p> :CtrlP .<cr>
nnoremap <leader>b :CtrlPBuffer <cr>
" :h ctrlp-options
let g:ctrlp_root_markers = ['.git, .svn']
let g:ctrlp_match_window = 0
let g:ctrl_switch_buffer = 0

"""""""""" UltiSnips
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-snippets/UltiSnips"]
"let g:UltiSnipsSnippetDirectories=["bundle/vim-snippets/UltiSnips", "bundle/configFiles/frogSnippets"]

"""""""""" vim-javascript
let g:javascript_ignore_javaScriptdoc=1
let g:javascript_enable_domhtmlcss=1




" let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"
" " SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"
