-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  -- Snacks utils
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      terminal = {
        win = {
          keys = {
            nav_h = { "<C-h>", term_nav("h"), desc = "转到左侧窗口", expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav("j"), desc = "转到下方窗口", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav("k"), desc = "转到上方窗口", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav("l"), desc = "转到右侧窗口", expr = true, mode = "t" },
          },
        },
      },
    },
    -- Lance: 不使用
    --keys = {
    --  { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    --  { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    --  { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
    --},
  },

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "还原会话" },
      { "<leader>qS", function() require("persistence").select() end,desc = "选择会话" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "还原最近会话" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "不保存当前会话" },
      { "<leader>qq", "<cmd>qa!<CR>", desc = "不保存退出" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
