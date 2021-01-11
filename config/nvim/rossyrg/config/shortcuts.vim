" vim:foldlevel=0
" vim:foldmethod=marker

" Leadermaps {{{
" Unite {{{
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Vista finder<CR>
" }}}

" Vimwiki {{{
nnoremap <leader>lt :VimtexTocToggle<CR>
" }}}

" Toggles {{{
nnoremap <leader>n] :Vista!!<CR>
""" Concealhelper {{{
function! ConcealToggle()
    if (&conceallevel == 0)
        set conceallevel=2
    else
        set conceallevel=0
    endif
endfunction
""" }}}
""" foldcolumnhelper {{{
function! FoldcolumnToggle()
    if (&foldcolumn == 0)
        set foldcolumn=2
    else
        set foldcolumn=0
    endif
endfunction
""" }}}
nnoremap <leader>nc :call ConcealToggle()<CR>
nnoremap <leader>nf :call FoldcolumnToggle()<CR>
nnoremap <leader>fe :Defx<CR>
nnoremap <leader>ng :TableModeToggle<CR>
""" }}}

"" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)
""" }}}

""" \Leadermaps }}}

" Vimwiki {{{
inoremap <silent> <buffer> <C-,> <ESC>:call Toggle_task_status()<CR>i
noremap <silent> <buffer> <C-,> :call Toggle_task_status()<CR>
" }}}

" ctags TODO: Filetypespezifisch {{{
map <leader>r :!ctags -R; find -L . -name "*.c" -o -name "*.cc" -o -name "*.hpp" -o -name "*.hh" -o -name "*.h" -o -name "*.cpp" -o -name "*.java" -o -name "*.rb" <BAR> cscope -Rb -i-<CR>:cs reset<CR>
" }}}

" Allow sudo saving {{{
cmap w!! w !sudo tee > /dev/null %
" }}}

" Utility {{{
noremap <F4> :.!fmt<CR>
" }}}

" Terminal {{{
tnoremap <A-\> <C-\><C-n>
" }}}

" Windows {{{
" let g:tmux_navigator_no_mappings = 1

nnoremap <A-h> :TmuxNavigateLeft<cr>
nnoremap <A-j> :TmuxNavigateDown<cr>
nnoremap <A-k> :TmuxNavigateUp<cr>
nnoremap <A-l> :TmuxNavigateRight<cr>
nnoremap <A-\> :TmuxNavigatePrevious<cr>
tnoremap <A-h> :TmuxNavigateLeft<cr>
tnoremap <A-j> :TmuxNavigateDown<cr>
tnoremap <A-k> :TmuxNavigateUp<cr>
tnoremap <A-l> :TmuxNavigateRight<cr>
tnoremap <A-\> :TmuxNavigatePrevious<cr>
inoremap <A-h> <ESC>:TmuxNavigateLeft<cr>i
inoremap <A-j> <ESC>:TmuxNavigateDown<cr>i
inoremap <A-k> <ESC>:TmuxNavigateUp<cr>i
inoremap <A-l> <ESC>:TmuxNavigateRight<cr>i
inoremap <A-\> <ESC>:TmuxNavigatePrevious<cr>i

nnoremap <C-W>O :MaximizerToggle!<CR>
nnoremap <C-W>o :MaximizerToggle!<CR>
nnoremap <C-W><C-O> :MaximizerToggle!<CR>
vnoremap <C-W>O :MaximizerToggle!<CR>gv
vnoremap <C-W>o :MaximizerToggle!<CR>gv
vnoremap <C-W><C-O> :MaximizerToggle!<CR>gv
" }}}

