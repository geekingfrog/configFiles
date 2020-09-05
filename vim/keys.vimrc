""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic keybindings. Bindings related to some special
" features will be in other files (completion, linting...)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" usefull stuff found here: http://vimbits.com/bits
" Make Y behave like other capitals
map Y y$

" w is far far away on a bépo layout
nnoremap è w
nnoremap È W
noremap <c-è> <c-w>
noremap <c-È> <c-W>

" j and k as line wise movement
nnoremap <silent> j gj
nnoremap <silent> k gk

" jumping to tag is better
nnoremap gD <C-]>

" quick save shortcut with <leader>s
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
noremap <c-s> :update<cr>
inoremap <c-s> <esc>:update<cr>
" shortcut to quit a buffer
nnoremap <leader>q :q<cr>

"to clear highlight search
nnoremap <F5> :let @/ = ""<CR>

" no more W is not a command !
nnoremap :W :w
nnoremap :Q :q

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" easier move between splits
" See https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
" if c-h (and only this one) doesn't work
map <C-h> <c-w>h
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-l> <c-w>l

" Edit the init.vim config file
" nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>ov :so $MYVIMRC<CR>

" Easier path to normal mode from terminal (neovim)
tnoremap <Esc> <C-\><C-n>

" More accessible than z on bépo layout
noremap … zz


let g:windowswap_map_keys=0
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" Easier quickfix list navigation
nnoremap <c-n> :cnext!<cr>
nnoremap <c-p> :cprevious!<cr>

" ,di and ,ds used for DrawIt{Start,Stop}
" it's rarely used, and conflict with <leader>d (jedi#goto)
" unmap ,di
" unmap ,ds
