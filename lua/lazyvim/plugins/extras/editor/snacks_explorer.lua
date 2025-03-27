return {
  desc = "Snacks File Explorer",
  recommended = true,
  "folke/snacks.nvim",
  opts = { explorer = {} },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "资源浏览 (根目录)",
    },
    {
      "<leader>E",
      function()
        Snacks.explorer()
      end,
      desc = "资源浏览",
    },
  },
}
