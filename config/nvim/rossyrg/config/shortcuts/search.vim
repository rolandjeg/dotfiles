" minus sign repeats f/F/t/T search forward
noremap - ;

" underscore repeats f/F/t/T search backward
noremap _ ,

" make <C-L> (redraw screen) also turn off
" search highlighting until the next search
" http://vim.wikia.com/wiki/Example_vimrc
" NOTE: this is taken over by SearchParty
" nnoremap <silent> <C-L> :nohlsearch<Return><C-L>

call shortcut#map('<Space> / #', 'Search -> Merge conflicts', 'normal! /^[<=>]\{7\}\( \|$\)/')
call shortcut#map('<Space> /', 'Search -> Forward (interactive)', 'OverCommandLine /')
call shortcut#map('<Space> ?', 'Search -> Backward (interactive)', 'OverCommandLine ?')
call shortcut#map('<Space> &', 'Search -> Replace (interactive)')

function! Shortcut_search_replace_interactive() abort
  if shortcut#mode() == 'n'
    OverCommandLine %S/
  else
    OverCommandLine S/
  endif
endfunction
