{:plugins [{1 :folke/which-key.nvim
            :lazy false
            :init (λ []
                    (set vim.o.timeout true)
                    (set vim.o.timeoutlen 500))
            :opts {:delay 400}
            :dependencies [:echasnovski/mini.icons]}]}
