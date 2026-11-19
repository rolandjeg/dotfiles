return { -- LTEX-Plus language Server utilities
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
  setup = {
    require("lspconfig").ltex_plus.setup({
      --capabilities = your_capabilities,
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
    }),
  },
}
