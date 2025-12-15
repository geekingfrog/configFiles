(let [root (vim.fs.root 0 ["package.json"])
      cfg-path (.. root "/prettier.config.mjs")
      conform (require "conform")]

  ;; (print "conform with config at" cfg-path)
  ;;
  ;; (set conform.formatters.prettier-vue
  ;;      {:command "prettier"
  ;;       :args ["--experimental-cli"
  ;;              "--write"
  ;;              "--parser"
  ;;              "vue"
  ;;              "--config-path"
  ;;              cfg-path]})

  ;; (conform.setup {:formatters {:prettier-vue-blah {:command "prettier"
  ;;                                                  :args ["--experimental-cli"
  ;;                                                         "--write"
  ;;                                                         "--parser"
  ;;                                                         "vue"
  ;;                                                         "--config-path"
  ;;                                                         cfg-path]}}
  ;;                 ;; :formatters_by_ft {:vue [:prettier-vue-blah]}
  ;;                 })

  ;; (vim.keymap.set :n "<leader>lf"
  ;;                 (λ []
  ;;                   (conform.format {:bufnr 0
  ;;                                    :formatters ["prettier-vue-blah"]}))
  ;;                 {:desc "format vue"})
  nil
  )
