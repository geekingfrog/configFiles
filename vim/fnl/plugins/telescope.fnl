(fn bar []
  (let [lga (require :telescope-live-grep-args.actions)]
    (lga.quote_prompt)))

(lambda configure-mappings [telescope wk]
  (wk.register {:<leader>s {:name :+Search
                            ; :t ["<cmd>Telescope live_grep<cr>" :text]
                            :t [telescope.extensions.live_grep_args.live_grep_args
                                :text]
                            :l ["<cmd>Telescope resume<cr>"
                                "resume last search"]
                            :q ["<cmd> Telescope quickfix<cr>" :quickfix]
                            :R ["<cmd> Telescope registers<cr>" :registers]
                            :m ["<cmd> Telescope marks<cr>" :marks]
                            :j ["<cmd> Telescope jumplist<cr>" :jumplist]}}))

{:plugins [{1 :nvim-telescope/telescope.nvim
            :tag :0.1.5
            :dependencies [:nvim-lua/plenary.nvim
                           :nvim-telescope/telescope-live-grep-args.nvim
                           :nvim-telescope/telescope-fzf-native.nvim]
            }
           :nvim-telescope/telescope-ui-select.nvim]
 :after (lambda configure-telescope []
          (let [telescope (require :telescope)
                wk (require :which-key)
                lga (require :telescope-live-grep-args.actions)]
            ; do the setup after all the plugins have loaded so that lga.quote_prompt works
            (telescope.setup {:defaults {:layout_strategy :vertical}
                              :extensions {:live_grep_args {:mappings {:i {:<C-k> (lga.quote_prompt)}}}}})
            (telescope.load_extension :ui-select)
            (telescope.load_extension :live_grep_args)
            (vim.keymap.set :n :<leader>f "<cmd>Telescope find_files<cr>"
                            {:desc "Find file"})
            (vim.keymap.set :n :<leader>gf "<cmd>Telescope find_files<cr>"
                            {:desc "Find file"})
            (wk.register {:<leader>g :git})
            (configure-mappings telescope wk)))}

