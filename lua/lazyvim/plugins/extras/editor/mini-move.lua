return {
  -- Lance: 文本块移动插件
  "echasnovski/mini.move",
  event = "VeryLazy",
  version = false,
  config = function()
    require("mini.move").setup({
      mappings = {
        -- 可视模式下向左移动选中区域
        left = "<S-h>",
        -- 可视模式下向右移动选中区域
        right = "<S-l>",
        -- 可视模式下向下移动选中区域
        down = "<S-j>",
        -- 可视模式下向上移动选中区域
        up = "<S-k>",
        -- 正常模式下向下移动整行
        line_down = "<A-j>",
        -- 正常模式下向上移动整行
        line_up = "<A-k>",
      },
    })
  end,
}
