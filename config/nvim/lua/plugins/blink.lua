return {
  "saghen/blink.cmp", -- Autocompletion
  opts = {
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
      ["<C-s>"] = {
        "show_signature",
        "fallback",
      },
      ["<C-h>"] = {
        "snippet_backward",
        "fallback",
      },
      ["<C-l>"] = {
        "snippet_forward",
        "fallback",
      },
      ["<C-j>"] = {
        "select_next",
        "fallback",
      },
      ["<C-k>"] = {
        "select_prev",
        "fallback",
      },
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
    },
  },
}
