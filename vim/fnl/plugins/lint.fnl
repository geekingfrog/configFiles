;; Only use none-ls for linting, I have conform for formatting
{:plugins [{1 :nvimtools/none-ls.nvim
            :dependencies ["nvim-lua/plenary.nvim"]
            :config (fn []
                      (let [n (require :null-ls)
                            diags n.builtins.diagnostics]
                        ;; Can use n.register/n.enable/n.disable for more fine grained control
                        ;; typically done in .nvim.lua/fnl for per-project configuration
                        ;; See https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md for list
                        (n.setup {:sources [;; diags.pylint
                                            ;; diags.mypy
                                            diags.clj_kondo]})))}]
 :after (λ []
          (vim.diagnostic.config {:virtual_text true
                                  :update_in_insert false
                                  :underline true
                                  :severity_sort true
                                  ;; TODO signs
                                  :float {:focusable true
                                          :style :minimal
                                          :border :rounded
                                          :source :always
                                          :header ""
                                          :prefix ""}}))}
