{:plugins [{1 :stevearc/conform.nvim
            :config (fn [...]
                      (let [conform (require :conform)]
                        (conform.setup {:lsp_fallback true
                                        :formatters {:ruff-sort-import {:command :ruff
                                                                        :args [:check
                                                                               :--select
                                                                               :I
                                                                               :--fix
                                                                               "-"]}
                                                     :stylua {:prepend_args [:--indent-type
                                                                             :Spaces]}}
                                        :formatters_by_ft {:fennel [:fnlfmt]
                                                           :lua [:stylua]
                                                           :rust [:rustfmt]
                                                           :python [:ruff-sort-import
                                                                    :ruff_format]
                                                           :toml [:taplo]
                                                           :sh [:shfmt]}})
                        (vim.keymap.set :n :<leader>lf conform.format
                                        {:desc :format})))}]}

