return {
  -- Lance: 多光标操作插件
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()
    local set = vim.keymap.set
    set({ "n", "x" }, "<leader>mm", function()
      mc.addCursor()
    end, { desc = "在当前位置标记光标" })
    set({ "n", "x" }, "<leader>mk", function()
      mc.lineAddCursor(-1)
    end, { desc = "在上方增加光标" })
    set({ "n", "x" }, "<leader>mj", function()
      mc.lineAddCursor(1)
    end, { desc = "在下方增加光标" })
    set({ "n", "x" }, "<leader>mK", function()
      mc.lineSkipCursor(-1)
    end, { desc = "跳过在上方增加光标" })
    set({ "n", "x" }, "<leader>mJ", function()
      mc.lineSkipCursor(1)
    end, { desc = "跳过在下方增加光标" })
    set({ "n", "x" }, "<leader>mn", function()
      mc.matchAddCursor(1)
    end, { desc = "在下一个匹配单词增加光标" })
    set({ "n", "x" }, "<leader>mp", function()
      mc.matchAddCursor(1)
    end, { desc = "在上一个匹配单词增加光标" })
    set({ "n", "x" }, "<leader>mN", function()
      mc.matchSkipCursor(1)
    end, { desc = "跳过下一个匹配单词增加光标" })
    set({ "n", "x" }, "<leader>mP", function()
      mc.matchSkipCursor(1)
    end, { desc = "跳过上一个匹配单词增加光标" })
    set({ "n", "x" }, "<leader>mh", mc.nextCursor, { desc = "跳转到上一光标" })
    set({ "n", "x" }, "<leader>ml", mc.prevCursor, { desc = "跳转到下一光标" })
    set({ "n", "x" }, "<leader>md", mc.deleteCursor, { desc = "删除当前光标" })
    set({ "n", "x" }, "<leader>mD", mc.toggleCursor, { desc = "跳出光标选择" })
    set({ "n", "x" }, "<leader>mc", mc.matchCursors, { desc = "设置/取消当前光标选择" })

    -- Lance: 使用Ctrl+鼠标操作多光标
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)
    set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- Default <esc> handler.
      end
    end)

    -- -- In normal/visual mode, press `mwap` will create a cursor in every match of
    -- -- the word captured by `iw` (or visually selected range) inside the bigger
    -- -- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
    -- set({ "n", "x" }, "mw", function()
    --   mc.operator({ motion = "iw", visual = true })
    --   -- Or you can pass a pattern, press `mwi{` will select every \w,
    --   -- basically every char in a `{ a, b, c, d }`.
    --   -- mc.operator({ pattern = [[\<\w]] })
    -- end)
    -- -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
    -- set("n", "mW", mc.operator)
    -- -- Add all matches in the document
    -- set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors) --匹配所有增加光标
    -- -- Clone every cursor and disable the originals.
    -- -- bring back cursors if you accidentally clear them
    -- set("n", "<leader>gv", mc.restoreCursors)
    --
    -- -- Align cursor columns.
    -- set("n", "<leader>a", mc.alignCursors)
    --
    -- -- Split visual selections by regex.
    -- set("x", "S", mc.splitCursors)
    --
    -- -- Append/insert for each line of visual selections.
    -- set("x", "I", mc.insertVisual)
    -- set("x", "A", mc.appendVisual)
    --
    -- -- match new cursors within visual selections by regex.
    -- set("x", "M", mc.matchCursors)
    --
    -- -- Rotate visual selection contents.
    -- set("x", "<leader>t", function()
    --   mc.transposeCursors(1)
    -- end)
    -- set("x", "<leader>T", function()
    --   mc.transposeCursors(-1)
    -- end)
    --
    -- -- Jumplist support
    -- set({ "x", "n" }, "<c-i>", mc.jumpForward)
    -- set({ "x", "n" }, "<c-o>", mc.jumpBackward)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
