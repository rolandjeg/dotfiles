--{{{ Setting options
-- See `:help vim.o`
--require("ibl").setup()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
--vim.g.markdown_folding = 1
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- Set Cursorline
vim.o.cursorline = true
vim.opt.scrolloff = 5

vim.o.conceallevel = 2
--vim.cmd([[
--"let g:pandoc#toc#close_after_navigating = 0
--"let g:pandoc#folding#fastfolds = 1
--let g:pandoc#folding#fold_yaml = 0
--let g:pandoc#filetypes#handled = ["markdown"]
--let g:pandoc#filetypes#pandoc_markdown = 0
--]])

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
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
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 1000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Spelling
vim.o.spelllang = "de_de"
vim.o.spell = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.scrolloff = 10

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
--vim.o.background = "dark"
--}}}

--{{{ Basic Keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<leader>ne", ":Neotree current<CR>")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>ne", "<cmd>Neotree toggle<CR>", { desc = "Toggle N[e]otree" })
vim.keymap.set("n", "<leader>oe", "<cmd>Neotree current<CR>", { desc = "[O]pen N[e]otree" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
--}}}

--{{{ Basic Autocommands
--

-- Highlight when yanking text
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
--}}}

--{{{ Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
--}}}

--{{{ Plugins
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
  { "nvim-neotest/nvim-nio" }, -- IO async
  {
    "NMAC427/guess-indent.nvim",
    -- {{{
    config = function()
      require('guess-indent').setup {}
    end,
    -- }}}
  }, -- Detect tabstop and shiftwidth automatically
  {
    "neovim/nvim-lspconfig",
    --{{{
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim",    opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- See `:help K` for why this keymap
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
              client
              and client_supports_method(
                client,
                vim.lsp.protocol.Methods.textDocument_documentHighlight,
                event.buf
              )
          then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if
              client
              and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
          then
            map("<leader>nh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay [H]ints")
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
      vim.lsp.config('ltex_plus', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- your other on_attach code
          -- for example, set keymaps here, like
          -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          -- (see below code block for more details)
          require("ltex-utils").on_attach(bufnr)
        end,
        settings = {
          ltex = {
            markdown = {
              nodes = {
                ["CodeBlock"] = "ignore",
                ["FencedCodeBlock"] = "ignore",
                ["InlineCode"] = "ignore",
                ["Link"] = "ignore",
                ["AutoLink"] = "ignore",
                ["DelimitedLinkNode"] = "ignore",
                ["LinkNode"] = "ignore",
                ["LinkRef"] = "ignore",
                ["LinkNodeBase"] = "ignore",
              },
            },
          },
        },
      })
    end,
    -- }}}
  },
  {
    'SCJangra/table-nvim',
    -- {{{
    ft = 'markdown',
    opts = {},
    -- }}}
  },
  {
    "stevearc/conform.nvim", -- Autoformat
    -- {{{
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      end,
      formatters_by_ft = {
        --lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    -- }}}
  },
  {
    "saghen/blink.cmp", -- Autocompletion
    -- {{{
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      -- Snippet Engine
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      "folke/lazydev.nvim",
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = "enter",
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          "fallback",
        },

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },

      snippets = { preset = "luasnip" },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = "lua" },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
    -- }}}
  },
  {
    "folke/lazydev.nvim",
    --{{{ `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
    -- }}}
  },
  {
    "folke/todo-comments.nvim", -- Hilight todo, notes etc in comments
    -- {{{
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    -- }}}
  },
  {
    "echasnovski/mini.nvim", -- Collection of various small independent plugins/modules
    -- {{{

    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require("mini.statusline")
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
    -- }}}
  },
  {
    "folke/which-key.nvim", -- Useful plugin to show you pending keybinds.
    --{{{
    event = "VeryLazy",
    opts = {
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },
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
        { "gx",        desc = "Open with xgd-open" },
        { "<leader>",  group = "VISUAL <leader>",  mode = "v" },
        { "<leader>h", desc = "Git [H]unk",        mode = "v" },
      },
    },
    --}}}
  },
  {
    "lewis6991/gitsigns.nvim", -- Adds git releated signs to the gutter, as well as utilities for managing changes
    --{{{
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { desc = "Jump to next git [c]hange" })

        map({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { desc = "Jump to previous git [c]hange" })

        -- Actions
        -- visual mode
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "git [s]tage hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "git [r]eset hunk" })
        -- normal mode
        map("n", "<leader>hs", gs.stage_hunk, { desc = "git [s]tage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "git [r]eset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "git [S]tage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "git [R]eset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "git [p]review hunk" })
        map("n", "<leader>hb", gs.blame_line, { desc = "git [b]lame line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "git [d]iff against index" })
        map("n", "<leader>hD", function()
          gs.diffthis("@")
        end, { desc = "git [D]iff against last commit" })

        -- Toggles
        map("n", "<leader>nb", gs.toggle_current_line_blame, { desc = "toggle git show [b]lame line" })
        map("n", "<leader>nd", gs.toggle_deleted, { desc = "toggle git show [d]eleted" })
      end,
    },
    --}}}
  },
  {
    "folke/tokyonight.nvim", -- Colorscheme
    -- {{{
    priority = 1000,
    config = function()
      local styles = require("tokyonight.colors").styles
      ---@type Palette
      local mod_colors = {
        comment = '#a0a0a0',
        --diff.change = "#3b4291"
      }
      ---@type Palette
      --local diff_colors = {
      --diff { change = '#000000', }
      --}
      --local diff_colors = {
      --DiffChange = {
      --bg = "#3b4291"
      --}
      --}
      styles.moon = vim.tbl_extend("force", styles.moon --[[@as Palette]], mod_colors)
      --styles.moon = vim.tbl_extend("force", styles.moon --[[@as Palette]], diff_colors)
      --styles.moon = vim.tbl_extend("force", styles.moon --[[@as Palette]], diff_colors)
      --highlights.moon = vim.tbl_extend("force", styles.moon --[[@as Palette]], diff_colors)
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
          colors.diff = { change = "#000000", }
        end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors)
          --highlights.DiffChange = {
          --bg = "#3b4291"
          --}
          highlights.LineNrAbove = {
            fg = "#808080"
          }
          highlights.LineNrBelow = {
            fg = "#808080"
          }
        end,
      })
      --vim.cmd([[colorscheme tokyonight-night]])
    end,
    -- }}}
  },
  {
    "ellisonleao/gruvbox.nvim", -- Colorscheme
    -- {{{
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
    -- }}}
  },
  {
    "EdenEast/nightfox.nvim", -- Colorscheme
    -- {{{
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = false,               -- Disable setting background
          terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,              -- Non focused panes set to alternative background
          module_default = true,             -- Default enable value for modules
          colorblind = {
            enable = false,                  -- Enable colorblind support
            simulate_only = false,           -- Only show simulated colorblind colors and not diff shifted
            severity = {
              protan = 0,                    -- Severity [0,1] for protan (red)
              deutan = 0,                    -- Severity [0,1] for deutan (green)
              tritan = 0,                    -- Severity [0,1] for tritan (blue)
            },
          },
          styles = {           -- Style to be applied to different syntax groups
            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {
          duskfox = {
            comment = "#a0a0a0",
            fg3 = "#808080",
          }
        },
        specs = {},
        groups = {},
      })
      --vim.cmd([[colorscheme gruvbox]])
    end,
    -- }}}
  },
  {
    "rebelot/kanagawa.nvim", -- Colorscheme
    -- {{{
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {
              diff = {
                change = "#3b4291",
              },
              syn = {
                comment = "#a0a0a0",
              },
              ui = {
                nontext = "#808080",
              },
            },
            lotus = {},
            dragon = {},
            all = {}
          },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",  -- Load "wave" theme
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })
    end,
    -- }}}
  },
  {
    "nvim-lualine/lualine.nvim",
    --{{{ Set lualine as statusline
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },

      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    },
    --}}}
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    --{{{
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {},
    --}}}
  },
  { -- "gc" to comment visual regions/lines
    "numToStr/Comment.nvim", opts = {}
  },
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    --{{{
    version = "*",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
            },
            n = {
              ["n"] = require("telescope.actions").delete_buffer,
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
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set(
        "n",
        "<leader>f.",
        builtin.oldfiles,
        { desc = "Find recently opened files ([.] for repeat)" }
      )
      vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep({
          grep_open_files = true,
          promt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch [/] in Open Files" })

      vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[S]earch Select [T]elescope" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" }) --TODO
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "[F]ind [S]ymbols" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
    end,
    --}}}
  },
  -- {
  --   "ibhagwan/fzf-lua",
  --   -- {{{
  --   -- optional for icon support
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     -- calling `setup` is optional for customization
  --     require("fzf-lua").setup({})
  --   end,
  --   -- }}}
  -- },
  {
    "renerocksai/telekasten.nvim",
    --{{{ Zettelkasten
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>zw", "<cmd>Telekasten panel<cr>",           desc = "Telekasten which?" },

      -- Most used functions
      { "<leader>zf", "<cmd>Telekasten find_notes<CR>",      desc = "Telekasten [f]ind notes" },
      { "<leader>zg", "<cmd>Telekasten search_notes<CR>",    desc = "Telekasten [g]oto notes" },
      { "<leader>zd", "<cmd>Telekasten goto_today<CR>",      desc = "Telekasten to[d]ay" },
      { "<leader>zz", "<cmd>Telekasten follow_link<CR>",     desc = "Telekasten follow link" },
      { "<leader>zn", "<cmd>Telekasten new_note<CR>",        desc = "Telekasten [n]ew note" },
      { "<leader>zc", "<cmd>Telekasten show_calendar<CR>",   desc = "Telekasten [c]alendar" },
      { "<leader>zb", "<cmd>Telekasten show_backlinks<CR>",  desc = "Telekasten show [b]acklinks" },
      { "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", desc = "Telekasten insert [I]mage link" },
      { "<leader>zi", "<cmd>Telekasten insert_link<CR>",     desc = "Telekasten [i]nsert link" },
      { "<leader>zt", "<cmd>Telekasten toggle_todo<CR>",     desc = "Telekasten [t]odo toggle" },
      { "<leader>zv", "<cmd>Telekasten switch_vault<CR>",    desc = "Telekasten switch [v]ault" },
    },
    config = function()
      require("telekasten").setup({
        home = vim.fn.expand("~/zk/default"),
        dailies = vim.fn.expand("~/zk/default/dailies"),
        weeklies = vim.fn.expand("~/zk/default/weeklies"),
        template_new_note = vim.fn.expand("~/zk/templates/new_note.md"),
        img_subdir = vim.fn.expand("~/zk/default/img"),

        new_note_filename = "title",
        auto_set_filetype = false,
        filename_small_case = true,
        vaults = {
          cryptoagility = {
            home = vim.fn.expand("~/zk/cryptoagility"),
            template_new_note = vim.fn.expand("~/zk/templates/new_note.md"),
            auto_set_filetype = false,
          },
          promotion = {
            home = vim.fn.expand("~/zk/promotion"),
            template_new_note = vim.fn.expand("~/zk/templates/new_note.md"),
            auto_set_filetype = false,
          },
          uniform = {
            home = vim.fn.expand("~/projekte/uniform/zettelkasten"),
            template_new_note = vim.fn.expand("~/zk/templates/new_note.md"),
            auto_set_filetype = false,
          },
          atruvia = {
            home = vim.fn.expand("~/zk/atruvia"),
            dailies = vim.fn.expand("~/zk/atruvia/dailies"),
            weeklies = vim.fn.expand("~/zk/atruvia/weeklies"),
            template_new_note = vim.fn.expand("~/zk/templates/new_note.md"),
            img_subdir = vim.fn.expand("~/zk/atruvia/img"),

            new_note_filename = "title",
            auto_set_filetype = false,
          },
        },
      })
    end,
    --}}}
  },
  {
    "zk-org/zk-nvim",
    --{{{
    config = function()
      require("zk").setup({
        --   -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
        picker = "telescope",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end,
    --}}}
  },
  {
    "lervag/vimtex",
    -- {{{
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end
    -- }}}
  },
  { -- LTEX-Plus language Server utilities
    "jhofscheier/ltex-utils.nvim",
    --{{{
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      -- "nvim-telescope/telescope-fzf-native.nvim", -- optional
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    --}}}
  },
  --{
  --"dhruvasagar/vim-table-mode",
  --{{{
  --config = function()
  --vim.g.table_mode_corner = "+"
  --vim.g.table_mode_corner_corner = "+"
  --vim.g.table_mode_header_fillchar = "="
  --end
  --}}}
  --},
  {
    "itchyny/calendar.vim",
    --{{{
    keys = {
      { "<leader>cc", "<cmd>Calendar -position=here<cr>" },
    },
    init = function()
      -- See also ftplugin/calendar.vim
      vim.g.calendar_first_day = "monday"
      vim.g.calendar_date_endian = "big"
      vim.g.calendar_frame = "space"
      vim.g.calendar_week_number = 1
    end,
    --}}}
  },
  {
    "iamcco/markdown-preview.nvim",
    --{{{
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "pandoc" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    --}}}
  },
  { -- DAP Plugin
    "mfussenegger/nvim-dap",
    --{{{
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',
      "theHamsta/nvim-dap-virtual-text",
      "ldelossa/nvim-dap-projects",

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    --}}}
  },
  {
    "saecki/crates.nvim",
    --{{{
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
    --}}}
  },
  { "glepnir/lspsaga.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    --{{{
    branch = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false,
    keys = { '\\\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\\\'] = 'close_window',
          },
        },
      },
    },
    --}}}
  },
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
      require("tree-sitter-manager").setup()
    end,
  },
  {
    "stevearc/aerial.nvim",
    --{{{
    opts = {},
    -- Optional dependencies
    dependencies = {
      --"nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    --}}}
  },
  {
    "nvim-neotest/neotest",
    --{{{
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      --"nvim-treesitter/nvim-treesitter",
    },
    --}}}
  },
  { "rouge8/neotest-rust" },
  { "Elzair/ifm-vim" },
  -- TODO: Plugins evaluieren
  --
  --{ 'lervag/lists.vim'},
  --{ 'vim-pandoc/vim-pandoc'},
  --{ 'vim-pandoc/vim-pandoc-syntax'},
  --{ 'vim-pandoc/vim-pandoc-after'},
  -- {
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup({
  --       -- Config goes here; leave blank for defaults
  --     })
  --   end
  -- },
  --{ 'nvim-orgmode/orgmode',
  --  -- Orgmode
  --  event = 'VeryLazy',
  --  ft = { 'org' },
  --  config = function()
  --    -- Setup orgmode
  --    require('orgmode').setup({
  --      org_agenda_files = '~/org/**/*',
  --      org_default_notes_file = '~/org/refile.org',
  --      mappings = {
  --        org = {
  --          org_toggle_checkbox = '<C-CR>',
  --        },
  --      },
  --    })

  --    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
  --    -- add ~org~ to ignore_install
  --    -- require('nvim-treesitter.configs').setup({
  --    --   ensure_installed = 'all',
  --    --   ignore_install = { 'org' },
  --    -- })
  --  end,
  --
  --},
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
--}}}

--{{{ Light-Dark Switch
local changeBackground = function()
  local filename = "/home/groell/.background"
  local file, err = io.open(filename)
  if file == nil then
    print(err)
  end
  local line = file:read()
  file:close()
  if line == "dark" then
    vim.o.background = "dark"
    vim.cmd([[colorscheme kanagawa]])
    require("lualine").setup({
      options = {
        theme = "kanagawa",
      },
    })
    --require('lualine').setup({ options = { theme = tokyonight }})
  else
    vim.o.background = "light"
    vim.cmd([[colorscheme kanagawa]])
    require("lualine").setup({
      options = {
        theme = "kanagawa",
      },
    })
  end
end

changeBackground()

vim.cmd("autocmd Signal SigUSR1 call changeBackground()")
vim.api.nvim_create_autocmd("Signal", {
  pattern = { "SIGUSR1" },
  callback = changeBackground,
})
--}}}

--{{{dap

local dap = require("dap")
dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  },
}

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
  name = "lldb",
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    initCommands = function()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

      local commands = {}
      local file = io.open(commands_file, "r")
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
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<leader>dk", function()
  require("dap").continue()
end, { desc = "Start/Continue debugging" })
vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dt", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })

vim.keymap.set("n", "<leader>dn", function()
  require("dap").step_over()
end, { desc = "Step Over (Next)" })
vim.keymap.set("n", "<leader>ds", function()
  require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<Leader>dB", function()
  require("dap").set_breakpoint()
end, { desc = "Set Breakpoint" })
vim.keymap.set("n", "<Leader>dg", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Logpoint" })
vim.keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })
vim.keymap.set("n", "<Leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last" })
vim.keymap.set("n", "<Leader>de", function()
  require("dapui").eval()
end, { desc = "Show Expression" })

require("neotest").setup({
  adapters = {
    require("neotest-rust")({
      dap_adapter = "lldb",
    }),
    --require("neotest-plenary"),
    --require("neotest-vim-test")({
    --ignore_file_types = { "python", "vim", "lua" },
    --}),
  },
})

vim.keymap.set("n", "<Leader>tr", function()
  require("neotest").run.run()
end, { desc = "Run Test" })
vim.keymap.set("n", "<Leader>td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug Test" })
--}}}

--{{{Aerial
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  backends = {
    ["_"] = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
    markdown = { "treesitter" },
  },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>na", "<cmd>AerialToggle!<CR>", { desc = "Toggle [A]erial" })
vim.keymap.set("n", "<leader>oa", "<cmd>AerialNavToggle<CR>", { desc = "Toggle [A]erial" })
--}}}

--{{{Lualine
require("lualine").setup({
  options = {
    disabled_filetypes = {
      winbar = { "dap-repl" },
    },
  },
})
vim.o.laststatus = 3
changeBackground()
--}}}

changeBackground()
-- vim: ts=2 sts=2 sw=2 et
-- vim:foldmethod=marker
-- vim:foldlevel=0
