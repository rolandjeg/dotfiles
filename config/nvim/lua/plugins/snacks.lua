return {
  "snacks.nvim",
  keys = {
    {
      "<leader>nn",
      function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end,
      desc = "Notification History",
    },
    {
      "<leader>ne",
      function()
        Snacks.picker.explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
  },
  terminal = {
    win = {
      keys = {
        --nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
        --nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
        --nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
        --nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
        hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
        hide_underscore = { "<c-_>", "hide", desc = "which_key_ignore", mode = "t" },
      },
    },
  },
}
