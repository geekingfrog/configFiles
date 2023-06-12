--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.which_key.mappings["w"]= {}

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

require('which-key').register {
  ["<leader>lpd"] = {
    function() require('goto-preview').goto_preview_definition() end,
    "preview definition"
  },
  ["<leader>lpi"] = {
    "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
    "preview implementation"
  },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.project.active = false

-- TODO: need to tweak the config of that plugin
-- so I keep at least the history. Right now, editing a big file
-- and trying to undo fails (nothing to undo)
lvim.builtin.bigfile.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  -- "java",
  "yaml",
  "clojure",
  "haskell",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-v>", -- set to `false` to disable one of the mappings
      node_incremental = "<tab>",
      scope_incremental = false,
      node_decremental = "<s-tab>",
    },
  },
}

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--   "lua_ls",
--   -- "sumneko_lua",
--   "jsonls",
--   "rust_analyzer",
-- }

-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`

-- use jedi_language_server instead of pyright
-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- require("lvim.lsp.manager").setup("rust_analyzer", {
--   init_options = {
--     procMacro = { enable = true },
--   },
-- })

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- lvim.lsp.buffer_mappings.normal_mode["<leader>ca"] = function()
--   print("coucou")
-- end

local actions = require "telescope.actions"
lvim.builtin.telescope.defaults.mappings.i["<CR>"] = actions.select_default

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "mypy", filetypes = { "python" } },
  { command = "pylint", filetypes = { "python" },
    extra_args = {}
  },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- extra_args = { "--severity", "warning" },
  },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
}

-- Additional Plugins
lvim.plugins = {
  { "ellisonleao/gruvbox.nvim" },

  { "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- fold markdown
  { "masukomi/vim-markdown-folding" },
  { "danro/rename.vim" },
  { "mbbill/undotree" },
  { "junegunn/vim-easy-align" },

  { "tpope/vim-fugitive" },
  -- { "vim-scripts/DrawIt" },

  -- clojure
  { "liquidz/vim-iced" },

  -- ideally telescope would be used for various lsp actions like code actions
  -- however I haven't figured out how to achieve that, so use my old config
  -- with fzf
  { "gfanto/fzf-lsp.nvim",          dependencies = { "junegunn/fzf" } },

  { 'simrat39/rust-tools.nvim',
    config = function()
      local opts = {
        tools = {
          inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = true,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            hover_with_actions = true,

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
          },
        },
        -- rust tools sets up nvim-lspconfig for rust analyzer, so it will override
        -- other settings :(
        -- hence the need to duplicate some custom config
        server = {
          init_options = {
            procMacro = { enable = true },
          },
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>la", ":CodeActions<CR>", { buffer = bufnr })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
          end,
        },
      }
      require('rust-tools').setup(opts)
      require('rust-tools').inlay_hints.enable()
    end

  },

  { "wesQ3/vim-windowswap" },
  { "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120, -- Width of the floating window
        height = 25, -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },

  { "j-hui/fidget.nvim", -- LSP progress bar
    commit =  "0ba1e16d07627532b6cae915cc992ecac249fb97", -- tag: legacy
    config = function()
      require('fidget').setup {}
    end
  },

}

lvim.colorscheme = "gruvbox"
-- unable to set light theme on gruvbox bug:
-- https://github.com/LunarVim/LunarVim/issues/3844
-- as of 2023-02-25, this requires lunarvim master (2b1af90a97b8140de12a6d540c6bb8f5b615b0e6)
vim.opt.background = "light"

lvim.lsp.buffer_mappings.normal_mode["<leader>la"] = {
  function() vim.cmd(":CodeActions") end, "code action"
}
lvim.lsp.buffer_mappings.normal_mode["K"] = { vim.lsp.buf.hover, "Show documentation" }
-- lvim.lsp.buffer_mappings.normal_mode["<leader>lpd"] = {
--   function() require('goto-preview') end, ""
-- }

local cmp = require("cmp")
cmp.setup({
  completion = {
    -- -- don't get autocompletion popup all the time, only when manually invoked
    autocomplete = false,
  },
  -- mapping = cmp.mapping.preset.insert({
  --   ['<C-d>'] = cmp.mapping.scroll_docs( -4),
  --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --   ['<C-Space>'] = cmp.mapping.complete(),
  --   ['<CR>'] = cmp.mapping.confirm({ select = true }),
  -- }),
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  command = "set foldmethod=indent"
})


------------------------------------------------------------
-- custom config below
------------------------------------------------------------

-- disable custom tabs
lvim.builtin.bufferline.active = false

-- disable auto highlight of selected words.
lvim.builtin.illuminate.active = false

-- disable automatic insertion of closing symbol
-- it's nice, but when it fails (often), it's a nightmare
lvim.builtin.autopairs.active = false

-- When the page starts to scroll, keep the cursor 2 lines from the top and 2
-- lines from the bottom
vim.opt.scrolloff = 2

-- highlight some special characters (see listchars for help)
vim.opt.list = true


vim.keymap.set("n", "gD", "<C-]>")
vim.keymap.set("i", "<c-s>", "<esc>:update<cr>", { noremap = true })
vim.keymap.set("n", ",q", ":q<cr>")


-- " ] and [ aren't the most usable on bépo
vim.keymap.set("n", ")c", "]m")
vim.keymap.set("n", ")c", "]m")
vim.keymap.set("n", "(c", "[m")
vim.keymap.set("n", ")C", "]M")
vim.keymap.set("n", "(C", "[M")
vim.keymap.set("n", "))", "]]")
vim.keymap.set("n", "((", "[[")
vim.keymap.set("n", "«c", "[c")
vim.keymap.set("n", "»c", "]c")

vim.opt.lazyredraw = true

vim.keymap.set("n", "<c-n>", ":cnext!<cr>")
vim.keymap.set("n", "<c-p>", ":cprevious!<cr>")

vim.keymap.set("n", "<c-PageUp>", function()
  vim.diagnostic.goto_prev({})
end)

vim.keymap.set("n", "<c-PageDown>", function()
  vim.diagnostic.goto_next({})
end)


-- disable thin cursor in insert mode
vim.opt.guicursor = {}

vim.opt.foldlevel = 999
vim.opt.foldlevelstart = 999
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"


-- prevent default bindings
-- vim.g.windowswap_map_keys = 0


lvim.reload_config_on_save = false

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and
--       vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
--         col, col):match("%s") == nil
-- end

-- local cmp = require("cmp")
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       require("luasnip").lsp_expand(args.body)
--     end
--   },
--   mapping = cmp.mapping.preset.insert({
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       local luasnip = require "luasnip"
--       if cmp.visible() then
--         print("cmp visible here")
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         print("luasnip expand or jumpable here")
--         luasnip.expand_or_jump()
--       elseif has_words_before() then
--         print("has words before")
--         cmp.complete()
--       else
--         print("fallback")
--         fallback()
--       end
--     end, { "i", "s" }),

--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       local luasnip = require "luasnip"
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable( -1) then
--         luasnip.jump( -1)
--       else
--         fallback()
--       end
--     end, { "i", "s" })
--   })
-- })
