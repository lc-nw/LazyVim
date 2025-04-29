-- This file is automatically loaded by lazyvim.config.init
-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

-- Lance: 使用习惯键盘映射
map("n", "J", "5j", { desc = "向下移动5行" })
map("n", "K", "5k", { desc = "向上移动5行" })
map("n", "H", "^", { desc = "光标移动到当前行首" })
map("n", "L", "$", { desc = "光标移动到当前行尾" })
map("i", "jk", "<ESC>", { desc = "退出到普通模式" })
map("i", "jj", "<ESC>", { desc = "退出到普通模式" })
map("c", "jk", "<ESC>", { desc = "退出到普通模式" })
map("c", "jj", "<ESC>", { desc = "退出到普通模式" })

-- 使用Ctrl+hjkl进行窗口焦点移动
map("n", "<C-h>", "<C-w>h", { desc = "转到左侧窗口", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "转到下方窗口", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "转到上方窗口", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "转到右侧窗口", remap = true })

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "LazyGit (根目录)" })
  map("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "LazyGit" })
  map("n", "<leader>gf", function()
    Snacks.picker.git_log_file()
  end, { desc = "Git文件历史" })
  map("n", "<leader>gl", function()
    Snacks.picker.git_log({ cwd = LazyVim.root.git() })
  end, { desc = "Git日志查看 (根目录)" })
  map("n", "<leader>gL", function()
    Snacks.picker.git_log()
  end, { desc = "Git日志查看" })
end
