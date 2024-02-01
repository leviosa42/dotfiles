-- * Key Mapping: {{{
vim.g.mapleader = ' '

-- * * Misc: {{{
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', 'U', '<C-r>', { noremap = true })
vim.keymap.set('n', '<C-r>', 'U', { noremap = true })
-- * * }}}
-- * * [buffer]: {{{
vim.keymap.set('n', '<Leader>b', '[buffer]', { remap = true })
vim.keymap.set('n', '[buffer]', '<Nop>', { noremap = true })
vim.keymap.set('n', '[buffer]n', '<Cmd>new<CR>', { noremap = true })
vim.keymap.set('n', '[buffer]j', '<Cmd>bnext<CR>', { noremap = true })
vim.keymap.set('n', '[buffer]k', '<Cmd>bprev<CR>', { noremap = true })
vim.keymap.set('n', '[buffer]l', '<Cmd>ls<CR>', { noremap = true })
vim.keymap.set('n', '[buffer]L', '<Cmd>ls!<CR>', { noremap = true })
-- * * }}}
-- * * [edit]: {{{
vim.keymap.set('n', '<Leader>e', '[edit]', { remap = true })
vim.keymap.set('n', '[edit]', '<Nop>', { noremap = true })
-- * * }}}
-- * * [window]: {{{
vim.keymap.set('n', '<Leader>w', '[window]', { remap = true })
vim.keymap.set('n', '[window]', '<Nop>', { noremap = true })
vim.keymap.set('n', '[window]h', '<C-w>h', { noremap = true })
vim.keymap.set('n', '[window]j', '<C-w>j', { noremap = true })
vim.keymap.set('n', '[window]k', '<C-w>k', { noremap = true })
vim.keymap.set('n', '[window]l', '<C-w>l', { noremap = true })
vim.keymap.set('n', '[window]s', '<Cmd>split<CR>', { noremap = true})
vim.keymap.set('n', '[window]v', '<Cmd>vsplit<CR>', { noremap = true})
vim.keymap.set('n', '[window]o', '<Cmd>only<CR>', { noremap = true})
-- * * }}}
-- * * [settings]: {{{
vim.keymap.set('n', '<Leader>v', '[settings]', { remap = true })
vim.keymap.set('n', '[settings]', '<Nop>', { noremap = true })
vim.keymap.set('n', '[settings] ', '<Cmd>Fern $XDG_CONFIG_HOME/nvim/ -drawer -toggle -keep<CR>', { noremap = true })
vim.keymap.set('n', '[settings]b', '<Cmd>edit $XDG_CONFIG_HOME/nvim/lua/base.lua<CR>', { noremap = true })
vim.keymap.set('n', '[settings]k', '<Cmd>edit $XDG_CONFIG_HOME/nvim/lua/keymap.lua<CR>', { noremap = true })
vim.keymap.set('n', '[settings]p', '<Cmd>edit $XDG_CONFIG_HOME/nvim/lua/plugin.lua<CR>', { noremap = true })
vim.keymap.set('n', '[settings]p', '<Cmd>edit $XDG_CONFIG_HOME/nvim/lua/plugin.lua<CR>', { noremap = true })
-- TODO: Avoid hardcoding
vim.keymap.set('n', '[settings]P', '<Cmd>Fern $XDG_CONFIG_HOME/nvim/lua/plugins -drawer -toggle -keep<CR>', { noremap = true })
vim.keymap.set('n', '[settings]s', '<Cmd>source $MYVIMRC<CR>', { noremap = true })
vim.keymap.set('n', '[settings]-', function()
   -- https://stackoverflow.com/questions/72412720/how-to-source-init-lua-without-restarting-neovim
  for k,_ in pairs(package.loaded) do
    if k:match('^user') and not name:match('nvim-tree') then
      package.loaded[value] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('configuration reloaded!!', vim.log.levels.INFO)
end, { noremap = true })
-- * * }}}
-- * }}}
-- vim: ft=lua ts=2 sw=0 sts=-1 et fdm=marker fmr={{{,}}}:
