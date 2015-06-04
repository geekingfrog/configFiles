set nocompatible               " be iMproved
filetype off                   " required!

let neobundleReadme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundleReadme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  " echo "Done, restart vim"
  " exit 1;
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/

" if has('vim_starting')
"   if &compatible
"     set nocompatible               " Be iMproved
"   endif
"
"   " Required:
"   set runtimepath+=~/.vim/bundle/neobundle.vim/
" endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle "Shougo/vimproc.vim", {
\ "build" : {
\     "windows" : "tools\\update-dll-mingw",
\     "cygwin" : "make -f make_cygwin.mak",
\     "mac" : "make -f make_mac.mak",
\     "linux" : "make",
\     "unix" : "gmake",
\    },
\ }


" Code editting goodness
NeoBundle "tomtom/tcomment_vim"
NeoBundle "mbbill/undotree"
NeoBundle "scrooloose/syntastic"
NeoBundle "tpope/vim-fugitive"
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-repeat"
NeoBundle "gregsexton/gitv"
NeoBundle "godlygeek/tabular"
NeoBundle "kien/ctrlp.vim"
NeoBundle "Shougo/neocomplete.vim"
NeoBundle "majutsushi/tagbar"

" hack to get 'correct' colors on vim terminal
NeoBundle 'vim-scripts/CSApprox'
NeoBundle 'flazz/vim-colorschemes'

" Show visual marker for indentation
NeoBundle 'Yggdroot/indentLine'

" Highlight trailing whitespaces
NeoBundle 'bronson/vim-trailing-whitespace'

" This requires ag to be installed
" https://github.com/rking/ag.vim
NeoBundle 'rking/ag.vim'

NeoBundle 'bling/vim-airline'
NeoBundle 'danro/rename.vim'

" Language specific plugins

"""""""" Web (html/js/css and co) """"""""
NeoBundle 'vim-scripts/UltiSnips'
NeoBundle 'honza/vim-snippets'
" NeoBundle 'tpope/vim-jdaddy'  " json

NeoBundle 'ap/vim-css-color'
NeoBundle "pangloss/vim-javascript"
NeoBundle "mxw/vim-jsx"

"github flavored markdown
NeoBundle 'tpope/vim-markdown'

"""""""" Python """"""""
NeoBundle 'klen/python-mode'
NeoBundle 'davidhalter/jedi-vim'

"""""""" Haskell """"""""
" cabal install hdevtools hlint

NeoBundle "kazu-yamamoto/ghc-mod"
NeoBundle "eagletmt/ghcmod-vim"
NeoBundle "eagletmt/neco-ghc"
NeoBundle "bitc/vim-hdevtools"

"""""""" Misc """""""""
NeoBundle 'vim-scripts/loremipsum'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" personal vimrc config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
au BufNewFile,BufRead *.json setlocal conceallevel=0

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
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin'
  set clipboard=unnamed
elseif os == 'Linux'
  set clipboard=unnamedplus
endif

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
" autocmd BufReadPost *.py setlocal shiftwidth=4

"replace <tab> by spaces
set expandtab
set tabstop=2

" A better backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"always paste with respect to indentation
nnoremap p ]p

"highlight search results
set hlsearch
"and start searching while typing
set incsearch

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
" noremap <enter> zz

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


" Read gzip files without unzipping
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#gzip-example
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""" Markdown
" augroup markdown
"     au!
"     au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
" augroup END
au BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown

"""""""""" Tagbar
nnoremap <F8> :TagbarToggle<CR>


"""""""" Airline
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
syntax on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Required to show Unicode glyphs



"""""""" BClose
nnoremap <F12> :Bclose<cr>


"""""""" CtrlP
" ignore files that git ignores
" from https://github.com/kien/ctrlp.vim/issues/273
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|git\|venv'
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


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_python_pyflakes_exe = 'python3 ~/.local/bin/pyflakes'
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
" let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_exe = 'python3 -m flake8'
let g:syntastic_aggregate_errors = 1

" let g:syntastic_php_checkers = []
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetype': []}
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" Python
" autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" autocmd Filetype python setlocal foldmethod=indent


"""""""""" Python-mode
let g:pymode_rope = 0
let g:pymode_lint = 0 " done with syntastic
" let g:pymode_rope_complete_on_dot = 0
" let g:pymode_rope_autoimport = 0
" This requires vim with python3 support
let g:pymode_python = 'python3'

"""""""""" undotree and persistent undo
set undofile
set undodir=~/.vim/undodir
nnoremap <F4> :UndotreeToggle<CR>


"""""""""" indentLine
" indentLine plugin prevent override of conceallevel setting. The following
" line will fix that
" See https://github.com/elzr/vim-json/issues/23#issuecomment-40293049
let g:indentLine_noConcealCursor=""

"""""""""" NeoComplete
let g:neocomplete#enable_at_startup=1
" Shell like behavior(not recommended).
" set completeopt+=longest
" let g:neocomplete#enable_auto_select = 1
let g:neocomplete#disable_auto_complete = 1
" inoremap <expr><TAB>  pumvisible() ? "\<Down>" :
" \ neocomplete#start_manual_complete()
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()

"""""""""" Haskell
nnoremap <F1> :HdevtoolsType<CR>
nnoremap <F2> :HdevtoolsTypeClear<CR>
nnoremap <F3> :HdevtoolsInfo<CR>

" https://github.com/majutsushi/tagbar/wiki#haskell
let g:tagbar_type_haskell = {
\ 'ctagsbin'  : 'hasktags',
\ 'ctagsargs' : '-x -c -o-',
\ 'kinds'     : [
    \  'm:modules:0:1',
    \  'd:data: 0:1',
    \  'd_gadt: data gadt:0:1',
    \  't:type names:0:1',
    \  'nt:new types:0:1',
    \  'c:classes:0:1',
    \  'cons:constructors:1:1',
    \  'c_gadt:constructor gadt:1:1',
    \  'c_a:constructor accessors:1:1',
    \  'ft:function types:1:1',
    \  'fi:function implementations:0:1',
    \  'o:others:0:1'
\ ],
\ 'sro'        : '.',
\ 'kind2scope' : {
    \ 'm' : 'module',
    \ 'c' : 'class',
    \ 'd' : 'data',
    \ 't' : 'type'
\ },
\ 'scope2kind' : {
    \ 'module' : 'm',
    \ 'class'  : 'c',
    \ 'data'   : 'd',
    \ 'type'   : 't'
\ }
\ }
