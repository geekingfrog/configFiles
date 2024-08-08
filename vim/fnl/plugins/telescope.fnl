(lambda configure-mappings [telescope wk]
  (wk.add [{1 :<leader>s :desc :+Search}
           {1 :<leader>sb 2 "<cmd>Telescope buffers<cr>" :desc :buffers}
           {1 :<leader>st
            2 telescope.extensions.live_grep_args.live_grep_args
            :desc :text}
           {1 :<leader>sl
            2 "<cmd>Telescope resume<cr>"
            :desc "resume last search"}
           {1 :<leader>sq 2 "<cmd>Telescope quickfix<cr>" :desc :quickfix}
           {1 :<leader>sR 2 "<cmd>Telescope registers<cr>" :desc :registert}
           {1 :<leader>sm 2 "<cmd>Telescope marks<cr>" :desc :marks}
           {1 :<leader>sj 2 "<cmd>Telescope jumplist<cr>" :desc :jumplist}]))

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
                            {:desc :status})
            (wk.add {1 :<leader>g :group :git})
            ;(wk.register {:<leader>g :git})
            (configure-mappings telescope wk)))}

