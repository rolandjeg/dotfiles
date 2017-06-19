let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

nnoremap <buffer> <F1> :GhcModType<CR>
nnoremap <buffer> <F2> :GhcModTypeClear<CR>
nnoremap <buffer> <F3> :GhcModInfo<CR>
au! BufWritePost * GhcModCheckAndLintAsync
