(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:pattern ["*.wgsl"] :command "set filetype=wgsl tabstop=4 shiftwidth=4"})
