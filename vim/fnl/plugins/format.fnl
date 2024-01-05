{:plugins [{1 :stevearc/conform.nvim
            :config (fn [...]
                      (let [conform (require :conform)]
                        (conform.setup {:formatters {:ruff-sort-import {:command :ruff
                                                                        :args [:check
                                                                               :--select
                                                                               :I
                                                                               :--fix
                                                                               "-"]}
                                                     :stylua {:prepend_args [:--indent-type
                                                                             :Spaces]}}
                                        :formatters_by_ft {:fennel [:fnlfmt]
                                                           :lua [:stylua]
                                                           :python [:black
                                                                    :ruff-sort-import
                                                                    :ruff_format]
                                                           :toml [:taplo]
                                                           :sh [:shfmt]}})
                        (vim.keymap.set :n :<leader>lf
                                        (lambda []
                                          (conform.format {:lsp_fallback true}))
                                        {:desc :format})))}]}

