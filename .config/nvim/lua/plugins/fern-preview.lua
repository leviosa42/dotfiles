return {
    'yuki-yano/fern-preview.vim',
    config = function()
        vim.cmd([[
          function! s:fern_settings() abort
            nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
            nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
            nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
            nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
          endfunction
          
          augroup fern-settings
            autocmd!
            autocmd FileType fern call s:fern_settings()
          augroup END
        ]])
        -- vim.keymap.set('n', 'p', '<Plug>fern-action-preview:toggle)', { remap = true, silent = true, buffer = true })
        -- vim.keymap.set('n', '<C-p>', '<Plug>fern-action-preview:auto:toggle)', { remap = true, silent = true, buffer = true })
        -- vim.keymap.set('n', '<C-d>', '<Plug>fern-action-preview:scroll:down:half)', { remap = true, silent = true, buffer = true })
        -- vim.keymap.set('n', '<C-u>', '<Plug>fern-action-preview:scroll:up:half)', { remap = true, silent = true, buffer = true })
    end,
    dependencies = { 'lambdalisue/fern.vim'}
}
