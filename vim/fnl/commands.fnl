(set vim.o.exrc true)
;; ensure compilation of custom exrc files in fennel
(vim.api.nvim_create_autocmd [:BufEnter :BufWritePost]
                             {:pattern :.nvim.fnl
                              :callback (λ []
                                          (vim.cmd ":FnlCompileBuffer"))})
