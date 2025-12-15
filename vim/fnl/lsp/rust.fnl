(let [blah (require "../plugins/lsp")]
  {:cmd ["rust-analyzer"]
   :on_attach blah.exports.basic-lsp-attach
   :filetypes ["rust"]
   :settings {:procMacro {:enable true}}})
