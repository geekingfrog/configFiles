{:plugins [{1 :ahmedkhalf/project.nvim
            :config (fn []
                      (let [project (require :project_nvim)]
                        (project.setup {:patterns [:.PROJECTROOT :.git]
                                        :detection_methods [:pattern]})))}]}
