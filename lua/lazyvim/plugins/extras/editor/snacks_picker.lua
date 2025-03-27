if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "snacks"
end

---@module 'snacks'

---@type LazyPicker
local picker = {
  name = "snacks",
  commands = {
    files = "files",
    live_grep = "grep",
    oldfiles = "recent",
  },

  ---@param source string
  ---@param opts? snacks.picker.Config
  open = function(source, opts)
    return Snacks.picker.pick(source, opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

return {
  desc = "Fast and modern file picker",
  recommended = true,
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-c>"] = {
                "toggle_cwd",
                mode = { "n", "i" },
              },
            },
          },
        },
        actions = {
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>/", LazyVim.pick("grep"), desc = "查找文本 (根目录)" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "命令历史" },
      { "<leader><space>", LazyVim.pick("files"), desc = "查找文件 (根目录)" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" }, --Lance: 不生效
      -- find
      --{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" }, --Lance: 使用<leader>be代替
      --{ "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" }, --Lance: 不经常使用
      { "<leader>fc", LazyVim.pick.config_files(), desc = "查找配置文件" },
      --{ "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      --{ "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      --{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
      { "<leader>fr", LazyVim.pick("oldfiles"), desc = "查找最近文件 (根目录)" },
      { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "查找最近文件" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "查找项目文件" },
      -- git
      -- Lance: 不经常使用
      --{ "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      --{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
      --{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      --{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "在当前Buffer定位" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "在打开Buffer定位" },
      { "<leader>sg", LazyVim.pick("live_grep"), desc = "查找文本 (根目录)" },
      { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "查找文本" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "查找插件信息" },
      --Lance: 不清楚具体效果
      --{ "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      --{ "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "查找剪切板" },
      --{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" }, --Lance:不清楚具体效果
      --{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "查找命令实现" }, --Lance:不经常使用
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "查找命令历史" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "查找命令信息" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "查找诊断信息" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "查找当前Buffer诊断" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "查找Help页面" },
      --{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "查找高亮信息" }, --Lance:不经常使用
      { "<leader>si", function() Snacks.picker.icons() end, desc = "查找图标信息" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "查找跳转历史" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "查找键盘映射" },
      --{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" }, --Lance:不清楚具体效果
      { "<leader>sM", function() Snacks.picker.man() end, desc = "查找Man页面" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "查找Marks标识" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "查找摘要" },
      --{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "查找修复列表" }, --Lance:不清楚具体效果
      { "<leader>su", function() Snacks.picker.undo() end, desc = "查找回退历史" },
      -- ui
      --{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
  },
  --{
  --"folke/snacks.nvim",
  --opts = function(_, opts)
  --if LazyVim.has("trouble.nvim") then
  --return vim.tbl_deep_extend("force", opts or {}, {
  --picker = {
  --actions = {
  --trouble_open = function(...)
  --return require("trouble.sources.snacks").actions.trouble_open.action(...)
  --end,
  --},
  --win = {
  --input = {
  --keys = {
  --["<a-t>"] = {
  --"trouble_open",
  --mode = { "n", "i" },
  --},
  --},
  --},
  --},
  --},
  --})
  --end
  --end,
  --},
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "转到定义", has = "definition" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "转到引用" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "转到实现" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "转到类型" },
        --{ "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
        --{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "查找标签" },
      --{ "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" }, --Lance:不经常使用
    },
  },
  --{
  --"folke/snacks.nvim",
  --opts = function(_, opts)
  --table.insert(opts.dashboard.preset.keys, 3, {
  --icon = " ",
  --key = "p",
  --desc = "Projects",
  --action = ":lua Snacks.picker.projects()",
  --})
  --end,
  --},
  {
    "echasnovski/mini.starter",
    optional = true,
    opts = function(_, opts)
      local items = {
        {
          name = "Projects",
          action = [[lua Snacks.picker.projects()]],
          section = string.rep(" ", 22) .. "Telescope",
        },
      }
      vim.list_extend(opts.items, items)
    end,
  },
  --{
  --"nvimdev/dashboard-nvim",
  --optional = true,
  --opts = function(_, opts)
  --if not vim.tbl_get(opts, "config", "center") then
  --return
  --end
  --local projects = {
  --action = "lua Snacks.picker.projects()",
  --desc = " Projects",
  --icon = " ",
  --key = "p",
  --}
  --
  --projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
  --projects.key_format = "  %s"
  --
  --table.insert(opts.config.center, 3, projects)
  --end,
  --},
}
