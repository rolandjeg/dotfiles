" vim:fdm=marker
 
set nocompatible
filetype on

""" Neobundle {{{
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/neobundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'majutsushi/tagbar'
NeoBundle 'https://github.com/Valloric/YouCompleteMe.git'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vhdirk/vim-cmake'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-scripts/Scratch.vim'
NeoBundle 'szw/vim-maximizer'
NeoBundle 'guns/xterm-color-table.vim'
"NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
NeoBundle 'gerw/vim-latex-suite'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'gisraptor/vim-lilypond-integrator'
NeoBundle 'ardagnir/vimbed'
NeoBundle 'vim-scripts/Gundo'
NeoBundle 'jlanzarotta/bufexplorer'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'davidhalter/jedi-vim'

"Colorschemes
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'freeo/vim-kalisi'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'tomasr/molokai'



NeoBundle '~/.vim/rossyrg'

call neobundle#end()

filetype on
NeoBundleCheck
""" }}}
""" CMake Errorformat {{{
set errorformat^=%-GScanning\ dependencies\ of\ target\ %f
set errorformat^=%-G\[\ %l%%\]\ Building\ CXX\ object\ %f
set errorformat^=%-G\[\ %l%%\]\ Built\ target\ %f
set errorformat^=%-G\[%l%%\]\ Building\ CXX\ object\ %f
set errorformat^=%-G\[%l%%\]\ Built\ target\ %f
set errorformat^=%-GLinking\ CXX\ static\ library\ %f
set errorformat^=%-GLinking\ CXX\ executable\ %f
""" }}}

syntax on
filetype plugin indent on
set ofu=syntaxcomplete#Complete
let g:rubycomplete_buffer_loading = 1
set tags+=./tags
set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gtk2
"set tags+=~/.vim/tags/cairo
set tags+=~/.vim/tags/cairomm
set tags+=~/.vim/tags/gtkmm3

set colorcolumn=80
set textwidth=0

let OmniCpp_NamespaceSearch = 2
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 0 " show function parameters
let OmniCpp_MayCompleteDot = 0 " autocomplete after .
let OmniCpp_MayCompleteArrow = 0 " autocomplete after ->
let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_LocalSearchDecl = 0 " use local search function, bracket on 1st column
let OmniCpp_DisplayMode = 0
" automatically open and close the popup menu / preview window
au InsertLeave * if pumvisible() == 0|silent! pclose|endif
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

inoremap <silent> <buffer> <C-,> <ESC>:call Toggle_task_status()<CR>i
noremap <silent> <buffer> <C-,> :call Toggle_task_status()<CR>
let mapleader = ","
let maplocalleader = ","
set modeline
set modelines=5
set ai
set cindent
"set number
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set t_Co=256
set cursorline
set backspace=2
set hlsearch
set smartcase

" Folding
set foldmethod=syntax
set foldlevelstart=98

"undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload"

" Press F4 to toggle highlighting on/off, and show current value.
"nnoremap <F4> :GundoToggle<CR>
nnoremap <leader>u :GundoToggle<CR>
"noremap <F5> :BufExplorer<CR>
noremap <leader>e :BufExplorer<CR>
"nnoremap <F6> :TagbarToggle<CR> 
"nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR> 
nnoremap <leader>o :NeoCompleteToggle<CR>
"nnoremap <leader>ac :AutoCloseToggle<CR>
"map <leader>r :!ctags -R --fields=+iaS --extra=+q; find -L . -name "*.c" -o -name "*.cc" -o -name "*.hpp" -o -name "*.hh" -o -name "*.h" -o -name "*.cpp" -o -name "*.java" -o -name "*.rb" <BAR> cscope -Rb -i-<CR>:cs reset<CR>
map <leader>r :!ctags -R; find -L . -name "*.c" -o -name "*.cc" -o -name "*.hpp" -o -name "*.hh" -o -name "*.h" -o -name "*.cpp" -o -name "*.java" -o -name "*.rb" <BAR> cscope -Rb -i-<CR>:cs reset<CR>
"nmap <silent> <c-n> :NERDTreeToggle<CR>

let Tlist_Exit_OnlyWindow = 1
let Tlist_Close_On_Select = 0
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Process_File_Always = 1
let Tlist_Use_Right_Window = 1


highlight MyTagListFileName guifg=cyan guibg=black
set guioptions-=r

" Supertab settings
"let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
"let g:SuperTabLongestHighlight = 1"

"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc']
"let g:SuperTabContextDiscoverDiscovery =
      "\ ["&omnifunc:<c-x><c-o>"]

"inoremap <expr><TAB> pumvisible() ? "\<C-N>" : "\<TAB>"



"VimOrganizer
"
"au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
"au BufEnter *.org call org#SetOrgFileType()
"command! OrgCapture :call org#CaptureBuffer()
"command! OrgCaptureFile :call org#OpenCaptureFile()
"
"let g:org_capture_file="~/capture.org"
"let g:org_todo_setup='TODO | DONE'
"
"let g:org_agenda_select_dirs=["~/org"]
let g:org_agenda_files = ['~/org/da.org']
let g:org_command_for_emacsclient = 'emacsclient'
"let g:global_column_view=1
"let g:global_column_defaults='%ITEM %15DEADLINE %30TAGS'  

if &term =~ '^screen'
  " tmuxstuff
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" gvimstuff
set go=agi
set gfn=DejaVu\ Sans\ Mono\ 10

let g:syntastic_cpp_config_file = ".syntastic"
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_include_dirs = ['/usr/include/gtk-2.0/']
let g:syntastic_cpp_include_dirs = ['/usr/include/gtkmm-3.0/']
let g:syntastic_cpp_include_dirs = ['/usr/include/cairomm/']
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetype': []}

let g:syntastic_python_python_exec = '/usr/bin/python2'

let g:localvimrc_sandbox = 0

" Powerline
"set rtp+=/usr/lib/python3.3/site-packages/powerline/bindings/vim
"let g:Powerline_symbols = 'fancy'
"set laststatus=2

" Allow sudo saving
cmap w!! w !sudo tee > /dev/null %

let g:nerdtree_open_cmd='rifle'

"nerdcomment
let NERDCommentWholeLinesInVMode=0

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()


let g:airline_powerline_fonts = 1

if &term =~ '^screen' && exists('$TMUX')
  set mouse+=a
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
  " tmux will send xterm-style keys when xterm-keys is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
  execute "set <xHome>=\e[1;*H"
  execute "set <xEnd>=\e[1;*F"
  execute "set <Insert>=\e[2;*~"
  execute "set <Delete>=\e[3;*~"
  execute "set <PageUp>=\e[5;*~"
  execute "set <PageDown>=\e[6;*~"
  execute "set <xF1>=\e[1;*P"
  execute "set <xF2>=\e[1;*Q"
  execute "set <xF3>=\e[1;*R"
  execute "set <xF4>=\e[1;*S"
  execute "set <F5>=\e[15;*~"
  execute "set <F6>=\e[17;*~"
  execute "set <F7>=\e[18;*~"
  execute "set <F8>=\e[19;*~"
  execute "set <F9>=\e[20;*~"
  execute "set <F10>=\e[21;*~"
  execute "set <F11>=\e[23;*~"
  execute "set <F12>=\e[24;*~"
endif

" VIM Airline Config
let g:airline_theme = 'tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0



let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_show_hidden = 1

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13

nnoremap <C-W>O :MaximizerToggle<CR>
nnoremap <C-W>o :MaximizerToggle<CR>
nnoremap <C-W><C-O> :MaximizerToggle<CR>
vnoremap <C-W>O :MaximizerToggle<CR>gv
vnoremap <C-W>o :MaximizerToggle<CR>gv
vnoremap <C-W><C-O> :MaximizerToggle<CR>gv

let g:maximizer_set_default_mapping = 0
noremap <F3> :noh<CR>

let g:org_export_init_script="~/.emacs_org_init"

let g:EclimCompletionMethod = 'omnifunc'
let g:EclimTempFilesEnable = 0

set wildmode=longest,list,full
set wildmenu

""" LaTeX {{{

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'

let theuniqueserv = expand("%:r")

let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername '.theuniqueserv.' --remote +\%{line} \%{input}" $*.pdf 2>/dev/null &'

function! Zathura_SyncTexForward()
  let source = expand("%:p")
  let input = shellescape(line(".").":".col(".").":".source)
  let output = Tex_GetMainFileName(":p:r").".pdf"
  let execstr = "zathura --synctex-forward=".input." ".shellescape(output)
  silent call system(execstr)
endfunction

nmap <Leader>f :call Zathura_SyncTexForward()<Enter>

let g:Tex_MultipleCompileFormats='dvi,pdf'
let g:Tex_IgnoredWarnings = 
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \"Empty `thebibliography' environment"
let g:Tex_IgnoreLevel=8
""" }}}



set showbreak=+++\  
set laststatus=2


let g:airline#extensions#tmuxline#enabled = 0

""" Font size {{{

let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

if has("gui_gtk2") && has("gui_running")
    noremap <M-S-Up> :LargerFont<ENTER>
    noremap <M-S-Down> :SmallerFont<ENTER>
endif

""" }}}


""" Syntastic {{{

function! SyntasticPython2()
    let g:syntastic_python_python_exec = '/usr/bin/python2'
endfunction
command! SyntasticPython2 call SyntasticPython2()

function! SyntasticPython3()
    let g:syntastic_python_python_exec = '/usr/bin/python3'
endfunction
command! SyntasticPython3 call SyntasticPython3()

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["python"] }

""" }}}


set guiheadroom=1

""" Colorschemes {{{

let g:zenburn_high_Contrast=1

if has('gui_running') "  let g:gruvbox_bold=1
  let g:gruvbox_italic=1
  let g:gruvbox_underline=1
  let g:gruvbox_undercurl=1
  let g:gruvbox_termcolors=256
  let g:gruvbox_contrast='hard'
  let g:gruvbox_hls_cursor='orange'
  let g:gruvbox_sign_column='dark1'
  let g:gruvbox_italicize_comments=1
  let g:gruvbox_italicize_strings=0
  let g:gruvbox_invert_selection=1
  let g:gruvbox_invert_signs=0
else
  let g:gruvbox_bold=0
  let g:gruvbox_italic=0
  let g:gruvbox_underline=0
  let g:gruvbox_undercurl=0
  let g:gruvbox_termcolors=256
  let g:gruvbox_contrast='hard'
  let g:gruvbox_hls_cursor='orange'
  let g:gruvbox_sign_column='dark1'
  let g:gruvbox_italicize_comments=0
  let g:gruvbox_italicize_strings=0
  let g:gruvbox_invert_selection=1
  let g:gruvbox_invert_signs=0
endif
set background=light
let g:hybrid_use_Xresources = 1
if has("gui_running")
    colorscheme kalisi
else
    colorscheme gruvbox
endif

autocmd VimEnter * SetColors kalisi gruvbox 

""" }}}
""" Spellchecking {{{

au BufNewFile,BufRead,BufEnter  *.tex setlocal spell

""" }}}

set autoread

""" Python Mode {{{

let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_rope_completion = 0

""" }}}
""" Jedi (Python) {{{

let g:jedi#force_py_version = 3

""" }}}
""" YouCompleteMe {{{

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_global_ycm_extra_conf="~/.ycm_extra_conf.py"
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_blacklist = {
\ 'python' : 1,
      \}

""" }}}

