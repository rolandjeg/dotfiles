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
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'simnalamburt/vim-mundo'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"Plug 'euclidianAce/BetterLua.vim'

"Plug 'Shougo/neosnippet' "TODO Kann weg?
"Plug 'Shougo/neosnippet-snippets' "TODO Kann weg?
"" Tagmanagement (falls kein LSP)
"Plug 'c0r73x/neotags.nvim' " Welches Tagmanagement ist gut? TODO
"Plug 'mpevnev/guten-tag' " Welches Tagmanagement ist gut? TODO
"Plug 'ludovicchabant/vim-gutentags'
Plug 'lambdalisue/fern.vim', {'branch': 'main'}
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'yuki-yano/fern-preview.vim'

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Utility
"Plug 'hecal3/vim-leader-guide' " Das ist vielleicht cool, aber überzeugte noch nicht ganz
"Plug 'itchyny/calendar.vim' " Kann Weg?
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Wofür brauch ich das?
Plug 'scrooloose/nerdcommenter' "Einfaches auskommentieren in allen Sprachen
Plug 'tpope/vim-unimpaired' " Nützliche scripts, yob, yon, etc.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " VIM-Part
Plug 'embear/vim-localvimrc' " lokale, projektbezogene vimrcs
Plug 'luochen1990/rainbow' " TODO 
"Plug 'junegunn/rainbow_parentheses.vim' " TODO Regenbogenklammern klappen noch nicht
Plug 'dhruvasagar/vim-table-mode' " Tablemode ist praktisch für Tabellen in Markdown
Plug 'szw/vim-maximizer' " Ctrl-W O zum maximizen

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
Plug 'EdenEast/nightfox.nvim'
Plug 'savq/melange'
Plug 'gruvbox-community/gruvbox'
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

" CMake Errorformat TODO Brauch man das mit lsp noch? {{{
" set errorformat^=%-GScanning\ dependencies\ of\ target\ %f
" set errorformat^=%-G\[\ %l%%\]\ Building\ CXX\ object\ %f
" set errorformat^=%-G\[\ %l%%\]\ Built\ target\ %f
" set errorformat^=%-G\[%l%%\]\ Building\ CXX\ object\ %f
" set errorformat^=%-G\[%l%%\]\ Built\ target\ %f
" set errorformat^=%-GLinking\ CXX\ static\ library\ %f
" set errorformat^=%-GLinking\ CXX\ executable\ %f
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

"autocmd BufNewFile,BufRead *.md,*.MD set filetype=pandoc
""" }}}

" nerdcomment {{{
let NERDCommentWholeLinesInVMode=0
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

" Colorscheme {{{
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
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd', 'hls' }
  -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
--require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}

-- Haskell
--nvim_lsp.hls.setup({
    --on_attach = on_attach,
    --settings = {
        --haskell = {
            --hlintOn = true,
            --formattingProvider = "fourmolu"
        --}
    --}
--})
EOF
" }}}

" {{{ cmp
set completeopt=menu,menuone,noselect

lua <<EOF
-- Setup nvim-cmp.
 -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
        --["<Tab>"] = cmp.mapping(function(fallback)
        --    if cmp.visible() then
        --        cmp.select_next_item()
        --    elseif vim.fn["vsnip#available"](1) == 1 then
        --        feedkey("<Plug>(vsnip-expand-or-jump)", "")
        --    elseif has_words_before() then
        --        cmp.complete()
        --    else
        --        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        --    end
        --end
        --["<S-Tab>"] = cmp.mapping(function()
        --    if cmp.visible() then
        --        cmp.select_prev_item()
        --    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        --        feedkey("<Plug>(vsnip-jump-prev)", "")
        --    end
        --end
EOF
" }}}

" {{{ Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
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

" Fern {{{
let g:fern#disable_default_mappings   = 1
let g:fern#disable_drawer_auto_quit   = 1
let g:fern#disable_viewer_hide_cursor = 1
let g:fern_git_status#disable_ignored    = 1
let g:fern_git_status#disable_untracked  = 1
let g:fern_git_status#disable_submodules = 1
noremap <silent> <Leader>ne :Fern %:h<CR>
noremap <silent> <Leader>nw :Fern .<CR>
noremap <silent> <Leader>nd :Fern . -drawer -width=30 -toggle<CR>

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> o <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> m <Plug>(fern-action-mark:toggle)j
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> C <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

