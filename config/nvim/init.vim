" vim:foldlevel=0
" vim:foldmethod=marker

set nocompatible
filetype on

""" Plugins {{{
call plug#begin()

"" Autocompletion
"Plug 'Shougo/deoplete.nvim'
"Plug 'ervandew/supertab'
"Plug 'Shougo/neosnippet' "?
"Plug 'Shougo/neosnippet-snippets' "?
Plug 'ctrlpvim/ctrlp.vim'

Plug 'jalvesaq/zotcite'
"Plug 'luochen1990/rainbow'
Plug 'junegunn/rainbow_parentheses.vim'

"" Languages
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"" Kotlin
Plug 'udalov/kotlin-vim'
"" Typescript
Plug 'HerringtonDarkholme/yats.vim'
"" Ruby
Plug 'vim-ruby/vim-ruby'
"" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Utility
"Plug 'hecal3/vim-leader-guide'
"Plug 'nhooyr/neoman.vim' Repository weg
"Plug 'itchyny/calendar.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimfiler.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'c0r73x/neotags.nvim'
Plug 'mpevnev/guten-tag'
Plug 'embear/vim-localvimrc'

Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'skywind3000/asyncrun.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ludovicchabant/vim-gutentags'

"" Srpache
"Plug 'ganwell/vim-hunspell-dicts' Repository gibt es nichtmehr

"" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

Plug 'dhruvasagar/vim-table-mode'

"" Unite
"Plug 'tsukkee/unite-tag'

"" Organizer
Plug 'vimwiki/vimwiki' , { 'branch': 'dev'}
Plug 'farseer90718/vim-taskwarrior'
Plug 'tbabej/taskwiki'

"" Tags
Plug 'rgroell/tagbar'
Plug 'liuchengxu/vista.vim'


Plug 'm2mdas/unite-file-vcs'
Plug 'vhdirk/vim-cmake'
Plug 'benekastah/neomake'
Plug 'vim-scripts/Scratch.vim'
Plug 'szw/vim-maximizer'

"" Latex
Plug 'lervag/vimtex'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'

"" Python
"Plug 'python-mode/python-mode', { 'branch': 'develop' }

""" Rust
"Plug 'rust-lang/rust.vim'
"Plug 'sebastianmarkow/deoplete-rust'

""" Haskell
"Plug 'bitc/vim-hdevtools'
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'

"Colorschemes
Plug 'sjl/badwolf'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Plug 'junegunn/seoul256.vim'
"Plug 'jnurmine/Zenburn'
Plug 'thomd/vim-wasabi-colorscheme'
Plug 'romainl/Apprentice'
Plug 'romainl/Disciple'
Plug 'chriskempson/base16-vim'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'freeo/vim-kalisi'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'gergap/wombat256'
Plug 'rainux/vim-desert-warm-256'
Plug 'KabbAmine/yowish.vim'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'KeitaNakamura/neodark.vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'rakr/vim-one'
Plug 'roosta/vim-srcery'
Plug 'xero/sourcerer.vim'
Plug 'joshdick/onedark.vim'
"Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'

Plug 'severin-lemaignan/vim-minimap'

""" Solidity
Plug 'tomlion/vim-solidity'

"" Own stuff
Plug '~/.config/nvim/rossyrg'

call plug#end()

filetype on
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
"let g:rubycomplete_buffer_loading = 1
set iskeyword=@,a-z,A-Z,_,.,39
set tags+=tags
set tags+=tagshaskdogs
set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gtk2
"set tags+=~/.vim/tags/cairo
set tags+=~/.vim/tags/cairomm
set tags+=~/.vim/tags/gtkmm3
set encoding=utf-8
set mouse=a

set hidden

set colorcolumn=80
set textwidth=0

set termguicolors

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

let maplocalleader = "\\"
let mapleader = "\<Space>"
set modeline
set modelines=5
set ai
set cindent
"set number
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
"set t_Co=256
set cursorline
set backspace=2
set hlsearch
set ignorecase
set smartcase
set list
let g:haskell_indent_guard = 2
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
autocmd FileType make setlocal noexpandtab
" Folding
set foldmethod=syntax
set foldlevelstart=98
set exrc
set secure

"undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload"

source ~/.config/nvim/rossyrg/config/shortcuts.vim
call unite#filters#matcher_default#use(['matcher_fuzzy'])



" tmuxstuff
if &term =~ '^screen'
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

let g:localvimrc_sandbox = 0



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

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_show_hidden = 1

let g:maximizer_set_default_mapping = 0

let g:org_export_init_script="~/.emacs_org_init"

let g:EclimCompletionMethod = 'omnifunc'
let g:EclimTempFilesEnable = 0

set wildmode=longest,list,full
set wildmenu

""" LaTeX {{{

let theuniqueserv = expand("%:r")

let g:tex_conceal=0
let g:vimtex_fold_enabled=1
"let g:vimtex_fold_manual=1
let g:vimtex_latexmk_continuous=1
let g:vimtex_view_method='zathura'
let g:vimtex_view_enabled=1
let g:vimtex_compiler_progname='nvr'
let g:vimtex_latexmk_callback=1
let g:vimtex_motion_matchparen=0
let g:vimtex_latexmk_background=0
let g:vimtex_quickfix_mode=2
let g:vimtex_quickfix_latexlog ={
      \ 'underfull' : 0,
      \ 'overfull' : 0,
      \ 'default' : 0,
      \ 'packages' : {
      \   'default' : 0,
      \ },
      \}
let g:vimtex_imaps_snippet_engine='neosnippet'
let g:vimtex_latexmk_nvim=1
let g:vimtex_toc_config ={
            \ 'mode' : 2,
            \ 'split_pos' : 'full',
            \}

let g:tex_flavor = "latex"

let g:LatexBox_latexmk_async=0
let g:LatexBox_complete_inlineMath=1
let g:LatexBox_latexmk_preview_continously=0
let g:LatexBox_viewer='zathura'
let g:LatexBox_quickfix=2
let g:LatexBox_Folding=1
let g:LatexBox_fold_automatic=1


let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'


let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername '.theuniqueserv.' --remote +\%{line} \%{input}" $*.pdf 2>/dev/null &'

function! Zathura_SyncTexForward()
  let source = expand("%:p")
  let input = shellescape(line(".").":".col(".").":".source)
  let output = Tex_GetMainFileName(":p:r").".pdf"
  let execstr = "zathura --synctex-forward=".input." ".shellescape(output)
  silent call system(execstr)
endfunction

"nmap <silent> <Leader>ls :call Zathura_SyncTexForward()<Enter>

let g:Tex_MultipleCompileFormats='dvi,pdf'
let g:Tex_IgnoredWarnings =
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \"Empty `thebibliography' environment"."\n".
    \'possible unwanted space at %.%#'
let g:Tex_IgnoreLevel=9
""" }}}



let &showbreak='+++ '
set breakindent
set laststatus=2

set inccommand=nosplit

""" Colorschemes {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

""" Spellchecking {{{

au BufNewFile,BufRead,BufEnter  *.tex setlocal nospell
set spelllang=hun-de-DE-frami,en_us

""" }}}

set autoread

""" Python Mode {{{

let g:pymode_python = 'python'
let g:pymode_lint_ignore = ["W"]
"let g:pymode_indent = 1
"let g:pymode_folding = 1
"let g:pymode_rope_completion = 0

""" }}}
""" Jedi (Python) {{{

"let g:jedi#force_py_version = 2

""" }}}
""" YouCompleteMe {{{

"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_min_num_of_chars_for_completion = 1
"let g:ycm_global_ycm_extra_conf="~/.ycm_extra_conf.py"
"let g:ycm_complete_in_comments_and_strings = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_confirm_extra_conf = 0
""let g:ycm_filetype_blacklist = {
"    "\ 'python' : 1,
"    "\}
"
"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


""" }}}


" TAB {{{
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col -1] =~ '\s'
endfunction "}}}
"inoremap <expr><TAB> pumvisible() ? "\<C-N>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
""" }}}

set rtp+=~/.fzf

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""" Vimwiki {{{
let g:vimwiki_list = [
            \ {
            \ 'path': '~/vimwiki',
            \ 'syntax': 'markdown',
            \ 'path_html': '~/vimwiki_html/',
            \ 'auto_tags': 1,
            \ 'auto_export': 0,
            \ 'template_path': '~/vimwiki_templates',
            \ 'ext': '.md',
            \ 'custom_wiki2html': 'wiki2html.sh',
            \ 'custom_wiki2html_args' : '',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'
            \ },
            \ {
            \ 'path': '~/vimwiki_privat', 
            \ 'syntax': 'markdown',
            \ 'path_html': '~/vimwiki_privat_html/',
            \ 'auto_tags': 1,
            \ 'auto_export': 0,
            \ 'template_path': '~/vimwiki_html',
            \ 'ext': '.md',
            \ 'custom_wiki2html': 'wiki2html.sh',
            \ 'custom_wiki2html_args' : '',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'
            \ }]
let g:vimwiki_use_calendar=1
let g:vimwiki_folding = 'expr'
let g:vimwiki_table_mappings = 0
let g:vimwiki_table_auto_fmt = 0
let g:vimwiki_global_ext = 0
autocmd FileType vimwiki inoremap <expr><TAB> pumvisible() ? "\<C-N>" : vimwiki#tbl#kbd_tab()
autocmd FileType vimwiki inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : vimwiki#tbl#kbd_shift_tab()
autocmd FileType vimwiki set commentstring="> %s"
autocmd FileType vimwiki set syntax=vimwiki.pandoc
""" }}}

let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
let g:table_mode_map_prefix='<leader>t'

""" Pandoc {{{
let g:pandoc#spell#enabled = 0
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#syntax#conceal#blacklist = ["block"]
let g:pandoc#toc#position="left"
let g:pandoc#modules#disabled=["indent"]
let g:pandoc#folding#fdc = 2
let g:pandoc#biblio#bibs=["/home/groell/vimwiki/My_Library.bib"]
"let g:pandoc#filetypes#handled=["markdown", "vimwiki", "pandoc", "rst", "textile"]
" }}}

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_vimwiki = {
    \ 'ctagstype': 'vimwiki',
    \ 'ctagsbin' : '~/.config/nvim/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
    \ }
""" }}}

"let g:deoplete#enable_at_startup = 1

""" Haskell {{{
"if has('nvim') " This way you can also put it in your vim config file
    "call rpcrequest(rpcstart(expand('$HOME/bin/nvim-hs-devel.sh')), "PingNvimhs")
"endif
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
""" }}}

" Rust {{{
"let g:deoplete#sources#rust#racer_binary='/home/groell/.cargo/bin/racer'
"let g:deoplete#sources#rust#rust_source_path='/home/groell/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
" }}}

"autocmd! BufWritePost * Neomake
autocmd FileType qf wincmd J


"" LeaderGuide {{{
"    " Define prefix dictionary
"    let g:lmap =  {}
"
"    " Second level dictionaries:
"    let g:lmap.f = { 'name' : 'Find stuff' }
"
"    let g:llmap = {}
"
"    let g:topdict = {}
"    let g:topdict[' '] = g:lmap
"    let g:topdict[' ']['name'] = '<leader>'
"    let g:topdict[','] = g:llmap
"    let g:topdict[',']['name'] = '<localleader>'
"
"    call leaderGuide#register_prefix_descriptions("", "g:topdict")
"    " 'name' is a special field. It will define the name of the group.
"    " leader-f is the "File Menu" group.
"    " Unnamed groups will show an empty string
"    
"    nnoremap <leader> :<C-U>LeaderGuide ' '<CR>
"    vnoremap <leader> :<C-U>LeaderGuideVisual ' '<CR>
"    map <leader>. <Plug>leaderguide-global
"
"" }}}

" Denite {{{
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>','noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>','noremap')
call denite#custom#map('insert', '<ESC>', '<denite:enter_mode:normal>','noremap')
call denite#custom#map('normal', '<ESC>', '<denite:enter_mode:normal>','noremap')

call denite#custom#option('default', 'highlight_mode_insert', 'PreProc')
call denite#custom#option('default', 'mode', 'normal')

" }}}

" FZF {{{
"map <Leader>f :Find<space>

command! -bang -nargs=* Find call fzf#vim#grep( 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
" }}}
"
"

let g:gutentags_project_root=['.root']

" NEOSNIPPETS {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}
"

""" FZF
let g:fzf_action = {
            \ 'ctrl-q': 'wall | bdelete',
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

set background=light
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

"let g:rainbow_active=1

""" Solidity {{{
let g:tagbar_type_solidity = {                                                  
    \ 'ctagstype': 'solidity',                                                  
    \ 'kinds' : [                                                               
        \ 'c:contracts',                                                        
        \ 'e:events',                                                           
        \ 'f:functions',                                                        
        \ 'm:mappings',                                                         
        \ 'v:varialbes',                                                        
    \ ]                                                                         
    \ }
""" }}}

""" Taskwiki {{{
let g:taskwiki_markup_syntax = "markdown"
let g:taskwiki_maplocalleader="\\t"
""" }}}

""" COC {{{
"" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
nnoremap <silent> <leader>fo  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
"}}}


"{{{ Vista
let g:vista#renderer#enable_icon = 0

let g:vista_executive_for = {
  \ 'haskell': 'coc',
  \ }

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
""}}}

set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%M                        " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                          " right align
set statusline+=%{coc#status()}
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage

let zotcite_hl = 0

function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'citep' : 'pandoc'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

nmap <c-]> <Plug>ZOpenAttachement
