 " vim:foldlevel=0
" vim:foldmethod=marker

set nocompatible
filetype on

" Plugins {{{
call plug#begin()

" Programmieren

"" Autocompletion
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' "LSP source for nvim-cmp
"Plug 'nvim-lua/completion-nvim'
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
"Plug 'euclidianAce/BetterLua.vim'

"Plug 'Shougo/neosnippet' "TODO Kann weg?
"Plug 'Shougo/neosnippet-snippets' "TODO Kann weg?
"" Tagmanagement (falls kein LSP)
"Plug 'c0r73x/neotags.nvim' " Welches Tagmanagement ist gut? TODO
"Plug 'mpevnev/guten-tag' " Welches Tagmanagement ist gut? TODO
"Plug 'ludovicchabant/vim-gutentags'

"" Languages
""" Kotlin
Plug 'udalov/kotlin-vim'
""" Typescript
Plug 'HerringtonDarkholme/yats.vim'
""" Ruby
Plug 'vim-ruby/vim-ruby'
""" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
""" Haskell
Plug 'neovimhaskell/haskell-vim'
""" Solidity
Plug 'tomlion/vim-solidity'
""" Python
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
""" Rust
Plug 'simrat39/rust-tools.nvim'

" Utility
"Plug 'hecal3/vim-leader-guide' " Das ist vielleicht cool, aber überzeugte noch nicht ganz
"Plug 'itchyny/calendar.vim' " Kann Weg?
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Wofür brauch ich das?
Plug 'scrooloose/nerdcommenter' "Einfaches auskommentieren in allen Sprachen
Plug 'tpope/vim-unimpaired' " Nützliche scripts, yob, yon, etc.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Bisher der beste fuzzy finder wohl. Terminalpart
Plug 'junegunn/fzf.vim' " VIM-Part
Plug 'embear/vim-localvimrc' " lokale, projektbezogene vimrcs
Plug 'luochen1990/rainbow' " TODO 
"Plug 'junegunn/rainbow_parentheses.vim' " TODO Regenbogenklammern klappen noch nicht
Plug 'dhruvasagar/vim-table-mode' " Tablemode ist praktisch für Tabellen in Markdown
Plug 'szw/vim-maximizer' " Ctrl-W O zum maximizen
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'}

Plug 'junegunn/vim-easy-align' "Redundant? TODO
Plug 'godlygeek/tabular' " Redundant? TODO
Plug 'skywind3000/asyncrun.vim' " Redundant? TODO
Plug 'christoomey/vim-tmux-navigator' "Gut!

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" Organizer
"Plug 'vimwiki/vimwiki' , { 'branch': 'dev'}
Plug 'farseer90718/vim-taskwarrior'
Plug 'lervag/wiki.vim'

" Tags
Plug 'liuchengxu/vista.vim'

Plug 'vhdirk/vim-cmake'
"Plug 'benekastah/neomake' Ersetzt durch coc.nvim
Plug 'vim-scripts/Scratch.vim'

" Latex
Plug 'lervag/vimtex'

" Git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
"Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'mlopes/vim-farin'
Plug 'sjl/badwolf'
Plug 'drewtempelmeyer/palenight.vim'
"Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Plug 'junegunn/seoul256.vim'
"Plug 'jnurmine/Zenburn'
"Plug 'thomd/vim-wasabi-colorscheme'
"Plug 'romainl/Apprentice'
"Plug 'romainl/Disciple'
"Plug 'chriskempson/base16-vim'
"Plug 'w0ng/vim-hybrid'
"Plug 'kristijanhusak/vim-hybrid-material'
Plug 'freeo/vim-kalisi'
"Plug 'tomasr/molokai'
Plug 'gergap/wombat256'
"Plug 'rainux/vim-desert-warm-256'
"Plug 'KabbAmine/yowish.vim'
"Plug 'lu-ren/SerialExperimentsLain'
Plug 'KeitaNakamura/neodark.vim'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'rakr/vim-one'
"Plug 'roosta/vim-srcery'
"Plug 'xero/sourcerer.vim'
Plug 'joshdick/onedark.vim'
"Plug 'arcticicestudio/nord-vim'
"Plug 'ayu-theme/ayu-vim'


" Own stuff
Plug '~/.config/nvim/rossyrg'

call plug#end()

filetype on
""" }}}

" CMake Errorformat {{{
set errorformat^=%-GScanning\ dependencies\ of\ target\ %f
set errorformat^=%-G\[\ %l%%\]\ Building\ CXX\ object\ %f
set errorformat^=%-G\[\ %l%%\]\ Built\ target\ %f
set errorformat^=%-G\[%l%%\]\ Building\ CXX\ object\ %f
set errorformat^=%-G\[%l%%\]\ Built\ target\ %f
set errorformat^=%-GLinking\ CXX\ static\ library\ %f
set errorformat^=%-GLinking\ CXX\ executable\ %f
" }}}

" Allgemeines {{{
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
set autoread

set hidden

set colorcolumn=80
set textwidth=0

let &showbreak='+++ '
set breakindent
set laststatus=2

set inccommand=nosplit

let g:localvimrc_sandbox = 0

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

"embedded syntax highlight for lua, Python, ruby
let g:vimsyn_embed= 'lPr'
""" }}}

" Ruby {{{
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" }}}

" nerdcomment {{{
let NERDCommentWholeLinesInVMode=0
" }}}

" CScope TODO Kann weg? {{{
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
" }}}

" Interoperability with tmux {{{
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
" }}}

" Window Maximizer {{{
let g:maximizer_set_default_mapping = 0
" }}}

" LaTeX {{{

let theuniqueserv = expand("%:r")

let g:tex_conceal="abdmgs"
let g:vimtex_fold_enabled=1
"let g:vimtex_fold_manual=1
"let g:vimtex_latexmk_continuous=1
let g:vimtex_view_method='zathura'
let g:vimtex_view_enabled=1
let g:vimtex_compiler_progname='nvr'
"let g:vimtex_latexmk_callback=1
let g:vimtex_motion_matchparen=0
"let g:vimtex_latexmk_background=0
let g:vimtex_quickfix_mode=2
"let g:vimtex_quickfix_latexlog ={
      "\ 'underfull' : 0,
      "\ 'overfull' : 0,
      "\ 'default' : 0,
      "\ 'packages' : {
      "\   'default' : 0,
      "\ },
      "\}
let g:vimtex_quickfix_ignore_filters = [
            \ 'Missing "journal"',
            \ 'The length marginparwidth is less than',
            \ 'Underfull',
            \ 'Overfull',
            \]
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

" Colorschemes {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='medium'
colorscheme gruvbox
" }}}

" Spellchecking {{{

au BufNewFile,BufRead,BufEnter  *.tex setlocal nospell
set spelllang=hun-de-DE-frami,en_us

""" }}}

" TAB {{{
inoremap <expr><TAB> pumvisible() ? "\<C-N>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
set completeopt=menuone,noinsert,noselect

set shortmess+=c
""" }}}

" Table Mode {{{
let g:table_mode_corner_corner='+'
let g:table_mode_corner='+'
let g:table_mode_header_fillchar='-'
let g:table_mode_map_prefix='<leader>t'
"}}} 

" Pandoc {{{
let g:pandoc#spell#enabled = 0
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#syntax#conceal#blacklist = ["block"]
let g:pandoc#toc#position="left"
let g:pandoc#modules#disabled=["indent"]
let g:pandoc#folding#fdc = 2
let g:pandoc#biblio#bibs=["/home/groell/vimwiki/My_Library.bib"]
let g:pandoc#syntax#codeblocks#embeds#use = 1
"let g:pandoc#filetypes#handled=["markdown", "vimwiki", "pandoc", "rst", "textile"]
" }}}

" TODO what? {{{
autocmd FileType qf wincmd J
"}}}

" Gutentags {{{
let g:gutentags_project_root=['.root']
""" }}}

" NEOSNIPPETS {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}

" FZF {{{
set rtp+=~/.fzf
let g:fzf_action = {
            \ 'ctrl-q': 'wall | bdelete',
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

set background=dark
command! -bang -nargs=* Find call fzf#vim#grep( 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
""" }}}

" COC {{{
"" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" TODO können die beiden folgenden Zeilen weg?
"set wildmode=longest,list,full
"set wildmenu 
"
"" if hidden is not set, TextEdit might fail.
"set hidden
"
"" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup
"
"" Better display for messages
"set cmdheight=2
"
"" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300
"
"" don't give |ins-completion-menu| messages.
"set shortmess+=c
"
"" always show signcolumns
"set signcolumn=yes
"
"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"
"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Remap for format selected region
"" xmap <leader>f  <Plug>(coc-format-selected)
"" nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)
"
"" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)
"
"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')
"
"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"
"" Using CocList
"" Show all diagnostics
"" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" " Manage extensions
"" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" " Show commands
"" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" " Find symbol of current document
"nnoremap <silent> <leader>fo  :<C-u>CocList outline<cr>
"" " Search workspace symbols
"" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" " Do default action for next item.
"" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" " Do default action for previous item.
"" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" " Resume latest coc list
"" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
"" disable vim-go :GoDef short cut (gd)
"" this is handled by LanguageClient [LC]
"let g:go_def_mapping_enabled = 0
"
"nnoremap F :call CocAction('format')<CR>
"nmap <leader>qf <Plug>(coc-fix-current)
"}}}

"{{{ Vista
let g:vista#renderer#enable_icon = 0

let g:vista_executive_for = {
  \ 'haskell': 'coc',
  \ 'pandoc': 'markdown',
  \ }

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
""}}}

" Statusline {{{
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
set statusline+=%{NearestMethodOrFunction()}
set statusline+=%=                          " right align
set statusline+=%{FugitiveStatusline()}
"set statusline+=%{coc#status()}
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage
""" }}}

" Defx {{{
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
                \ defx#do_action('open')
    nnoremap <silent><buffer><expr> E
                \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
                \ defx#do_action('preview')
    nnoremap <silent><buffer><expr> o
                \ defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> K
                \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
                \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
                \ defx#do_action('toggle_columns',
                \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
                \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
                \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
                \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
                \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
                \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
                \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
                \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
                \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')
endfunction
" }}}

" LSP {{{

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
--require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
EOF
" }}}

" {{{ cmp
lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF
" }}}

" WIKI.VIM {{{
let g:wiki_root = '~/vimwiki'
let g:wiki_link_target_type = 'md'
let g:wiki_link_extension = '.md'
let g:wiki_filetypes = ['md']
" }}}
