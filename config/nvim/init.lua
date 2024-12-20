-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.markdown_folding = 1

--{{{ Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
--}}}

--{{{ Plugins
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- IO async
  { "nvim-neotest/nvim-nio" },

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { 'neovim/nvim-lspconfig',
  --{{{ LSP Configuration & Plugins
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
    },
  --}}}
  },
  { 'folke/lazydev.nvim',
    --{{{ `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
    --}}}
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  { 'hrsh7th/nvim-cmp',
  --{{{ Autocompletion
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  --}}}
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { 'echasnovski/mini.nvim', version = false },
  { 'folke/which-key.nvim',
  --{{{ Useful plugin to show you pending keybinds.
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ebugging" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>g", group = "[G]it" },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>n", group = "Toggle" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>t", group = "[T]ests" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>z", group = "[Z]ettelkasten" },
        { "gx", desc = "Open with xgd-open" },
        { "<leader>", group = "VISUAL <leader>", mode = "v" },
        { "<leader>h", desc = "Git [H]unk", mode = "v" },
      },
    },
    --}}}
  },
  { 'lewis6991/gitsigns.nvim',
    --{{{ Adds git releated signs to the gutter, as well as utilities for managing changes
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>nb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>nd', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end
    },
  --}}}
  },

  { 'sainnhe/gruvbox-material' },
  { "ellisonleao/gruvbox.nvim" },
  { 'catppuccin/nvim'  },
  { 'folke/tokyonight.nvim'  },

  { 'nvim-lualine/lualine.nvim',
  --{{{ Set lualine as statusline
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },

      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
    },
  --}}}
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = { },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      "nvim-tree/nvim-web-devicons",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'tree-sitter-grammars/tree-sitter-markdown',
    },
    build = ':TSUpdate',
  },

  --{ 'lervag/wiki.vim' },

  { 'renerocksai/telekasten.nvim',
    --{{{ Zettelkasten
    dependencies = {'nvim-telescope/telescope.nvim'},
    keys = {
      { "<leader>zw", "<cmd>Telekasten panel<cr>", desc = "Telekasten which?" },

      -- Most used functions
      { "<leader>zf", "<cmd>Telekasten find_notes<CR>", desc = "Telekasten [f]ind notes"},
      { "<leader>zg", "<cmd>Telekasten search_notes<CR>", desc = "Telekasten [g]oto notes"},
      { "<leader>zd", "<cmd>Telekasten goto_today<CR>", desc = "Telekasten to[d]ay" },
      { "<leader>zz", "<cmd>Telekasten follow_link<CR>", desc = "Telekasten follow link"},
      { "<leader>zn", "<cmd>Telekasten new_note<CR>", desc = "Telekasten [n]ew note"},
      { "<leader>zc", "<cmd>Telekasten show_calendar<CR>", desc = "Telekasten [c]alendar" },
      { "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", desc = "Telekasten show [b]acklinks" },
      { "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", desc = "Telekasten insert [I]mage link" },
      { "<leader>zi", "<cmd>Telekasten insert_link<CR>", desc = "Telekasten [i]nsert link" },
      { "<leader>zt", "<cmd>Telekasten toggle_todo<CR>", desc = "Telekasten [t]odo toggle" },
    },
    config = function()
      require('telekasten').setup({
        home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
        dailies = vim.fn.expand("~/zettelkasten/dailies"), -- Put the name of your notes directory here
        weeklies = vim.fn.expand("~/zettelkasten/weeklies"), -- Put the name of your notes directory here
        auto_set_filetype = false,
        vaults = { 
          cryptoagility = {
            home = vim.fn.expand("~/projekte/pki/paper/"),
            auto_set_filetype = false,
          },
          promotion = {
            home = vim.fn.expand("~/promotion/zettelkasten"),
            auto_set_filetype = false,
          },
        },
      })
    end
    --}}}
  },
  -- {
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup({
  --       -- Config goes here; leave blank for defaults
  --     })
  --   end
  -- },
  { 'nvim-orgmode/orgmode',
  --{{{ Orgmode
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/refile.org',
        mappings = {
          org = {
            org_toggle_checkbox = '<C-CR>',
          },
        },
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
    --}}}
  },
  { 'lervag/vimtex' },
  --{ 'lervag/lists.vim'},
  { 'dhruvasagar/vim-table-mode' },
  { 'itchyny/calendar.vim',
    keys = {
      { "<leader>cc", "<cmd>Calendar -position=here<cr>" },
    },
    init = function()
      -- See also ftplugin/calendar.vim
      vim.g.calendar_first_day = "monday"
      vim.g.calendar_date_endian = "big"
      vim.g.calendar_frame = "space"
      vim.g.calendar_week_number = 1
    end
  },
  --{ 'vim-pandoc/vim-pandoc'},
  --{ 'vim-pandoc/vim-pandoc-syntax'},
  --{ 'vim-pandoc/vim-pandoc-after'},
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "pandoc" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  { 'mfussenegger/nvim-dap'},
  { 'rcarriga/nvim-dap-ui' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'ldelossa/nvim-dap-projects' },
  { 'saecki/crates.nvim',
    ft = {"rust", "toml"},
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end,
  },
  { 'glepnir/lspsaga.nvim' },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  --{ import = 'custom.plugins' },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
  },
  { 'rouge8/neotest-rust'},
  {'Elzair/ifm-vim'},
}, {})
--}}}

--{{{ Setting options
-- See `:help vim.o`
--require("ibl").setup()

-- Set Cursorline
vim.o.cursorline = true
vim.opt.scrolloff = 5

vim.o.conceallevel = 2
vim.cmd([[
"let g:pandoc#toc#close_after_navigating = 0
"let g:pandoc#folding#fastfolds = 1
let g:pandoc#folding#fold_yaml = 0
let g:pandoc#filetypes#handled = ["markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
]])


-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
--
vim.g.have_nerd_font = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 1000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Spelling
vim.o.spelllang = 'de_de'
vim.o.spell = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
--vim.o.background = "dark"
--}}}

--{{{ neovide
if vim.g.neovide then
  vim.o.guifont = "Comic Code:h10" -- text below applies for VimScript
  vim.g.neovide_transparency = 0.8
end

--}}}

--{{{ Basic Keymaps
--
vim.keymap.set('n', '<leader>ne', ":Neotree current<CR>")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>ne", "<cmd>Neotree toggle<CR>", { desc = 'Toggle N[e]otree' })
vim.keymap.set("n", "<leader>oe", "<cmd>Neotree current<CR>", { desc = '[O]pen N[e]otree' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--}}}

--{{{ Basic Autocommands
--

-- Highlight when yanking text
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
--}}}

--{{{ Configure Telescope
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-j>'] = require('telescope.actions').move_selection_next,
      },
      n = {
        ['n'] = require('telescope.actions').delete_buffer,
      },
    },
    path_display = {
      shorten = 3,
    },
  },
  pickers = {
    lsp_document_symbols = {
      symbol_width = 40,
    },
    lsp_workspace_symbols = {
      symbol_width = 35,
      fname_width = 20,
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>f.', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files ([.] for repeat)' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>f/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    promt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>ft', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' }) --TODO
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = '[F]ind [S]ymbols' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })
--}}}

--{{{ Configure Treesitter
-- See `:help nvim-treesitter`
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'kdl', 'markdown', 'markdown_inline' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

----local parsers = require "nvim-treesitter.parsers"
--local parser_config = parsers.get_parser_configs()
--parser_config.markdown.filetype = "telekasten"
--}}}

--{{{ Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics [Q]ickfix list" })
--}}}

--{{{ LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
--require('neodev').setup({
  --library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
--})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--}}}

--{{{ Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}
-- }}}

--{{{ nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,noselect,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'crates' },
  },
}
-- }}}

--{{{ WIKI.VIM
-- vim.g.wiki_root = '~/vimwiki'
-- vim.g.wiki_root = '~/vimwiki'
-- vim.g.wiki_link_target_type = 'md'
-- vim.g.wiki_link_extension = '.md'
-- vim.g.wiki_filetypes = {'md'}
-- vim.keymap.set('n', '<leader>zd', vim.cmd.WikiJournal)
-- --local M = require 'rossyrg.util.ts'
-- --vim.keymap.set('n', '<leader>wo', M.files_wiki)
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   command = "ListsEnable"
-- })
-- vim.keymap.set('n', '<leader>wt', vim.cmd.ListsToggle, { desc = 'Toggle Todo' })
-- vim.keymap.set('n', '<S-CR>', vim.cmd.ListsToggle, { desc = 'Toggle Todo' })

--}}}

--{{{ Light-Dark Switch
-- local changeBackground = function()
--   local filename = "~/.background"
--   local file, err = io.open(filename)
--   if file == nil then
--     print(err)
--   end
--   local line = file:read()
--   file:close()
--   if line=='dark' then
--     vim.o.background = "dark"
--   else
--     vim.o.background = "light"
--   end
-- end
--
-- changeBackground()

--vim.cmd "autocmd Signal SigUSR1 call changeBackground()"
-- vim.api.nvim_create_autocmd("Signal", {
-- 	pattern = { "SIGUSR1" },
-- 	callback = changeBackground,
-- })
--}}}

--{{{ Table mode
vim.g.table_mode_corner='+'
vim.g.table_mode_corner_corner='+'
vim.g.table_mode_header_fillchar='='
--}}}

--{{{dap

local dap = require('dap')
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    initCommands = function()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end,
  },
}

require("nvim-dap-projects").search_project_config()
require('dapui').setup()
require('nvim-dap-virtual-text').setup()

vim.keymap.set('n', '<leader>dk', function() require'dap'.continue() end, { desc = 'Start/Continue debugging' })
vim.keymap.set('n', '<leader>db', function() require'dap'.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dt', function() require('dapui').toggle() end, { desc = 'Toggle DAP UI' })

vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end, { desc = 'Step Over (Next)' })
vim.keymap.set('n', '<leader>ds', function() require('dap').step_into() end, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = 'Step Out' })
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, { desc = 'Set Breakpoint' })
vim.keymap.set('n', '<Leader>dg', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Logpoint' })
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = 'Open REPL' })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = 'Run Last' })
vim.keymap.set('n', '<Leader>de', function() require('dapui').eval() end, { desc = 'Show Expression' })

require("neotest").setup({
  adapters = {
    require("neotest-rust")({
      dap_adapter = "lldb",
    }),
    --require("neotest-plenary"),
    --require("neotest-vim-test")({
    --ignore_file_types = { "python", "vim", "lua" },
    --}),
  }
})

vim.keymap.set('n', '<Leader>tr', function() require('neotest').run.run() end, { desc = 'Run Test' })
vim.keymap.set('n', '<Leader>td', function() require('neotest').run.run({strategy = "dap"}) end, { desc = 'Debug Test' })
--}}}

--{{{Aerial
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  backends = {
    ['_'] = {"treesitter", "lsp", "markdown", "asciidoc", "man" },
    markdown = {"treesitter"},
  },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>na", "<cmd>AerialToggle!<CR>", { desc = 'Toggle [A]erial' })
vim.keymap.set("n", "<leader>oa", "<cmd>AerialNavToggle<CR>", { desc = 'Toggle [A]erial' })
--}}}

--{{{Colorscheme
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
vim.cmd[[colorscheme tokyonight-night]]
--}}}

--{{{Lualine
require('lualine').setup({
  options = {
    disabled_filetypes = {
      winbar = {"dap-repl"},
    }
  }
})
vim.o.laststatus = 3
--}}}

--{{{ MkDnFlow
-- require('mkdnflow').setup({
--   modules = {
--     bib = true,
--     buffers = true,
--     conceal = true,
--     cursor = true,
--     folds = true,
--     foldtext = true,
--     links = true,
--     lists = true,
--     maps = true,
--     paths = true,
--     tables = true,
--     yaml = false,
--     cmp = false
--   },
--   filetypes = {md = true, rmd = true, markdown = true},
--   create_dirs = true,
--   perspective = {
--     priority = 'first',
--     fallback = 'current',
--     root_tell = false,
--     nvim_wd_heel = false,
--     update = false
--   },
--   wrap = false,
--   bib = {
--     default_path = nil,
--     find_in_root = true
--   },
--   silent = false,
--   cursor = {
--     jump_patterns = nil
--   },
--   links = {
--     style = 'markdown',
--     name_is_source = false,
--     conceal = false,
--     context = 0,
--     implicit_extension = nil,
--     transform_implicit = false,
--     transform_explicit = function(text)
--       text = text:gsub(" ", "-")
--       text = text:lower()
--       text = os.date('%Y-%m-%d_')..text
--       return(text)
--     end,
--     create_on_follow_failure = true
--   },
--   new_file_template = {
--     use_template = false,
--     placeholders = {
--       before = {
--         title = "link_title",
--         date = "os_date"
--       },
--       after = {}
--     },
--     template = "# {{ title }}"
--   },
--   to_do = {
--     symbols = {' ', '-', 'X'},
--     update_parents = true,
--     not_started = ' ',
--     in_progress = '-',
--     complete = 'X'
--   },
--   foldtext = {
--     object_count = true,
--     object_count_icons = 'emoji',
--     object_count_opts = function()
--       return require('mkdnflow').foldtext.default_count_opts()
--     end,
--     line_count = true,
--     line_percentage = true,
--     word_count = false,
--     title_transformer = nil,
--     separator = ' · ',
--     fill_chars = {
--       left_edge = '⢾',
--       right_edge = '⡷',
--       left_inside = ' ⣹',
--       right_inside = '⣏ ',
--       middle = '⣿',
--     },
--   },
--   tables = {
--     trim_whitespace = true,
--     format_on_move = true,
--     auto_extend_rows = false,
--     auto_extend_cols = false,
--     style = {
--       cell_padding = 1,
--       separator_padding = 1,
--       outer_pipes = true,
--       mimic_alignment = true
--     }
--   },
--   yaml = {
--     bib = { override = false }
--   },
--   mappings = {
--     MkdnFollowLink = {{'n', 'v'}, '<CR>'},
--     MkdnTab = false,
--     MkdnSTab = false,
--     MkdnNextLink = {'n', '<Tab>'},
--     MkdnPrevLink = {'n', '<S-Tab>'},
--     MkdnNextHeading = {'n', ']]'},
--     MkdnPrevHeading = {'n', '[['},
--     MkdnGoBack = {'n', '<BS>'},
--     MkdnGoForward = {'n', '<Del>'},
--     MkdnCreateLink = false, -- see MkdnEnter
--     MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>p'}, -- see MkdnEnter
--     --MkdnFollowLink = false, -- see MkdnEnter
--     MkdnDestroyLink = {'n', '<M-CR>'},
--     MkdnTagSpan = {'v', '<M-CR>'},
--     MkdnMoveSource = {'n', '<F2>'},
--     MkdnYankAnchorLink = {'n', 'yaa'},
--     MkdnYankFileAnchorLink = {'n', 'yfa'},
--     MkdnIncreaseHeading = {'n', '+'},
--     MkdnDecreaseHeading = {'n', '-'},
--     MkdnToggleToDo = {{'n', 'v'}, '<S-CR>'},
--     MkdnNewListItem = false,
--     MkdnNewListItemBelowInsert = {'n', 'o'},
--     MkdnNewListItemAboveInsert = {'n', 'O'},
--     MkdnExtendList = false,
--     MkdnUpdateNumbering = {'n', '<leader>nn'},
--     MkdnTableNextCell = {'i', '<Tab>'},
--     MkdnTablePrevCell = {'i', '<S-Tab>'},
--     MkdnTableNextRow = false,
--     MkdnTablePrevRow = {'i', '<M-CR>'},
--     MkdnTableNewRowBelow = {'n', '<leader>ir'},
--     MkdnTableNewRowAbove = {'n', '<leader>iR'},
--     MkdnTableNewColAfter = {'n', '<leader>ic'},
--     MkdnTableNewColBefore = {'n', '<leader>iC'},
--     MkdnFoldSection = {'n', '<leader>f'},
--     MkdnUnfoldSection = {'n', '<leader>F'}
--   }
-- })
--}}}

-- vim: ts=2 sts=2 sw=2 et
-- vim:foldmethod=marker
-- vim:foldlevel=0
