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
                                        :formatters_by_ft {:fennel ["fnlfmt"]
                                                           :sql [:sql_formatter]
                                                           :lua [:stylua]
                                                           :python [:ruff-sort-import
                                                                    :ruff_format
                                                                    :ruff]
                                                           :toml [:taplo]
                                                           :sh [:shfmt]
                                                           :elixir [:mix]}
                                        :default_format_opts {:lsp_format "fallback"
                                                              :timeout_ms 2000}})
                        (vim.keymap.set :n :<leader>lf
                                        (λ []
                                          (conform.format))
                                        {:desc :format})))}]}
