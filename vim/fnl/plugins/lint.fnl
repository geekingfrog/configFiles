;; Only use none-ls for linting, I have conform for formatting
{:plugins [{1 :nvimtools/none-ls.nvim
            :config (fn []
                      (let [n (require :null-ls)
                            diags n.builtins.diagnostics]
                        ;; See https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md for list
                        (n.setup {:sources [diags.pylint
                                            diags.mypy
                                            diags.clj_kondo
                                            diags.shellcheck]})))}]
 :after (lambda []
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
                                          :prefix ""}})
          )}

