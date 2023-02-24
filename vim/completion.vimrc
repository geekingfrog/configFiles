" Check clojure-lsp to perhaps replace that
" or https://github.com/clojure-vim/async-clj-omni
" autocmd FileType clojure let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Required for operations modifying multiple buffers like rename.
set hidden

set completeopt=menuone,noselect
set completefunc=mucomplete#list#completefunc
" <c-space> is simpler than <c-x><c-o> to invoke omnicompletion
inoremap <expr> <c-space> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p>'


lua << EOF

-- vim.lsp.set_log_level("debug")

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_named = function(lsp_name, client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  if bufnr == "iced_stdout" then
    client.diagnostic.disable(bufnr)
  end

  -- Mappings.
  local opts = { noremap=true, silent=true, buffer=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)

  -- vim-iced provides a better jump to def
  if lsp_name ~= "clojure_lsp" then
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  end

  vim.keymap.set('n', 'gxd', '<cmd>sp<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', '<space>gvd', '<cmd>vsp<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', '<space>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<space>ca', '<cmd>CodeActions<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.keymap.set('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', '(d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', ')d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format {async = false}<CR>', opts)
  vim.keymap.set('n', '<space>ds', '<cmd>DocumentSymbols<CR>', opts)
  vim.keymap.set('n', '<space>ws', '<cmd>WorkspaceSymbols<CR>', opts)

  vim.keymap.set('v', '<space>f', '<cmd>lua vim.lsp.buf.format {}', opts)

end


local on_attach = function(lsp_name)
  return function(client, bufnr) on_attach_named(lsp_name, client, bufnr) end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'jedi_language_server', 'rust_analyzer', 'clojure_lsp', 'dhall_lsp_server' }
for _, lsp in ipairs(servers) do

  local setup_opts = {
    on_attach = on_attach(lsp),
    flags = {
      debounce_text_changes = 150,
    },
  }

  if lsp == 'rust_analyzer' then
    setup_opts.init_options = {
      procMacro = { enable = true },
      -- check = {command = "clippy"},
    }
  end

  nvim_lsp[lsp].setup(setup_opts)

end

EOF
