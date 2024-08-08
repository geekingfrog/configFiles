{:plugins [{1 :folke/which-key.nvim
            :lazy false
            :init (lambda []
                    (set vim.o.timeout true)
                    (set vim.o.timeoutlen 500)
                    (let [wk (require :which-key)]
                      (wk.register {:<leader>c {:name :+clipboard
                                   :p [":let @+ = expand(\"%:r\")..\".\"..expand(\"%:e\")<cr>" "project path"]
                                   }})
                      ))
            :opts {:triggers_nowait []}}]}

