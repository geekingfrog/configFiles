(local utils (require :utils))

{:plugins [:tpope/vim-fugitive
           :tpope/vim-rhubarb
           {1 :lewis6991/gitsigns.nvim
            :opts {:on_attach (lambda [bufnr]
                                (lambda map [mode from to ?opts]
                                  (let [opts (if (= nil ?opts) {}
                                                 (utils.string? ?opts) {:desc ?opts}
                                                 ?opts)]
                                    (set opts.buffer bufnr)
                                    (vim.keymap.set mode from to opts)))
                                (let [gs (require :gitsigns)]
                                  ;; Navigation
                                  (map :n "]c"
                                       (fn []
                                         (if vim.wo.diff "]c"
                                             (do
                                               (vim.schedule gs.next_hunk)
                                               :<Ignore>)))
                                       {:expr true})
                                  (map :n "[c"
                                       (fn []
                                         (if vim.wo.diff "[c"
                                             (do
                                               (vim.schedule gs.prev_hunk)
                                               :<Ignore>))
                                         {:expr true}))
                                  (map :n :<leader>gn gs.next_hunk "Next hunk")
                                  (map :n :<leader>gp gs.prev_hunk "Prev hunk")
                                  ;; Actions
                                  (map :n :<leader>gs gs.stage_hunk
                                       "Stage hunk")
                                  (map :n :<leader>gr gs.reset_hunk
                                       "Reset hunk")
                                  (map :v :sh
                                       (fn []
                                         (gs.stage_hunk [(vim.fn.line ".")
                                                         (vim.fn.line :v)]))
                                       "Stage hunk")
                                  (map :v :gr
                                       (fn []
                                         (gs.reset_hunk [(vim.fn.line ".")
                                                         (vim.fn.line :v)]))
                                       "Reset hunk")
                                  (map :n :<leader>gS gs.stage_buffer
                                       "Stage buffer")
                                  (map :n :<leader>gu gs.undo_stage_hunk
                                       "Undo stage hunk")
                                  (map :n :<leader>gR gs.reset_buffer
                                       "Reset buffer")
                                  (map :n :<leader>gP gs.preview_hunk
                                       "Preview hunk")
                                  (map :n :<leader>gb
                                       (partial gs.blame_line {:full true})
                                       "Blame line")
                                  (map :n :<leader>tb
                                       gs.toggle_current_line_blame
                                       "Toggle blame")
                                  (map :n :<leader>gd gs.diffthis :Diffthis)
                                  (map :n :<leader>gD (partial gs.diffthis "~")
                                       :DiffThis)
                                  (map :n :<leader>td gs.toggle_deleted
                                       "Toggle deleted")))}}]}

