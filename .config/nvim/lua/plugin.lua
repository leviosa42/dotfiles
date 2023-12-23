local plugins = {
  -- help for ja
  require('plugins/vimdoc-ja'),
  -- telescope
  require('plugins/telescope'),
  -- colorscheme
  require('plugins/github-nvim-theme'),
  -- filer
  require('plugins/fern'),
  require('plugins/fern-renderer-nerdfont'), -- support nerdfont
  require('plugins/fern-preview'), -- preview files
  -- lsp
  require('plugins/nvim-treesitter'),
  -- require('plugins/mason'),
  -- statusline
  require('plugins/lualine'),
  -- copilot
  require('plugins/copilot'),
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
