return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in 4.0.0
      --note_id_func = require("obsidian.builtin").title_id,
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },
    },
    keys = {
      { "<leader>zw", "<cmd>Obsidian<cr>", desc = "Obsidian which?" },

      -- Most used functions
      { "<leader>zf", "<cmd>Obsidian quick_switch<CR>", desc = "Obsidian [f]ind notes" },
      { "<leader>zg", "<cmd>Telekasten search_notes<CR>", desc = "Telekasten [g]oto notes" },
      { "<leader>zd", "<cmd>Obsidian today<CR>", desc = "Obsidian to[d]ay" },
      --{ "<leader>zz", "<cmd>Telekasten follow_link<CR>",     desc = "Telekasten follow link" },
      { "<leader>zn", "<cmd>Obsidian new<CR>", desc = "Obsidian [n]ew note" },
      --{ "<leader>zc", "<cmd>Telekasten show_calendar<CR>",   desc = "Telekasten [c]alendar" },
      { "<leader>zb", "<cmd>Obsidian backlinks<CR>", desc = "Obsidian show [b]acklinks" },
      { "<leader>zI", "<cmd>Obsidian paste_image<CR>", desc = "Obsidian insert [I]mage link" },
      { "<leader>zi", "<cmd>Obsidian linl<CR>", desc = "Obsidian [i]nsert link" },
      { "<leader>zt", "<cmd>Obsidian toggle_checkbox<CR>", desc = "Obsidian [t]odo toggle" },
      { "<leader>zv", "<cmd>Obsidian workspace<CR>", desc = "Obsidian switch [v]ault" },
    },
    config = function()
      require("obsidian").setup({
        note_id_func = require("obsidian.builtin").title_id,
        legacy_commands = false, -- this will be removed in 4.0.0
        --note_id_func = require("obsidian.builtin").title_id,
        --note = {
        --template = "~/vaults/templates/new_note.md",
        --},
        workspaces = {
          {
            name = "personal",
            path = "~/vaults/personal",
          },
          {
            name = "work",
            path = "~/vaults/work",
            overrides = {
              note = {
                template = "~/vaults/templates/new_note.md",
              },
            },
          },
          {
            name = "atruvia",
            path = "~/vaults/work",
            overrides = {
              note = {
                template = "~/vaults/templates/new_note_atruvia.md",
              },
            },
          },
        },
        checkbox = {
          enabled = true,
          create_new = true,
          order = { " ", ">", "x" },
        },
        ui = {
          enable = true,
          hl_groups = {
            ObsidianBullet = { bold = true, fg = "#f103d2" },
            ObsidianDone = { bold = true, fg = "#f103d2" },
            ObsidianTag = { italic = true, fg = "#f103d2" },
            ObsidianBlockID = { italic = true, fg = "#f103d2" },
            ObsidianRefText = { fg = "#f103d2" },
          },
        },
      })
    end,
  },
}
