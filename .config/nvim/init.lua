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
-- * * Bootstrap: {{{zo
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
require("lazy").setup({
    {
        'vim-jp/vimdoc-ja',
        lazy = false
    },
    -- Filer: {{{
    {
        'lambdalisue/fern.vim',
        cmd = 'Fern',
        init = function()
            vim.api.nvim_set_keymap('n', '<Leader>f', '[fern]', {noremap = false, silent = true})
            vim.api.nvim_set_keymap('n', '[fern]', '<Cmd>:Fern . -reveal=% -drawer -toggle<CR>', {noremap = true, silent = true})
        end,
        config = function()
            vim.api.nvim_exec([[
                " [lambdalisue/fern.vim]
                let g:fern#default_hidden = 1
                function! s:init_fern() abort
                  " Use 'select' instead of 'edit' for default 'open' action
                  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
                endfunction
                augroup fern-custom
                  autocmd! *
                  autocmd FileType fern call s:init_fern()
                augroup END
                " [lambdalisue/fern-renderer-nerdfont.vim]
                let g:fern#renderer = 'nerdfont'
                " [yuki-yano/fern-preview.vim]
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
            ]], false)
        end,
        dependencies = {
            'lambdalisue/fern-renderer-nerdfont.vim',
            'lambdalisue/nerdfont.vim',
            'yuki-yano/fern-preview.vim'
        }
    },
    -- }}}
    -- ColorSchemes: {{{
    {
        'folke/tokyonight.nvim',
        lazy = false,
        -- priority = 1000,
        config = function()
            require('tokyonight').setup({
                style = 'storm', -- storm/moon/night/day
                light_style = 'light',
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                    sidebars = 'dark', -- dark/transparent/normal
                    floats = 'dark' -- dark/transparent/normal
                },
                sidebars = { 'qf', 'help' },
                day_brightness = 0.3,
                hide_interactive_statusline = false,
                dim_inactive = false,
                lualine_bold = false
            })
            -- vim.cmd([[colorscheme tokyonight]])
            -- vim.o.background = 'dark'
        end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        -- priority = 1000,
        config = function()
            require('kanagawa').setup({
                undercurl = true,           -- enable undercurls
                commentStyle = { italic = false },
                functionStyle = {},
                keywordStyle = { italic = false},
                statementStyle = { bold = true },
                typeStyle = {},
                variablebuiltinStyle = { italic = false },
                specialReturn = true,       -- special highlight for the return keyword
                specialException = true,    -- special highlight for exception handling keywords
                transparent = false,        -- do not set background color
                dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
                globalStatus = false,       -- adjust window separators highlight for laststatus=3
                terminalColors = true,      -- define vim.g.terminal_color_{0,17}
                colors = {},
                overrides = {},
                theme = "default"           -- Load "default" theme or the experimental "light" theme
            })
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup()
            vim.cmd('colorscheme rose-pine')
        end
    }
    -- }}}
})
-- * * }}}
-- * }}}
-- * Options: {{{
-- * * General: {{{
-- * * * Encoding: {{{
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
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
-- * * }}}
-- * * Editing: {{{
vim.o.backspace = 'indent,eol,start'
-- }}}
-- * * Appearance: {{{
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
-- * * }}}
-- * }}}
-- * Mappings: {{{
-- * * Leader: {{{
-- vim.g.mapleader = ' '
-- * * }}}
-- * * Misc: {{{
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Space><Space>', '<Cmd>:setl relativenumber!<CR>', {noremap = true, silent = false})

vim.api.nvim_set_keymap('n', '<Leader>h', '<Cmd>:setl hlsearch!<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true, silent = false})
-- }}}
-- * * [window]: {{{
vim.api.nvim_set_keymap('n', '<Leader>w', '[window]', {noremap = false, silent = false})
vim.api.nvim_set_keymap('n', '[window]v', '<Cmd>:vsplit<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[window]s', '<Cmd>:split<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[window]h', '<C-w>h', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[window]j', '<C-w>j', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[window]k', '<C-w>k', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[window]l', '<C-w>l', {noremap = true, silent = false})
-- * * }}}
-- * * [tab]: {{{
vim.api.nvim_set_keymap('n', '<Leader>t', '[tab]', {noremap = false, silent = false})
vim.api.nvim_set_keymap('n', '[tab]h', '<Cmd>:tabprevious<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[tab]l', '<Cmd>:tabnext<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[tab]n', '<Cmd>:tabnew<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[tab]c', '<Cmd>:tabclose<CR>', {noremap = true, silent = false})
-- * * }}}
-- * * [vimrc]: {{{
vim.api.nvim_set_keymap('n', '<Leader>v', '[vimrc]', {noremap = false, silent = false})
vim.api.nvim_set_keymap('n', '[vimrc]e', '<Cmd>:e $MYVIMRC<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[vimrc]s', '<Cmd>:so $MYVIMRC<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[vimrc]t', '<Cmd>:tabnew $MYVIMRC<CR>', {noremap = true, silent = false})
-- * * }}}
-- * }}}
-- * Plugin: {{{
-- * }}}

-- vim: set ft=lua ts=4 sts=-1 sw=0 et ai si fdm=marker:



