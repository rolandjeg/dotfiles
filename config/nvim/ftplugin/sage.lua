vim.lsp.config("sage_lsp", {
  cmd = { "/home/groell/venv/bin/sagelsp" },
  filetypes = { "sage" },
  root_markers = { ".git" },
})

vim.lsp.enable("sage_lsp")
