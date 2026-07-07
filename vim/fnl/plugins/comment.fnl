{:plugins [{1 :numToStr/Comment.nvim :lazy true}]
 :after (λ []
          ;; I prefer the double ;; for comments, it also doesn't get moved around by fnlfmt
          (let [ft (require :Comment.ft)]
            (ft.set :clojure ";; %s")
            (ft.set :fennel ";; %s")
            (ft.set :wgsl "// %s")
            (ft.set :systemd "# %s")))}
