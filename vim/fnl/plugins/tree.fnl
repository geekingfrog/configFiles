{:plugins [{1 :nvim-tree/nvim-tree.lua
            :config (fn []
                      (let [tree (require :nvim-tree)]
                        ;; disable netrw
                        (set vim.g.loaded_netrw true)
                        (set vim.g.loaded_netrwPlugin true)
                        (tree.setup {:respect_buf_cwd true
                                     :sync_root_with_cwd true
                                     :update_focused_file {:enable true
                                                           :update_root true}
                                     :diagnostics {:enable true}})
                        (vim.keymap.set :n :<leader>e :<cmd>NvimTreeToggle<cr>)
                        (vim.keymap.set :n :<leader>E :<cmd>NvimTreeFocus<cr>)))
            :dependencies [:nvim-tree/nvim-web-devicons]}]}

