;; Some basic plugins that don't fit in any well defined categories,
;; and with minimal or no setup
{:plugins [:udayvir-singh/tangerine.nvim
           ;; lsp progress status
           {1 :j-hui/fidget.nvim
            :config (fn []
                      ((. (require :fidget) :setup)))}
           {1 :kylechui/nvim-surround
            :version "*"
            :config (fn []
                      ((. (require :nvim-surround) :setup)))}
           ;; rename a buffer, within vim and on disk
           :danro/rename.vim
           ;; structlog.nvim if I need logging
           ]}

