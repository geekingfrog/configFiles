;; Only use none-ls for linting, I have conform for formatting
{:plugins [{1 :nvimtools/none-ls.nvim
            ;; the new mainteneurs decided to deprecated a slew of plugins because they
            ;; are "unmaintained" and could be replaced by other things.
            ;; This include flake8 being replaced by ruff, which is NOT AT ALL true
            ;; so fuck this shit, pin the project down to before this madness until
            ;; I figure a different plugin
            :commit :bb680d752cec37949faca7a1f509e2fe67ab418a
            :config (fn []
                      (let [n (require :null-ls)
                            diags n.builtins.diagnostics]
                        ;; Can use n.register/n.enable/n.disable for more fine grained control
                        ;; typically done in .nvim.lua/fnl for per-project configuration
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
                                          :prefix ""}}))}

