{:cmd ["vtsls" "--stdio"]
 :root_markers ["package.json"]
 :filetypes ["typescript" "javascript" "vue"]
 :settings {:vtsls {:tsserver {:globalPlugins [{:name "@vue/typescript-plugin"
                                                :location "/home/greg/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/"
                                                :languages ["vue"]
                                                :configNamespace "typescript"}]}}}}
