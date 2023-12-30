(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:pattern ["*.wgsl"] :command "set ft=wgsl"})
