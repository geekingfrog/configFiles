;; There are more mappings defined in telescope.fnl, they all use telescope
;; these are more about the base vim options and mappings

(lambda get-env [var-name ?default]
  "grab the environment variable `var-name` and if not present, returns ?default"
  (or (os.getenv var-name) ?default))

;; set leader key before setting up lazy, other mappings go in their own config file
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; When the page starts to scroll, keep the cursor 2 lines from the top and 2
;; lines from the bottom
(set vim.opt.scrolloff 2)

;; fix the indentation
(set vim.opt.tabstop 2)
(set vim.opt.shiftwidth 2)
(set vim.opt.expandtab true)
(set vim.opt.smartindent true)

;; some navigation tweaks to work better with ergol
(vim.api.nvim_set_keymap :n "+" "gj" {:noremap true})
(vim.api.nvim_set_keymap :n "-" "gk" {:noremap true})

;; highlight some special characters (see listchars for help)
(set vim.opt.list true)

;; disable thin cursor in insert mode
(set vim.opt.guicursor {})
(set vim.opt.smartcase true)
(set vim.opt.ignorecase true)

(set vim.opt.foldlevel 999)
(set vim.opt.foldlevelstart 999)
(set vim.opt.foldmethod :expr)
;; disable folding at startup
(set vim.opt.foldenable false)

(set vim.opt.number true)
(set vim.opt.wrap true)

;; UNDO goodness
(set vim.opt.swapfile false)
(set vim.opt.backup false)
;; TODO check if that is still required when I have the plugin undotree installed
(set vim.opt.undodir (.. (get-env :HOME) :/.vim/undodir))
(set vim.opt.undofile true)

(vim.keymap.set :i :<c-s> "<esc>:update<cr>" {:remap false :desc :save})
(vim.keymap.set :n :<c-s> ":update<cr>" {:remap false :desc :save})
(vim.keymap.set :n ",q" ":q<cr>" {:desc :quit})
(vim.keymap.set :n :<space>h :<cmd>nohlsearch<cr> {:desc "remove highlight"})

(set vim.opt.colorcolumn :80)

(vim.keymap.set :n :Y :y$ {:desc "yank until EOL"})

(vim.keymap.set :v :<A-j> ":m '>+1<CR>gv=gv")
(vim.keymap.set :v :<A-k> ":m '<-2<CR>gv=gv")

;; share vim and system clipboard
(set vim.opt.clipboard :unnamedplus)

;; splits
(vim.keymap.set :n :<C-h> :<c-w>h {:remap false})
(vim.keymap.set :n :<C-l> :<c-w>l {:remap false})
(vim.keymap.set :n :<C-j> :<c-w>j {:remap false})
(vim.keymap.set :n :<C-k> :<c-w>k {:remap false})

(vim.keymap.set :n :<C-q> ":call QuickFixToggle()<cr>"
                {:remap false :desc "toggle quickfix"})

(vim.keymap.set :n :<c-n> ":cnext!<cr>" {:remap false :desc "next quickfix"})
(vim.keymap.set :n :<c-p> ":cprevious!<cr>"
                {:remap false :desc "prev quickfix"})

;; more natural splits
(set vim.opt.splitbelow true)
(set vim.opt.splitright true)

(vim.api.nvim_create_autocmd :TextYankPost
                             {:desc "Highlight text on yank"
                              :callback (fn []
                                          (vim.highlight.on_yank {:higroup :Search
                                                                  :timeout 100}))})

;; resize with ctrl-arrows
(vim.keymap.set :n :<C-Left> ":vertical resize -2<cr>")
(vim.keymap.set :n :<C-Right> ":vertical resize +2<cr>")
(vim.keymap.set :n :<C-Up> ":resize -2<cr>")
(vim.keymap.set :n :<C-Down> ":resize +2<cr>")
