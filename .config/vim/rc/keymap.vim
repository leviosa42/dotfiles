" === key mapping ===
let g:mapleader = "\<Space>"

inoremap <silent> jk <Esc>

nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap U <C-r>
nnoremap <C-r> U

nnoremap x "_x

nnoremap <silent> <S-Up> "zdd<Up>"zP
nnoremap <silent> <S-Down> "zdd"zp
vnoremap <S-Up> "zx<Up>"zP`[V`]
vnoremap <S-Down> "zx"zp`[V`]

nnoremap <Leader>h :nohlsearch<CR>

" --- [buffer] ---
nmap <Leader>b [buffer]
nnoremap [buffer] <Nop>

nnoremap [buffer]n :new<CR>
nnoremap [buffer]j :bnext<CR>
nnoremap [buffer]k :bprevious<CR>
nnoremap [buffer]l :ls<CR>

" --- [edit] ---
nmap <Leader>e [edit]

" --- [vimrc] ---
nmap <Leader>v [vimrc]
nnoremap [vimrc]s :source $MYVIMRC<CR>
nnoremap [vimrc]e :edit $MYVIMRC<CR>

" --- terminal ---
nmap <Leader>x [terminal]
nnoremap [terminal]h :vertical aboveleft terminal<CR>
nnoremap [terminal]j :rightbelow terminal<CR>
nnoremap [terminal]k :aboveleft terminal<CR>
nnoremap [terminal]l :vertical rightbelow terminal<CR>
nnoremap [terminal]<Space> :terminal ++curwin<CR>

" --- window ---
nmap <Leader>w [window]
nnoremap [window] <C-w>

