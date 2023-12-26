{:plugins [{1 :nvim-treesitter/nvim-treesitter :build ":TSUpdate"}]
 :after (lambda []
          (let [tsconfig (require :nvim-treesitter.configs)]
            (tsconfig.setup {:ensure_installed {:c :clojure
                                                :css :fennel
                                                :help :javascript
                                                :js :lua
                                                :python :rust
                                                :typescript :vim
                                                :vimdoc :wgsl}
                             :auto_install true
                             :highlight {:enable true
                                         :additional_vim_regex_highlighting false}
                             :incremental_selection {:enable true
                                                     :keymaps {:node_incremental :<tab>
                                                               :scope_incremental :gs
                                                               :node_decremental :<s-tab>}}})))}

