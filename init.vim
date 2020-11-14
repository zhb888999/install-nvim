set nu
set mouse=a
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

let mapleader=" "

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

nnoremap <silent> <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>y "+y
nnoremap <silent> <TAB> <C-w>w

inoremap <silent> <C-a> <ESC>I
inoremap <silent> <C-d> <ESC>lxi
inoremap <silent> <C-q> <ESC>
inoremap <silent> <C-l> <ESC>la
inoremap <silent> <C-v> <ESC>"+pa

""""""""""""
" vim-plug "
""""""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}         "代码补全
Plug 'mhinz/vim-startify'                               "开始界面
Plug 'voldikss/vim-floaterm'                            "浮动窗口终端
Plug 'preservim/nerdcommenter'                          "代码补全
Plug 'Yggdroot/indentLine'                              "代码缩进标识
Plug 'vim-airline/vim-airline'                          "状态栏美化
Plug 'suan/vim-instant-markdown'                        "markdown文件浏览器预览
Plug 'gcmt/wildfire.vim'                                "回车选取代码块
Plug 'tpope/vim-surround'                               "包裹更改
Plug 'junegunn/fzf.vim'                                 "fzf
call plug#end()

""""""""""""
" coc-nvim "
""""""""""""
let g:coc_global_extensions = ['coc-python', 'coc-json', 'coc-go', 
                            \ 'coc-vimlsp', 'coc-ccls', 'coc-pairs', 
                            \ 'coc-snippets', 'coc-git', 'coc-explorer',
                            \ 'coc-marketplace', 'coc-sh', 'coc-tsserver',
                            \ 'coc-html', 'coc-css', 'coc-floaterm',
                            \ 'coc-translator']
set hidden
set updatetime=100
set shortmess+=c

" 行号报错提示合并
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"打开补全提示
inoremap <silent><expr> <c-n> coc#refresh()
"上下查找代码报错
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"函数跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"显示帮助文档
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"同词提示
autocmd CursorHold * silent call CocActionAsync('highlight')
"变量重命名
nmap <leader>rn <Plug>(coc-rename)
"代码格式化 
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"" Remap <C-f> and <C-b> for scroll float windows/popups.
"" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
"nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

"" NeoVim-only mapping for visual mode scroll
"" Useful on signatureHelp after jump placeholder of snippet expansion
"if has('nvim')
  "vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  "vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
"endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> \s <Plug>(coc-range-select)
xmap <silent> \s <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""
" coc-explorer "
""""""""""""""""
nnoremap <leader>e :CocCommand explorer<CR>

""""""""""""""""""
" coc-translator "
""""""""""""""""""
nmap <Leader>t <Plug>(coc-translator-e)
vmap <Leader>t <Plug>(coc-translator-ev)

"""""""""""""""""""""""""
" voldikss/vim-floaterm "
"""""""""""""""""""""""""
nnoremap <silent> <leader>w :FloatermNew<CR>
tnoremap <silent> [w <C-\><C-n>:FloatermNew<CR>
nnoremap <silent> <leader><TAB> :FloatermToggle<CR>
tnoremap <silent> [<TAB> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> ]] <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> [[ <C-\><C-n>:FloatermPrev<CR>

"""""""""""""""""""""
" gcmt/wildfire.vim "
"""""""""""""""""""""
let g:wildfire_objects = {"*" : ["i'", 'i"', "i)", "i]", "i}", "i>", "ip", "it", "iw",
                               \ "a'", 'a"', "a)", "a]", "a}", "a>", "ap", "at"]}
"""""""
" fzf "
"""""""
nnoremap \f :Files ~<CR>
nnoremap \c :Colors<CR>
