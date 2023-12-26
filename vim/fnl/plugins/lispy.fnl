{:plugins [{1 :PaterJason/nvim-treesitter-sexp
            :dependencies [:nvim-treesitter/nvim-treesitter]
            :opts {:keymaps {:commands {:insert_head :<LocalLeader>a
                                        :insert_tail :<LocalLeader>A
                                        :swap_prev_elem :<A-k>
                                        :swap_next_elem :<A-j>
                                        :swap_prev_form :<A-l>
                                        :swap_next_form :<A-h>
                                        :slurp_left "«h"
                                        :slurp_right "»l"
                                        :barf_left "»h"
                                        :barf_right "«l"}}}}
           :tpope/vim-fireplace
           {1 :liquidz/vim-iced
            :config (fn []
                      (set vim.g.iced_default_key_mapping_leader "«")
                      (set vim.g.iced_enable_default_key_mappings true))
            :dependencies [:guns/vim-sexp]}
           {1 :guns/vim-sexp
            :config (fn []
                      (set vim.g.sexp_filetypes "")
                      (vim.api.nvim_create_autocmd :FileType
                                                   {:callback (fn []
                                                                (vim.keymap.set :i
                                                                                :<localleader>a
                                                                                "<Plug>(sexp_round_head_wrap_list)"
                                                                                {:buffer true}))}))}]}

