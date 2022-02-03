" --- key bindings -------------------------------------------------------------------

set pastetoggle=<f5>
let mapleader = "\<Space>"

inoremap jk <ESC>

nnoremap & :&&<CR>
xnoremap & :&&<CR>

noremap <leader>nt :tabnew<CR>
noremap <leader>ct :tabclose<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-q> :qa<CR>
inoremap <C-q> <ESC>:qa<CR>
" Switch between recently edited buffers (Mastering Vim Quickly)
  nnoremap <C-b> <C-^>
  inoremap <C-b> <ESC><C-^>

nnoremap <leader>f :FZF<CR>

" Map Esc to normal mode in terminal mode
tnoremap <leader><ESC> <C-\><C-n>

" make . work with visually selected lines
vnoremap . :normal.<CR>

" Center next/previous matches on the screen (Mastering Vim Quickly)
nnoremap n nzz
nnoremap N Nzz

" -- Move lines with single key combo (Mastering Vim Quickly)
  " Normal mode
  nnoremap <C-j> :m .+1<CR>==
  nnoremap <C-k> :m .-2<CR>==

  " Insert mode
  inoremap <C-j> <ESC>:m .+1<CR>==gi
  inoremap <C-k> <ESC>:m .-2<CR>==gi

  " Visual mode
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv

