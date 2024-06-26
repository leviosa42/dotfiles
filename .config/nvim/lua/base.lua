vim.env.MYVIMRC = vim.fn.expand('<sfile>')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- NOTE: on docker, vim.env.SHELL was nil
local shell = nil
if vim.fn.exists('$SHELL') then
  vim.o.shell = vim.env.SHELL
elseif vim.fn.has('win64') then
   vim.o.shell = 'nyagos'
else
  vim.o.shell = vim.env.SHELL or '/bin/bash'
end
vim.opt.shellcmdflag = string.find(vim.o.shell, 'nyagos') and '-c' or vim.opt.shellcmdflag
vim.o.undofile = true
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath('data') .. ( vim.fn.has('win64') and '\\backup\\\\' or '/backup' )


-- * Appearance: {{{
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showcmd = true
vim.opt.showmatch = true

vim.opt.termguicolors = true

-- vim.cmd [[colorscheme lunaperche]]
-- * * listchars: {{{
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  -- eol = '↲',
  nbsp = '␣',
  trail = '•',
  extends = '⟩',
  precedes = '⟨',
}
-- * * }}}
-- * * foldtext: {{{
vim.cmd [[
  function! MyFoldText() abort
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 5
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . '..' . foldedlinecount  . ' '
  endfunction
  set foldtext=MyFoldText()
]]
-- * * }}}
-- * }}}

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.expandtab = true

-- vim.opt.clipboard = 'unnamedplus'
-- vim: ft=lua ts=2 sw=0 sts=-1 et fdm=marker fmr={{{,}}}:
