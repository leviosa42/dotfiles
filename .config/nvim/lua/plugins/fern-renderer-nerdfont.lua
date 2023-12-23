return {
    'lambdalisue/fern-renderer-nerdfont.vim',
    config = function()
      vim.cmd([[ let g:fern#renderer = 'nerdfont' ]])
    end,
    dependencies = { 'lambdalisue/fern.vim', 'lambdalisue/nerdfont.vim' }
}
