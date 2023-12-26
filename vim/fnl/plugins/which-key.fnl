{:plugins [{1 :folke/which-key.nvim
            :lazy true
            :init (lambda configure-which-key []
                      (set vim.o.timeout true)
                      (set vim.o.timeoutlen 500)
                      (let [wk (require :which-key)]
                        (wk.setup)))}]}

