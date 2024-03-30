local plugins = {
  -- help for ja
  require('plugins/vimdoc-ja'),
  -- language support
  require('plugins/vim-polyglot'),
  -- vim-commentary
  require('plugins/vim-commentary'),
  -- markonm/traces.vim
  require('plugins/traces'),
  -- telescope
  require('plugins/telescope'),
  -- indentline
  require('plugins/indent-blankline'),
  -- mini.nvim
  require('plugins/mini'),
  -- colorscheme
  -- require('plugins/github-nvim-theme'),
  -- require('plugins/catppuccin'),
  -- require('plugins/kanagawa'),
  -- require('plugins/gruvbox'),
  -- require('plugins/tokyonight'),
  -- filer
  require('plugins/fern'),
  require('plugins/fern-renderer-nerdfont'), -- support nerdfont
  require('plugins/fern-preview'), -- preview files
  -- fold
  require('plugins/pretty-fold'),
  -- lsp
  require('plugins/nvim-treesitter'),
  -- require('plugins/mason'),
  require('plugins/nvim-lspconfig'),
  -- statusline
  require('plugins/lualine'),
  -- copilot
  require('plugins/copilot'),
  -- colorizer
  require('plugins/nvim-colorizer'),
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup(plugins)
