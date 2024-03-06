(vim.api.nvim_create_autocmd [:BufNewFile :BufRead]
                             {:pattern [:*.wgsl]
                              :command "set filetype=wgsl tabstop=4 shiftwidth=4"})

(lambda shebang-filetype [ev]
  (when (= "" (vim.api.nvim_get_option_value :filetype {:buf (. ev :buf)}))
    (let [first-line (. (vim.api.nvim_buf_get_lines ev.buf 0 1 false) 1)]
      (if (string.match first-line "^#!/usr/bin/env bb")
          (vim.api.nvim_command "set filetype=clojure")
          ;; add more stuff there
          ))))

;; (vim.api.nvim_create_autocmd [:BufNewFile :BufRead]
;;                              {:pattern ["*"] :callback shebang-filetype})

