set nu
set mouse=a
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

""
"vim-plug
""
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'}
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/taglist-plus'
Plug 'suan/vim-instant-markdown'
call plug#end()
