call shortcut#map('<Space> d Z', 'Fold -> Close -> Others', 'normal! zMzv')
call shortcut#map('<Space> z v', 'Narrow -> Selection', 'Narrow')
call shortcut#map('<Space> = z', 'Narrow -> Off', 'Widen')

" go to adjacent folds
nnoremap <C-Up> zk
nnoremap <C-S-Up> [[
nnoremap <C-Down> zj
nnoremap <C-S-Down> ]]

" open and close folds
nnoremap <A-Down> zo
nnoremap <A-S-Down> zO
nnoremap <A-Up> zc
nnoremap <A-S-Up> zC

" change the foldlevel
nnoremap <A-Left> zm
nnoremap <A-S-Left> zM
nnoremap <A-Right> zr
nnoremap <A-S-Right> zR
