{:user
 {:plugins [[lein-ancient "0.6.15"]
            [lein-cloverage "1.0.11-SNAPSHOT"]
            [lein-kibit "0.1.6"]
            [lein-midje "3.2.1"]
            [venantius/ultra "0.5.2"]
            [com.gfredericks/lein-shorthand "0.4.1"]]

  :dependencies [[cider/cider-nrepl "0.17.0"]
                 [mvxcvi/puget "1.0.2"]
                 [org.clojure/tools.namespace "0.3.0-alpha4"]]

  :shorthand {. {tnr clojure.tools.namespace.repl/refresh
                 tnr-all clojure.tools.namespace.repl/refresh-all
                 source clojure.repl/source
                 pp puget.printer/pprint}}}

 :uberjar {:aot :all} }
