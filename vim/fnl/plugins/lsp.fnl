(λ use-elin? [bufnr]
  (= :clojure (vim.api.nvim_get_option_value :filetype {:buf bufnr})))

;; All things language server protocol (definition, refactor, completion)
(λ basic-lsp-attach [client bufnr]
  (let [remap (λ remap [mode from to desc]
                (vim.keymap.set mode from to
                                {:buffer bufnr :remap false : desc}))
        lsp-zero (require :lsp-zero)
        wk (require :which-key)
        navic (require :nvim-navic)]
    (remap :n :gd vim.lsp.buf.definition "go to def")
    (remap :n :gD vim.lsp.buf.declaration "go to declaration")
    (remap :n :<c-PageUp> vim.diagnostic.goto_prev "prev diagnostic")
    (remap :n :<c-PageDown> vim.diagnostic.goto_next "next diagnostic")
    (if (use-elin? bufnr)
        (do
          (remap :n :K :<cmd>ElinLookup<cr> :docstring)
          (remap :n :gd :<cmd>ElinJumpToDefinition<cr> "go to def"))
        (remap :n :K vim.lsp.buf.hover "hover doc"))
    (remap :n :<leader>vd vim.diagnostic.open_float "view doc in float")
    (remap :i :<C-h> vim.lsp.buf.signature_help "sig help")
    (remap :n :gr "<cmd>Telescope lsp_references<cr>" "sym references")
    (set vim.opt_local.foldexpr "nvim_treesitter#foldexpr()")
    ;; formatting is handled by a different plugin
    (wk.add [{1 :<leader>l :group :LSP}
             {1 :<leader>la 2 vim.lsp.buf.code_action :desc "code actions"}
             {1 :<leader>lr 2 vim.lsp.buf.rename :desc :rename}
             {1 :<leader>ld 2 vim.lsp.buf.definition :desc "got to def"}
             {1 :<leader>lD
              2 vim.lsp.buf.declaration
              :desc "go to declaration"}
             {1 :<leader>lR
              2 "<cmd>Telescope lsp_references<cr>"
              :desc :references}
             {1 :<leader>ls
              2 "<cmd>Telescope lsp_document_symbols<cr>"
              :desc "doc syms"}
             {1 :<leader>lS
              2 "<cmd>Telescope lsp_workspace_symbols<cr>"
              :desc "workspace syms"}
             {1 :<leader>lw
              2 "<cmd>Telescope diagnostics<cr>"
              :desc :diagnostics}])
    ;; the default_keymaps doesn't override my custom stuff, safe to put at the end
    (lsp-zero.default_keymaps {:buffer bufnr})
    (when (?. client :server_capabilities :documentSymbolProvider)
      (navic.attach client bufnr))))

(λ configure-lsps []
  (let [lsps (let [prefix "/fnl/lsp/"
                   lsp-folder (.. (vim.fn.stdpath "config") prefix)]
               (when (vim.loop.fs_stat lsp-folder)
                 (collect [lsp (vim.fs.dir lsp-folder)]
                   (when (lsp:match ".fnl$")
                     (let [k (lsp:sub 0 (- (length lsp) (length ".fnl")))
                           v (require (.. "lsp." k))]
                       (when (= "table" (type v))
                         (values k v)))))))
        mason-lsp (require "mason-lspconfig")]
    (mason-lsp.setup {:ensure_installed ["bashls"
                                         "clojure_lsp"
                                         "cssls"
                                         "jedi_language_server"
                                         "jsonls"
                                         "elixirls"
                                         "lua_ls"
                                         "sqlls"
                                         "wgsl_analyzer"
                                         "yamlls"]})
    (each [lsp-name lsp-config (pairs lsps)]
      (tset vim.lsp.config lsp-name lsp-config)
      (vim.lsp.enable lsp-name))))

(λ configure-rust-tools []
  (let [rt (require :rust-tools)]
    (rt.setup {:server {:init_options {:procMacro {:enable true}}
                        :on_attach basic-lsp-attach}
               :tools {:inlay_hints {;; Only show inlay hints for the current line
                                     :only_current_line true
                                     ;; Event which triggers a refersh of the inlay hints.
                                     ;; You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                                     ;; not that this may cause  higher CPU usage.
                                     ;; This option is only respected when only_current_line and
                                     ;; autoSetHints both are true.
                                     :only_current_line_autocmd :CursorHold
                                     :hover_with_actions true
                                     ;; wheter to show parameter hints with the inlay hints or not
                                     :show_parameter_hints true
                                     ;; prefix for parameter hints
                                     :parameter_hints_prefix "<- "
                                     ;; prefix for all the other hints (type chaining)
                                     :other_hints_prefix "=> "
                                     ;; whether to align to the length of the longest line in the file
                                     :max_len_align false
                                     ;; padding from the left if max_len_align is true
                                     :max_len_align_padding 1
                                     ;; whether to align to the extreme right or not
                                     :right_align false
                                     ;; padding from the right if right_align is true
                                     :right_align_padding 7
                                     ;; The color of the hints
                                     :highlight :Comment}}})
    (rt.inlay_hints.enable)))

(λ configure-mason [lsp-zero]
  (let [mason (require :mason)
        mason-lsp (require :mason-lspconfig)
        lspconfig (require :lspconfig)
        lua-ls-setup (λ lua-ls-setup []
                       (let [lua-opts (lsp-zero.nvim_lua_ls)
                             utils (require :utils)]
                         (print (vim.inspect lua-opts))
                         (lspconfig.lua_ls.setup lua-opts)))
        fennel-ls-setup (λ fennel-ls-setup []
                          (lspconfig.fennel_language_server.setup {:single_file_support true
                                                                   :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                                                                                       :diagnostics {:globals [:vim]}}}}))]
    (mason-lsp.setup {:handlers {1 lsp-zero.default_setup
                                 ; :lua_ls lua-ls-setup
                                 :fennel_language_server fennel-ls-setup}
                      :ensure_installed [:bashls
                                         :clojure_lsp
                                         :cssls
                                         :fennel_language_server
                                         ; python
                                         :jedi_language_server
                                         :jsonls
                                         :elixirls
                                         :lua_ls
                                         ; :rust_analyzer
                                         :sqlls
                                         :wgsl_analyzer
                                         :yamlls]})))

(λ has-words-before []
  (let [[line col] (vim.api.nvim_win_get_cursor 0)]
    (and (not= 0 col) (-> (vim.api.nvim_buf_get_lines 0 (- line 1) line true)
                          (. 1)
                          (string.sub col col)
                          (string.match "%s")
                          (= nil)))))

; taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
(λ supertab [cmp ls fallback]
  (if (cmp.visible) (cmp.select_next_item) (ls.expand_or_jumpable)
      (ls.expand_or_jump)
      ;; uncomment to enable completion on tab in insert mode
      ;; (has-words-before) (cmp.complete)
      (fallback)))

(λ s-supertab [cmp ls fallback]
  (if (cmp.visible) (cmp.select_prev_item)
      (ls.jumpable -1) (ls.jump -1)
      (fallback)))

(λ configure-cmp []
  (let [cmp (require :cmp)
        ls (require :luasnip)]
    (set vim.opt_local.pumheight 20)
    (ls.filetype_extend :heex [:html])
    (cmp.setup {:sources (cmp.config.sources [{:name :nvim_lsp
                                               :priority_weight 10}
                                              {:name :path}
                                              {:name :buffer}
                                              {:name :luasnip}
                                              {:name :nvim_lua}
                                              {:name :elin}])
                :snippet {:expand (fn [args] (ls.lsp_expand args.body))}
                :completion {:autocomplete false}
                :window {:completion {:scrolloff 2}}
                :mapping (cmp.mapping.preset.insert {:<C-e> (cmp.mapping.abort)
                                                     :<C-space> (cmp.mapping.confirm {:select true})
                                                     :<C-y> (cmp.mapping.confirm {:select true})
                                                     :<cr> (λ [fallback]
                                                             (if (cmp.visible)
                                                                 (cmp.confirm)
                                                                 (fallback)))
                                                     :<Tab> (cmp.mapping (partial supertab
                                                                                  cmp
                                                                                  ls)
                                                                         [:i
                                                                          :s])
                                                     :<S-Tab> (cmp.mapping (partial s-supertab
                                                                                    cmp
                                                                                    ls)
                                                                           [:i
                                                                            :s])})})
    ;; bring up the completion menu when pressing that
    (vim.keymap.set :i :<C-Space> cmp.complete {:remap false})))

;; (lambda configure-luasnip []
;;   (let [ls (require :luasnip)]
;;     (vim.keymap.set :i :<c-k> ls.expand {:silent true})
;;     (vim.keymap.set [:i :s] :<c-n> (partial ls.jump 1) {:silent true})
;;     (vim.keymap.set [:i :s] :<c-p> (partial ls.jump -1) {:silent true})))

{:plugins [{1 :VonHeikemen/lsp-zero.nvim :branch :v3.x}
           {1 :williamboman/mason.nvim
            ;; don't override binaries if they are already on the path
            ;; this is especially important when using python linters that
            ;; requires to be from the venv to work properly
            :opts {:PATH :append}}
           :williamboman/mason-lspconfig.nvim
           :neovim/nvim-lspconfig
           :hrsh7th/cmp-nvim-lsp
           :hrsh7th/cmp-buffer
           :hrsh7th/cmp-path
           :hrsh7th/cmp-cmdline
           {1 :hrsh7th/nvim-cmp :dependencies [:liquidz/elin-cmp-source]}
           {1 :L3MON4D3/LuaSnip
            :dependencies [:rafamadriz/friendly-snippets]
            :init (fn [...]
                    (let [x (require :luasnip.loaders.from_vscode)]
                      (x.lazy_load)))}
           :saadparwaiz1/cmp_luasnip
           ;; {1 :simrat39/rust-tools.nvim :config (fn [...])}
           ;; winbar with contextual info from treesitter
           {1 :utilyre/barbecue.nvim
            :dependencies [:SmiteshP/nvim-navic]
            :opts {:attach_navic false}}]
 :after (fn [...]
          ;; define this mapping outside the on_attach function so it's available even
          ;; if no LSP server is present.
          (vim.keymap.set :n :<leader>li :<cmd>LspInfo<cr>
                          {:remap false :desc :Info})
          (vim.lsp.config "*" {:on_attach basic-lsp-attach})
          (configure-lsps)
          (configure-cmp))
 :exports {:basic-lsp-attach basic-lsp-attach}}
