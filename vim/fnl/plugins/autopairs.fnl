{:plugins [{1 :windwp/nvim-autopairs
            :event :InsertEnter
            :config (fn [...]
                      (let [ap (require :nvim-autopairs)]
                        (ap.setup {:disable_filetype [:TelescopePrompt :vim]})
                        ;; remove add single quote on lispy filetypes
                        (let [x (-> (ap.get_rules "'") (. 1))]
                          (set x.not_filetypes [:clojure :scheme :lisp]))
                        ))}]}

