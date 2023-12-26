(local utils (require :utils))

{:plugins [:tpope/vim-fugitive
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
                                         (if vim.wo.diff
                                             "]c"
                                             (do
                                               (vim.schedule gs.next_hunk)
                                               :<Ignore>)))
                                       {:expr true})
                                  (map :n "[c"
                                       (fn []
                                         (if vim.wo.diff
                                             "[c"
                                             (do
                                               (vim.schedule gs.prev_hunk)
                                               :<Ignore>))
                                         {:expr true}))
                                  (map :n :<leader>hn gs.next_hunk
                                       "Next hunk")
                                  (map :n :<leader>hp gs.prev_hunk
                                       "Prev hunk")
                                  ;; Actions
                                  (map :n :<leader>hs gs.stage_hunk
                                       "Stage hunk")
                                  (map :n :<leader>hr gs.reset_hunk
                                       "Reset hunk")
                                  (map :v :<leader>hs
                                       (fn []
                                         (gs.stage_hunk [(vim.fn.line ".")
                                                         (vim.fn.line :v)]))
                                       "Stage hunk")
                                  (map :v :<leader>hr
                                       (fn []
                                         (gs.reset_hunk [(vim.fn.line ".")
                                                         (vim.fn.line :v)]))
                                       "Reset hunk")
                                  (map :n :<leader>hS gs.stage_buffer
                                       "Stage buffer")
                                  (map :n :<leader>hu gs.undo_stage_hunk
                                       "Undo stage hunk")
                                  (map :n :<leader>hR gs.reset_buffer
                                       "Reset buffer")
                                  (map :n :<leader>hP gs.preview_hunk
                                       "Preview hunk")
                                  (map :n :<leader>hb
                                       (partial gs.blame_line {:full true})
                                       "Blame line")
                                  (map :n :<leader>tb
                                       gs.toggle_current_line_blame
                                       "Toggle blame")
                                  (map :n :<leader>hd gs.diffthis :Diffthis)
                                  (map :n :<leader>hD (partial gs.diffthis "~")
                                       :DiffThis)
                                  (map :n :<leader>td gs.toggle_deleted
                                       "Toggle deleted")))}}]}

