{:plugins [{1 :nvim-treesitter/nvim-treesitter :build ":TSUpdate"}
           {1 :nvim-treesitter/nvim-treesitter-textobjects}]
 :after (lambda []
          (let [tsconfig (require :nvim-treesitter.configs)]
            (tsconfig.setup {:ensure_installed [:c
                                                :clojure
                                                :css
                                                :fennel
                                                :javascript
                                                :lua
                                                :python
                                                :rust
                                                :typescript
                                                :vim
                                                :vimdoc
                                                :wgsl]
                             :auto_install true
                             :highlight {:enable true
                                         :additional_vim_regex_highlighting false}
                             :incremental_selection {:enable true
                                                     :keymaps {:node_incremental :<tab>
                                                               :scope_incremental :gs
                                                               :node_decremental :<s-tab>}}
                             :textobjects {:select {:enable true
                                                    ;; Automatically jump forward to textobj similar to targets.vim
                                                    :lookahead true
                                                    :keymaps {;; You can use the capture groups defined in textobjects.scm
                                                              :af "@function.outer"
                                                              :if "@function.inner"
                                                              :ac "@class.outer"
                                                              ;; You can optionally set descriptions to the mappings (used in the desc parameter of
                                                              ;; nvim_buf_set_keymap) which plugins like which-key display
                                                              :ic {:query "@class.inner"
                                                                   :desc "Select inner part of a class region"}
                                                              ;; You can also use captures from other query groups like `locals.scm`
                                                              :as {:query "@scope"
                                                                   :query_group :locals
                                                                   :desc "Select language scope"}}
                                                    ;; You can choose the select mode (default is charwise 'v')
                                                    ;;
                                                    ;; Can also be a function which gets passed a table with the keys
                                                    ;; * query_string: eg '@function.inner'
                                                    ;; * method: eg 'v' or 'o'
                                                    ;; and should return the mode ('v' 'V', or '<c-v>') or a table
                                                    ;; mapping query_strings to modes.
                                                    :selection_modes {"@parameter.outer" :v
                                                                      ;; charwise
                                                                      "@function.outer" :V
                                                                      ;; linewise
                                                                      "@class.outer" :<c-v>
                                                                      ;; blockwise
                                                                      }
                                                    ;; If you set this to `true` (default is `false`) then any textobject is
                                                    ;; extended to include preceding or succeeding whitespace. Succeeding
                                                    ;; whitespace has priority in order to act similarly to eg the built-in
                                                    ;; `ap`.
                                                    ;;
                                                    ;; Can also be a function which gets passed a table with the keys
                                                    ;; * query_string: eg '@function.inner'
                                                    ;; * selection_mode: eg 'v'
                                                    ;; and should return true of false
                                                    :include_surrounding_whitespace true}
                                           :move {:enable true
                                                  ;; whether to set jumps in the jumplist
                                                  :set_jumps true
                                                  :goto_next_start {")m" {:query "@class.outer"
                                                                          :desc "Next class start"}
                                                                    "))" {:query "@function.outer"
                                                                          :desc "Next function start"}}
                                                  :goto_next_end {")M" "@function.outer"
                                                                  ")(" "@class.outer"}
                                                  :goto_previous_start {"(m" "@class.outer"
                                                                        "((" "@function.outer"}
                                                  :goto_previous_end {"(M" "@class.outer"
                                                                      "()" "@function.outer"}
                                                  ;; Below will go to either the start or the end, whichever is closer.
                                                  ;; Use if you want more granular movements
                                                  ;; Make it even more gradual by adding multiple queries and regex.
                                                  :goto_next {")d" "@conditional.outer"}
                                                  :goto_previous {"(d" "@conditional.outer"}}}})))}

