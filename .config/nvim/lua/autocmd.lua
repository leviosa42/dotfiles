vim.cmd([[
  augroup autocmds
    autocmd!
    " Open terminal-mode in insert mode
    autocmd TermOpen * startinsert
  augroup END
]]) 
