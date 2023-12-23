return {
	'lambdalisue/fern.vim',
  	config = function()
        vim.keymap.set('n', '[edit]e', '<Cmd>Fern . -drawer -toggle -keep<CR>', { noremap = true })
        vim.keymap.set('n', '[edit]d', '<Cmd>Fern %:h -drawer -toggle -keep<CR>', { noremap = true })
        vim.cmd([[
            let g:fern#default_hidden = 1
            function! Fern_settings() abort
              " https://github.com/lambdalisue/fern.vim/issues/270#issuecomment-740257133
              setlocal nornu nonu nolbr signcolumn=no foldcolumn=0
              " my custom mapping
              nmap <silent> <buffer> H <Plug>(fern-action-leave)
              nmap <silent> <buffer> L <Plug>(fern-action-open-or-expand)
            endfunction

            augroup fern-settings
              autocmd!
              autocmd FileType fern call Fern_settings()
            augroup END
        ]])
    end,
  -- dependencies = { 'lambdalisue/fern-renderer-nerdfont.vim ' }
}
-- vim: ft=lua ts=4 sw=4 sts=-1 et:
