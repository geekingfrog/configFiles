{:plugins [{1 :folke/which-key.nvim
            :lazy false
            :init (lambda []
                    (set vim.o.timeout true)
                    (set vim.o.timeoutlen 500))
            :opts {:triggers_nowait []}}]}

