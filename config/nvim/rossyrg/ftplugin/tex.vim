" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword=@,48-57,_,192-255
set iskeyword+=:
set smartindent
autocmd! BufWritePost * Neomake

autocmd FileType tex :NoMatchParen

nnoremap <localleader>lt :<C-u>Denite -mode=normal vimtex_toc<cr> 
nnoremap <localleader>ly :<C-u>Denite -mode=normal vimtex_labels<cr>
