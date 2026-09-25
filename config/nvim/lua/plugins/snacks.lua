return {
  {
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
  },
}
