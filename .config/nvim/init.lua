--  _       _ _     _              --
-- (_)_ __ (_) |_  | |_   _  __ _  --
-- | | '_ \| | __| | | | | |/ _` | --
-- | | | | | | |_ _| | |_| | (_| | --
-- |_|_| |_|_|\__(_)_|\__,_|\__,_| --
--                                 --

-- * Pre Init: {{{
-- * * XDG Base Directory: {{{
if vim.fn.empty(vim.fn.getenv('XDG_CONFIG_HOME')) > 0 then
    vim.env.XDG_CONFIG_HOME = vim.fn.expand('$HOME/.config')
end
if vim.fn.empty(vim.fn.getenv('XDG_DATA_HOME')) > 0 then
    vim.env.XDG_DATA_HOME = vim.fn.expand('$HOME/.local/share')
end
if vim.fn.empty(vim.fn.getenv('XDG_CACHE_HOME')) > 0 then
    vim.env.XDG_CACHE_HOME = vim.fn.expand('$HOME/.cache')
end
if vim.fn.empty(vim.fn.getenv('XDG_STATE_HOME')) > 0 then
    vim.env.XDG_STATE_HOME = vim.fn.expand('$HOME/.local/state')
end
-- * * }}}
-- * }}}
-- * Plugin Manager: {{{
-- * * Bootstrap: {{{
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
-- * * }}}
-- * * Setup Plugins: {{{
vim.g.mapleader = ' '
local plugins = require('plugins')
require("lazy").setup(plugins)
-- * * }}}
-- * * {{{
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    pattern = '*',
    callback = function()
        vim.cmd.colorscheme('github_dimmed')
    end
})
-- * * }}}
-- * }}}
-- * Options: {{{
-- * * General: {{{
-- * * * Encoding: {{{
vim.o.encoding = 'utf-8'
-- vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = 'utf-8,iso-8859-1,cp1252,sjis,euc-jp'
-- * * * }}}
-- * * * Format: {{{
vim.o.fileformat = 'unix'
vim.o.fileformats = 'unix,dos,mac'
-- * * * }}}
-- * * * Indent: {{{
vim.o.tabstop = 4
vim.o.softtabstop = -1
vim.o.shiftwidth = 0
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
-- * * * }}}
-- * * * Clipboard: {{{
vim.o.clipboard = 'unnamed,unnamedplus'
-- * * * }}}
vim.opt.whichwrap = 'b,s,<,>,[,]'
-- * * }}}
-- * * Editing: {{{
vim.o.backspace = 'indent,eol,start'
-- }}}
-- * * Appearance: {{{
-- * * * guifont: {{{
vim.o.guifont = 'PlemolJP Console NF'
-- * * * }}}
-- * * * Misc: {{{
-- colorscheme
-- vim.cmd.colorscheme('habamax')
-- vim.o.background = 'dark'
vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = true
vim.o.showmode = true
vim.o.showcmd = true
vim.o.ruler = true
vim.o.laststatus = 2
-- * * * }}}
-- * * * FoldText: {{{
vim.api.nvim_exec([[
    function! MyFoldText() abort
        let line = getline(v:foldstart)

        let nucolwidth = &fdc + &number * &numberwidth
        let windowwidth = winwidth(0) - nucolwidth - 4
        let foldedlinecount = v:foldend - v:foldstart

        " expand tabs into spaces

        let line = strpart(line, 0, windowwidth - len(foldedlinecount))
        let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
        return line . repeat("･",fillcharcount) . '･･･' . foldedlinecount  . ' '
    endfunction
    set foldtext=MyFoldText()
]], false)
-- * * * }}}
-- * * * Terminal: {{{
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
    pattern = { '*' },
    callback = function()
        vim.cmd.startinsert()
    end
})
vim.api.nvim_create_autocmd({ 'TermOpen', 'TermEnter' }, {
    pattern = { '*' },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end
})
vim.api.nvim_create_autocmd({ 'TermLeave' }, {
    pattern = { '*' },
    callback = function()
        vim.wo.number = true
        vim.wo.relativenumber = false
    end
})
-- * * * }}} fh
-- * * }}}
-- * }}}
-- * Mappings: {{{
-- * * Leader: {{{
-- vim.g.mapleader = ' '
-- * * }}}
-- * * Misc: {{{
local nvkmap = vim.api.nvim_set_keymap
nvkmap('n', 'j', 'gj', { noremap = true, silent = true })
nvkmap('n', 'k', 'gk', { noremap = true, silent = true })
nvkmap('n', '<Space><Space>', '<Cmd>:setl relativenumber!<CR>', { noremap = true, silent = false })

nvkmap('n', 'H', '^', { noremap = true, silent = false })
nvkmap('n', 'L', '$', { noremap = true, silent = false })

-- nvkmap('n', 'J', 'L', { noremap = true, silent = false })
nvkmap('n', 'J', '3j', { noremap = true, silent = false })
-- nvkmap('n', 'K', 'H', { noremap = true, silent = false })
nvkmap('n', 'K', '3k', { noremap = true, silent = false })

nvkmap('n', 'U', '<C-r>', { noremap = true, silent = true })
nvkmap('n', '<C-r>', 'U', { noremap = true, silent = true })

nvkmap('n', '<Leader>h', '<Cmd>:setl hlsearch!<CR>', { noremap = true, silent = false })
nvkmap('i', 'jk', '<Esc>', { noremap = true, silent = false })
nvkmap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = false })

nvkmap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
nvkmap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
nvkmap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
nvkmap('i', '<C-l>', '<Right>', { noremap = true, silent = true })
-- }}}
-- * * [window]: {{{
nvkmap('n', '<Leader>w', '[window]', { noremap = false, silent = false })
nvkmap('n', '[window]v', '<Cmd>:vsplit<CR>', { noremap = true, silent = false })
nvkmap('n', '[window]s', '<Cmd>:split<CR>', { noremap = true, silent = false })
nvkmap('n', '[window]h', '<C-w>h', { noremap = true, silent = false })
nvkmap('n', '[window]j', '<C-w>j', { noremap = true, silent = false })
nvkmap('n', '[window]k', '<C-w>k', { noremap = true, silent = false })
nvkmap('n', '[window]l', '<C-w>l', { noremap = true, silent = false })
-- * * }}}
-- * * [tab]: {{{
nvkmap('n', '<Leader>t', '[tab]', { noremap = false, silent = false })
nvkmap('n', '[tab]h', '<Cmd>:tabprevious<CR>', { noremap = true, silent = false })
nvkmap('n', '[tab]l', '<Cmd>:tabnext<CR>', { noremap = true, silent = false })
nvkmap('n', '[tab]n', '<Cmd>:tabnew<CR>', { noremap = true, silent = false })
nvkmap('n', '[tab]c', '<Cmd>:tabclose<CR>', { noremap = true, silent = false })
-- * * }}}
-- * * [vimrc]: {{{
nvkmap('n', '<Leader>v', '[vimrc]', { noremap = false, silent = false })
nvkmap('n', '[vimrc]e', '<Cmd>:e $MYVIMRC<CR>', { noremap = true, silent = false })
nvkmap('n', '[vimrc]s', '<Cmd>:so $MYVIMRC<CR>', { noremap = true, silent = false })
nvkmap('n', '[vimrc]t', '<Cmd>:tabnew $MYVIMRC<CR>', { noremap = true, silent = false })
-- * * }}}
-- * * [terminal]: {{{
-- wip...
nvkmap('n', '<Leader>x', '[terminal]', { noremap = false, silent = false })
nvkmap('n', '[terminal]v', '<Cmd>vertical new<CR><Cmd>terminal<CR>', { noremap = true, silent = false })
nvkmap('n', '[terminal]h', '<Cmd>vertical topleft new<CR><Cmd>terminal<CR>',
    { noremap = true, silent = false })
nvkmap('n', '[terminal]j', '<Cmd>belowright new<CR><Cmd>terminal<CR>', { noremap = true, silent = false })
nvkmap('n', '[terminal]k', '<Cmd>aboveleft new<CR><Cmd>terminal<CR>', { noremap = true, silent = false })
nvkmap('n', '[terminal]l', '<Cmd>vertical botright new<CR><Cmd>terminal<CR>',
    { noremap = true, silent = false })
-- https://qiita.com/Lennon_x00x_/items/e8fa47d27aaab9635161
nvkmap('t', '<C-w>j', '<Cmd>wincmd j<CR>', { noremap = true, silent = false })
nvkmap('t', '<C-w>k', '<Cmd>wincmd k<CR>', { noremap = true, silent = false })
-- * * }}}
-- * * [comment]: {{{
vim.api.nvim_exec([[
function! CommentIn() abort
  " ref: https://vim-jp.org/vim-users-jp/2009/09/20/Hack-75.html
  " \%(^\s*\|^\t*\)\@<=\S
  call setline(line('.'), substitute(getline('.'), '\%(^\s*\|^\t*\)\@<=\(\S.*\)', printf(&cms, '\1'), ''))
  "echo substitute(getline('.'), '\%(^\s*\|^\t*\)\@<=\(\S.*\)', '" \1', '')
endfunction

function! CommentOut() abort
  "echo substitute(getline('.'), printf(&cms, ''), '', '')
  call setline(line('.'), substitute(getline('.'), printf(&cms, ''), '', ''))
endfunction
]], false)
nvkmap('n', '<Leader>c', '[comment]', { noremap = false, silent = false })
nvkmap('n', '[comment]i', '<Cmd>:call CommentIn()<CR>', { noremap = true, silent = true })
nvkmap('n', '[comment]o', '<Cmd>:call CommentOut()<CR>', { noremap = true, silent = true })
-- * * }}}
-- * }}}

--
-- vim: set ft=lua ts=4 sts=-1 sw=0 et ai si fdm=marker:
