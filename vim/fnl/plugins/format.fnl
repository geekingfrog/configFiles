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
                                                           :sql [:sql_formatter]
                                                           :lua [:stylua]
                                                           :python [:ruff-sort-import
                                                                    :ruff_format
                                                                    :ruff]
                                                           :toml [:taplo]
                                                           :sh [:shfmt]
                                                           :elixir [:mix]}})
                        (vim.keymap.set :n :<leader>lf
                                        (lambda []
                                          (conform.format {:lsp_fallback true :timeout_ms 2000}))
                                        {:desc :format})))}]}

