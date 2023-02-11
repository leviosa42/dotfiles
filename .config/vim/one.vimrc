set mapleader="\<Space>"

nnoremap j gj
nnoremap k gk

nnoremap H ^
nnoremap L $
nnoremap J 3j
nnoremap K 3k

nnoremap U <C-r>
nnoremap <C-r> U

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap <Space><Space> :setl relativenumber!<CR>

nnoremap <Leader>h :<C-u>set hlsearch!<CR>

nnoremap [window] <Nop>
nmap <Leader>w [window]
nnoremap [window]h <C-w>h
nnoremap [window]j <C-w>j
nnoremap [window]k <C-w>k
nnoremap [window]l <C-w>l
nnoremap [window]s :<C-u>split<CR>
nnoremap [window]v :<C-u>vsplit<CR>

nnoremap [terminal] <Nop>
nmap <Leader>x [terminal]
nnoremap [terminal]h :<C-u>vertical topleft  new<CR><Cmd>terminal<CR>
nnoremap [terminal]j :<C-u>belowleft new<CR>:<C-u>terminal<CR>
nnoremap [terminal]k :<C-u>aboveleft new<CR>:<C-u>terminal<CR>
nnoremap [terminal]l :<C-u>vertical botright new<CR>:<C-u>terminal<CR>

nmap <Leader>v [vimrc]
nnoremap [vimrc] <Nop>
nnoremap [vimrc]s :<C-u>source $MYVIMRC<CR>
nnoremap [vimrc]e :<C-u>edit $MYVIMRC<CR>
nnoremap [vimrc]t :<C-u>tabnew $MYVIMRC<CR>

