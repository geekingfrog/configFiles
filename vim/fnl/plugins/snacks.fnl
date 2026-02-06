{:plugins [{1 :folke/snacks.nvim
            :priority 1000
            :lazy false
            :opts {:picker {:enabled true
                            :keymaps {"<PageUp>" {1 "scroll_results_up"
                                                  :mode ["i" "n"]}
                                      "<PageDown>" {1 "scroll_results_down"
                                                    :mode ["i" "n"]}}}}
            :keys [{1 "<leader>ff"
                    2 (λ [] (_G.Snacks.picker.files))
                    :desc "Files"}
                   {1 "<leader>fb"
                    2 (λ [] (_G.Snacks.picker.buffers))
                    :desc "Buffers"}
                   {1 "<leader>fj"
                    2 (λ [] (_G.Snacks.picker.jumps))
                    :desc "Jumps"}
                   {1 "<leader>s" :desc "Search"}
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
                    :desc "Registers"}]}]}
