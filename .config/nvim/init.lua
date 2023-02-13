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
-- vim.opt.shellslash = true
-- fern.vim/lambdalisue: Disable fern with shellslash option #426
vim.opt.shellslash = false
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
vim.o.guifont = 'PlemolJP Console NF:h13'
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
vim.o.ambiwidth = 'single'
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
-- * * * }}}
-- * * }}}
-- * }}}
-- * Mappings: {{{
-- * * functions: {{{
local function merge(t1, t2)
    for k,v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

-- local function map(mode, lhs, rhs, opts)
-- vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {})
-- end

-- local function noremap(mode, lhs, rhs, opts)
-- vim.api.nvim_set_keymap(mode, lhs, rhs, merge({ noremap = true }, opts or {}))
-- end
local map = vim.keymap.set
-- * }}}
-- * * Leader: {{{
-- vim.g.mapleader = ' '
-- * * }}}
-- * * Misc: {{{
map('n', 'j', 'gj', { silent = true })
map('n', 'k', 'gk', { silent = true })

map('n', '<Space><Space>', '<Cmd>setl relativenumber!<CR>', { silent = true })

map('n', 'H', '^', { silent = true })
map('n', 'L', '$', { silent = true })

map('n', 'J', '3j')
map('n', 'K', '3k')

map('n', 'U', '<C-r>', { silent = true })
map('n', '<C-r>', 'U', { silent = true })

map('n', '<Leader>h', '<Cmd>setl hlsearch!<CR>', { silent = false })
map('i', 'jk', '<Esc>', { silent = false })
map('t', '<Esc>', '<C-\\><C-n>', { silent = false })

map('i', '<C-h>', '<Left>', { silent = true })
map('i', '<C-j>', '<Down>', { silent = true })
map('i', '<C-k>', '<Up>', { silent = true })
map('i', '<C-l>', '<Right>', { silent = true })

-- https://qiita.com/Lennon_x00x_/items/e8fa47d27aaab9635161
map('t', '<C-w>j', '<Cmd>wincmd j<CR>')
map('t', '<C-w>k', '<Cmd>wincmd k<CR>')

map('n', 'x', '"_x')
-- * * }}}
-- * * [buffer]: {{{
map('n', '<Leader>b', '[buffer]', { remap = true })
map('n', '[buffer]k', '<cmd>bprev<CR>')
map('n', '[buffer]j', '<cmd>bnext<CR>')
map('n', '[buffer]l', '<cmd>ls<CR>')
map('n', '[buffer]L', '<cmd>ls!<CR>')
-- * * }}}
-- * * [window]: {{{
map('n', '<Leader>w', '[window]', { remap = true })
map('n', '[window]v', '<Cmd>vsplit<CR>')
map('n', '[window]s', '<Cmd>split<CR>')
map('n', '[window]h', '<C-w>h')
map('n', '[window]j', '<C-w>j')
map('n', '[window]k', '<C-w>k')
map('n', '[window]l', '<C-w>l')
map('n', '[window]o', '<cmd>only<CR>')
-- * * }}}
-- * * [tab]: {{{
map('n', '<Leader>t', '[tab]', { remap = true })
map('n', '[tab]h', '<Cmd>tabprevious<CR>')
map('n', '[tab]l', '<Cmd>tabnext<CR>')
map('n', '[tab]n', '<Cmd>tabnew<CR>')
map('n', '[tab]c', '<Cmd>tabclose<CR>')
-- * * }}}
-- * * [vimrc]: {{{
map('n', '<Leader>v', '[vimrc]', { remap = true })
map('n', '[vimrc]e', '<Cmd>e $MYVIMRC<CR>')
map('n', '[vimrc]s', '<Cmd>so $MYVIMRC<CR>')
map('n', '[vimrc]t', '<Cmd>tabnew $MYVIMRC<CR>')
-- * * }}}
-- * * [terminal]: {{{
-- wip...
-- map('n', '<Leader>x', '<Plug>(terminal)')
map('n', '<Leader>x', '[terminal]', { remap = true })
-- noremap('n', 'v', '<Cmd>vertical new<CR><Cmd>terminal<CR>')
map('n', '[terminal]h', '<Cmd>vertical aboveleft new<CR><Cmd>terminal<CR>')
map('n', '[terminal]j', '<Cmd>rightbelow new<CR><Cmd>terminal<CR>')
map('n', '[terminal]k', '<Cmd>aboveleft new<CR><Cmd>terminal<CR>')
map('n', '[terminal]l', '<Cmd>vertical rightbelow new<CR><Cmd>terminal<CR>')
map('n', '[terminal]H', '<Cmd>vertical topleft new<CR><Cmd>terminal<CR>')
map('n', '[terminal]J', '<Cmd>botright new<CR><Cmd>terminal<CR>')
map('n', '[terminal]K', '<Cmd>topleft new<CR><Cmd>terminal<CR>')
map('n', '[terminal]L', '<Cmd>vertical botright new<CR><Cmd>terminal<CR>')
-- * * [comment]: {{{
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
map('n', '<Leader>c', '[comment]', { remap =  true })
map('n', '[comment]i', '<Cmd>call CommentIn()<CR>')
map('n', '[comment]o', '<Cmd>call CommentOut()<CR>')
-- * * }}}
-- * }}}
-- * }}}
-- vim: set ft=lua ts=4 sts=-1 sw=0 et ai si fdm=marker:
