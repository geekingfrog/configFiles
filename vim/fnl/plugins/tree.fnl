{:plugins [{1 :nvim-tree/nvim-tree.lua
            :config (fn []
                      (let [tree (require :nvim-tree)]
                        (tree.setup {:respect_buf_cwd true
                                     ;; keep netrw around for the features other than file browsing
                                     ;; this is useful to work with fugitive&rhubarb
                                     ;; see :h nvim-tree-netrw
                                     :disable_netrw false
                                     :hijack_netrw true
                                     :sync_root_with_cwd true
                                     :update_focused_file {:enable true
                                                           :update_root true}
                                     :diagnostics {:enable true}})
                        (vim.keymap.set :n :<leader>e :<cmd>NvimTreeToggle<cr>)
                        (vim.keymap.set :n :<leader>E :<cmd>NvimTreeFocus<cr>)))
            :dependencies [:nvim-tree/nvim-web-devicons]}]}

