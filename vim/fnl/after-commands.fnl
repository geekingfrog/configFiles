(λ get-python-import [filepath]
  (case (vim.fn.fnamemodify filepath ":.")
    (where rel-path (= nil (string.match rel-path "%.py$"))) ""
    (where rel-path true) (let [dotted-path (-> rel-path
                                                (string.gsub "^src\\/" "")
                                                (string.gsub "%.py$" "")
                                                (string.gsub "/" "."))
                                last-dot (string.match dotted-path ".*()%.")]
                            (if (not last-dot)
                                (.. "import " dotted-path)
                                (let [base (string.sub dotted-path 1
                                                       (- last-dot 1))
                                      mod (string.sub dotted-path
                                                      (+ last-dot 1))]
                                  (.. "from " base " import " mod))))))

(λ yank-stuff [?filepath]
  (if (= nil ?filepath)
      (let [filepath (vim.fn.expand "%:p")]
        (if (= "" filepath)
            nil
            (yank-stuff filepath)))
      (let [vals [["BASENAME" (vim.fn.fnamemodify ?filepath ":t:r")]
                  ["FILENAME" (vim.fn.fnamemodify ?filepath ":t")]
                  ["PROJECT PATH" (vim.fn.fnamemodify ?filepath ":.")]
                  ["PATH (~)" (vim.fn.fnamemodify ?filepath ":~")]
                  ["PY IMPORT" (get-python-import ?filepath)]]
            options (icollect [_ [x v] (ipairs vals)]
                      (if (not (= "" v)) x))
            map-opts (collect [_ [x v] (ipairs vals)] x v)]
        (vim.ui.select options
                       {:prompt "copy to clipboard"
                        :format_item (λ [list-item]
                                       (string.format "%-13s: %s" list-item
                                                      (. map-opts list-item)))}
                       (λ [?choice]
                         (if (not (= nil ?choice))
                             (case (. map-opts ?choice)
                               nil nil
                               result (do
                                        ;; unamed register for p/P
                                        (vim.fn.setreg "\"" result)
                                        ;; system clip
                                        (vim.fn.setreg "+" result)))))))))

((. (require "which-key") "add") [{1 "<leader>y" "group" "yank"}
                                  {1 "<leader>yp"
                                   2 yank-stuff
                                   :desc "file paths"
                                   :mode [:n :v]}])
