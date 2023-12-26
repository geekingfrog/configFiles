{:plugins [
           {1 :ellisonleao/gruvbox.nvim
            ; don't lazily load the default colorscheme
            :lazy false
            :priority 1000
            :config (fn [...]
                      (set vim.o.background :light)
                      (vim.cmd "colorscheme gruvbox"))}
           {1 :nvim-lualine/lualine.nvim
            :opts {:theme :gruvbox
                   ; largely taken from lunarvim's lualine config
                   :sections {:lualine_a [{1 (fn []
                                               "☭ ")
                                           :padding {:left 0 :right 0}
                                           :color {}
                                           :cond nil}]
                              :lualine_x [{1 :diagnostics
                                           :sources [:nvim_diagnostic]
                                           :symbols {:error " "
                                                     :warn " "
                                                     :info " "
                                                     :hint " "}}]}}}
           {1 :lukas-reineke/indent-blankline.nvim
            :main :ibl
            :opts {:indent {:char "▏" :smart_indent_cap true}
                   :scope {:enabled false}}}]}

