{:plugins [{1 :folke/which-key.nvim
            :lazy false
            :init (λ []
                    (set vim.o.timeout true)
                    (set vim.o.timeoutlen 500)
                    (let [wk (require :which-key)]
                      (wk.add [{1 :<leader>c :group :clipboard}
                               {1 :<leader>cp
                                2 ":let @+ = expand(\"%:r\")..\".\"..expand(\"%:e\")<cr>"
                                :desc "project path"}])))
            :opts {:delay 400}
            :dependencies [:echasnovski/mini.icons]}]}
