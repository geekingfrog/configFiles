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

;; adapted from https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
(local is-inside-work-tree {})
(lambda project-files []
  (let [cwd (vim.fn.getcwd)
        builtin (require :telescope.builtin)]
    (when (= nil (. is-inside-work-tree cwd))
      (vim.fn.system "git rev-parse --is-inside-work-tree")
      (tset is-inside-work-tree cwd (= vim.v.shell_error 0)))
    (if (. is-inside-work-tree cwd)
        (builtin.git_files)
        (builtin.find_files))))

{:plugins [{1 :nvim-telescope/telescope.nvim
            :tag :0.1.5
            :dependencies [:nvim-lua/plenary.nvim
                           :nvim-telescope/telescope-live-grep-args.nvim
                           :nvim-telescope/telescope-fzf-native.nvim]}
           :nvim-telescope/telescope-ui-select.nvim]
 :after (lambda []
          (let [telescope (require :telescope)
                wk (require :which-key)
                ;; do the setup after all the plugins have loaded so that lga.quote_prompt works
                lga (require :telescope-live-grep-args.actions)]
            (telescope.setup {:defaults {:layout_strategy :vertical}
                              :extensions {:live_grep_args {:mappings {:i {:<C-k> (lga.quote_prompt)}}}}})
            (telescope.load_extension :ui-select)
            (telescope.load_extension :live_grep_args)
            (vim.keymap.set :n :<leader>f project-files {:desc "Find file"})
            (vim.keymap.set :n :<leader>gf "<cmd>Telescope git_files<cr>"
                            {:desc "Find file"})
            (vim.keymap.set :n :<leader>go "<cmd>Telescope git_status<cr>"
                            {:desc "status"})
            (wk.register {:<leader>g :git})
            (configure-mappings telescope wk)))}

