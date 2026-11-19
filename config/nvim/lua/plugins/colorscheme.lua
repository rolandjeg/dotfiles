return {
  {
    "rebelot/kanagawa.nvim", -- Colorscheme
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
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
            all = {},
          },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
      --vim.cmd([[colorscheme kanagawa]])
    end,
  },
  {
    "serhez/teide.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      custom_highlights = function(c)
        return {
          -- Change line number and sign column background
          LineNrAbove = {
            fg = c.mauve,
            bg = c.surface1, -- set your desired background hex color
          },
          LineNrBelow = {
            fg = c.mauve,
            bg = c.surface1, -- set your desired background hex color
          },
          SignColumn = {
            bg = c.surface0, -- match the LineNr background
          },
          -- Optional: if you want to style the current line number differently
          CursorLineNr = {
            fg = c.peach,
            bg = c.surface0,
          },
        }
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_colors = function(colors)
        colors.comment = "#a0a0a0"
      end,
      on_highlights = function(hl, c)
        -- Change line number and sign column background
        hl.LineNrAbove = {
          fg = c.blue,
          bg = c.bg_highlight, -- set your desired background hex color
        }
        hl.LineNrBelow = {
          fg = c.blue,
          bg = c.bg_highlight, -- set your desired background hex color
        }
        hl.SignColumn = {
          bg = c.bg_highlight, -- match the LineNr background
        }
        -- Optional: if you want to style the current line number differently
        hl.CursorLineNr = {
          fg = c.yellow,
          bg = c.bg_highlight,
        }
      end,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
}
