{:plugins [{1 :numToStr/Comment.nvim
            :lazy false
            :opts {:pre_hook (fn [...]
                               (match (pcall require
                                             :ts_context_commentstring.integrations.comment_nvim)
                                 (true ts-comment) ((ts-comment.create_pre_hook) ...)))}}
           ;; lazy since it's going to be setup by comment.nvim
           {1 :JoosepAlviste/nvim-ts-context-commentstring :lazy true}]
 :after (lambda []
          ;; I prefer the double ;; for comments, it also doesn't get moved around by fnlfmt
          (let [ft (require :Comment.ft)]
            (ft.set :fennel ";; %s")
            (ft.set :wgsl "// %s")))}

