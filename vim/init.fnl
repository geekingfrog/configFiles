; Need the mappings before setting up lazy so that (at least) the leader keys
; are correctly configured for the plugins that use them.
(require :lcommands)
(require :commands)
(require :mappings)
(require :ft)

(local plugins (let [prefix :/fnl/plugins/
                     plugins-folder (.. (vim.fn.stdpath :config) prefix)]
                 (when (vim.loop.fs_stat plugins-folder)
                   (collect [plugin (vim.fs.dir plugins-folder)]
                     (when (plugin:match :.fnl$)
                       (let [k (plugin:sub 0 (- (length plugin) (length :.fnl)))
                             v (require (.. :plugins. k))]
                         (when (= :table (type v))
                           (values k v))))))))

(let [lazy (require :lazy)
      plugins-description (icollect [_plugin-name plugin-tbl (pairs plugins)]
                            (when (= :table (type plugin-tbl))
                              (?. plugin-tbl :plugins)))]
  (lazy.setup plugins-description {:performance {:reset_packpath false}}))

(each [plugin-name plugin-tbl (pairs plugins)]
  (case-try (?. plugin-tbl :after)
        after-fn (pcall after-fn)
        (false err) (print "Error in plugin" plugin-name ":" err)))
