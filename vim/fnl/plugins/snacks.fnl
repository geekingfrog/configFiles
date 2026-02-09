{:plugins [{1 :folke/snacks.nvim
            :priority 1000
            :lazy false
            :opts {:picker {:enabled true
                            :win {:input {:keys {"<PageDown>" {1 "list_scroll_down"
                                                          :mode [:i :n]}
                                                 "<PageUp>" {1 "list_scroll_up"
                                                          :mode [:i :n]}}}}
                                                          }
                   :keymap {:enabled true}}
            :config (λ [_ opts]
                      (let [wk (require "which-key")]
                        ((. (require "snacks") "setup") opts)
                        (wk.add {1 "<leader>g" :group "git"})
                        (wk.add {1 "<leader>f" :group "find"})
                        (wk.add {1 "<leader>s" :group "search content"})))
            :keys [{1 "<leader>ff"
                    2 (λ [] (_G.Snacks.picker.files))
                    :desc "Files"}
                   {1 "<leader>fb"
                    2 (λ [] (_G.Snacks.picker.buffers))
                    :desc "Buffers"}
                   {1 "<leader>fj"
                    2 (λ [] (_G.Snacks.picker.jumps))
                    :desc "Jumps"}
                   {1 "<leader>sl"
                    2 (λ [] (_G.Snacks.picker.resume))
                    :desc "Resume"}
                   {1 "<leader>st"
                    2 (λ [] (_G.Snacks.picker.grep))
                    :desc "Grep"}
                   {1 "<leader>sb"
                    2 (λ [] (_G.Snacks.picker.grep_buffers))
                    :desc "Grep buffer"}
                   {1 "<leader>sm"
                    2 (λ [] (_G.Snacks.picker.marks))
                    :desc "Marks"}
                   {1 "<leader>sr"
                    2 (λ [] (_G.Snacks.picker.recent))
                    :desc "Recent"}
                   {1 "<leader>s\""
                    2 (λ [] (_G.Snacks.picker.registers))
                    :desc "Registers"}
                   {1 "<leader>go"
                    2 (λ [] (_G.Snacks.picker.git_status))
                    :desc "Git status"}]}]}
