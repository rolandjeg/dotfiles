return {
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = {
        ["_"] = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
        markdown = { "treesitter" },
      },
      layout = {
        max_width = 200,
        width = nil,
        min_width = 10,
        resize_to_content = true,
        preserve_equality = false,
      },
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>na", "<cmd>AerialToggle!<cr>", desc = "Toggle Aerial" },
      { "<leader>fa", "<cmd>AerialToggle!<cr>", desc = "Toggle Aerial" },
      { "<leader>a", "<cmd>AerialToggle!<cr>", desc = "Toggle Aerial" },
      { "<leader>fs", "<cmd>AerialNavToggle<cr>", desc = "Find Symbols (Aerial)" },
    },
  },
}
