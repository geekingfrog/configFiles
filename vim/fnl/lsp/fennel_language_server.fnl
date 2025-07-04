{:cmd ["fennel-language-server"]
 :filetypes ["fennel"]
 :single_file_support true
 :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                     :diagnostics {:globals ["vim"]}}}}
