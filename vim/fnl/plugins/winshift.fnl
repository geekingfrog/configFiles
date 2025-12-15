{:plugins [:sindrets/winshift.nvim]
 :after (fn []
          (vim.keymap.set :n :<c-w><c-m> :<cmd>WinShift<cr> {:remap false})
          (vim.keymap.set :n :<c-w>m :<cmd>WinShift<cr> {:remap false}))}
