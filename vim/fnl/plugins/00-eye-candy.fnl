;; taken from lunarvim components.lua
(lambda python-env []
  (let [green "#98be65"
        f (fn []
            (if (= :python vim.bo.filetype)
                (let [venv (or (os.getenv :CONDA_DEFAULT_ENV)
                               (os.getenv :VIRTUAL_ENV))]
                  (if venv
                      (let [icons (require :nvim-web-devicons)
                            py-icon (icons.get_icon :.py)]
                        py-icon)
                      ""))
                ""))]
    {1 f :color {:fg green} :cond (lambda [] (> vim.o.columns 100))}))

{:plugins [{1 :ellisonleao/gruvbox.nvim
            ; don't lazily load the default colorscheme
            :lazy false
            :priority 1000
            :config (fn [...]
                      (set vim.o.background :light)
                      (vim.cmd "colorscheme gruvbox"))}
           {1 :nvim-lualine/lualine.nvim
            :opts {:theme :gruvbox
                   ; largely taken from lunarvim's lualine config
                   :sections {:lualine_a [{1 (fn [] "☭ ")
                                           :padding {:left 0 :right 0}
                                           :color {}
                                           :cond nil}]
                              :lualine_b [:branch]
                              :lualine_c [{1 :filename :path 1} (python-env)]
                              :lualine_x [{1 :diagnostics
                                           :sources [:nvim_diagnostic]
                                           :symbols {:error " "
                                                     :warn " "
                                                     :info " "
                                                     :hint " "}}]
                              :lualine_y [:filetype]}
                   :options {:section_separators "" :component_separators ""}}}
           {1 :lukas-reineke/indent-blankline.nvim
            :main :ibl
            :opts {:indent {:char "▏" :smart_indent_cap true}
                   :scope {:enabled false}}}]}
