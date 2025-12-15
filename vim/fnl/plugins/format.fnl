{:plugins [{1 :stevearc/conform.nvim
            :config (fn [...]
                      (let [conform (require :conform)
                            prettier-vue (let [find-root (fn []
                                                           (vim.fs.root 0
                                                                        ["package.json"
                                                                         ".editorconfig"]))]
                                           {:command (λ []
                                                       (case (find-root)
                                                         nil "prettier"
                                                         root (.. root
                                                                  "/node_modules/prettier/bin/prettier.cjs")))
                                            :args (λ [_cfg ctx]
                                                    ["--write"
                                                     "--parser"
                                                     "vue"
                                                     "--stdin-filepath"
                                                     ctx.filename])
                                            :cwd find-root})]
                        (conform.setup {:formatters {:ruff-sort-import {:command :ruff
                                                                        :args [:check
                                                                               :--select
                                                                               :I
                                                                               :--fix
                                                                               "-"]}
                                                     :stylua {:prepend_args [:--indent-type
                                                                             :Spaces]}
                                                     :prettier-vue prettier-vue}
                                        :formatters_by_ft {:fennel ["fnlfmt"]
                                                           :sql [:sql_formatter]
                                                           :vue [:prettier-vue]
                                                           :lua [:stylua]
                                                           :python [:ruff-sort-import
                                                                    :ruff_format
                                                                    :ruff]
                                                           :toml [:taplo]
                                                           :sh [:shfmt]
                                                           :typst ["typstyle"]
                                                           :elixir [:mix]}
                                        :default_format_opts {:lsp_format "fallback"
                                                              :timeout_ms 2000}})
                        (vim.keymap.set :n :<leader>lf
                                        (λ []
                                          (conform.format))
                                        {:desc :format})))}]}
