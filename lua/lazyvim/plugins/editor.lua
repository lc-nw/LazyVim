return {
  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "搜索替换",
      },
    },
  },

  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  --{
  --"folke/flash.nvim",
  --event = "VeryLazy",
  --vscode = true,
  -----@type Flash.Config
  --opts = {},
  ---- stylua: ignore
  --keys = {
  --{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --},
  --},

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          --{ "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "+ 代码", icon = { icon = " ", color = "green" } },
          { "<leader>d", group = "+ 调试" },
          --{ "<leader>dp", group = "profiler" },
          { "<leader>f", group = "+ 文件", icon = { icon = "󰥨 ", color = "green" } },
          { "<leader>g", group = "+ 仓库", icon = { icon = " ", color = "green" } },
          --{ "<leader>gh", group = "hunks" },
          { "<leader>n", group = "+ 通知", icon = { icon = " ", color = "green" } },
          { "<leader>m", group = "+ 光标", icon = { icon = "󱄧 ", color = "green" } },
          { "<leader>q", group = "+ 会话", icon = { icon = " ", color = "green" } },
          { "<leader>s", group = "+ 搜索", icon = { icon = " ", color = "green" } },
          --{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          --{ "<leader>x", group = "+ 诊断/修复", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "上一个" },
          { "]", group = "下一个" },
          { "g", group = "转到" },
          --{ "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "+ 页框",
            icon = { icon = " ", color = "green" },
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          --{
          --  "<leader>w",
          --  group = "+ 窗口",
          --  proxy = "<c-w>",
          --  expand = function()
          --    return require("which-key.extras").expand.win()
          --  end,
          --},
          -- better descriptions
          --{ "gx", desc = "Open with system app" },
        },
      },
    },
    --Lance: 不经常使用
    --keys = {
    --{
    --"<leader>?",
    --function()
    --require("which-key").show({ global = false })
    --end,
    --desc = "Buffer Keymaps (which-key)",
    --},
    --{
    --"<c-w><space>",
    --function()
    --require("which-key").show({ keys = "<c-w>", loop = true })
    --end,
    --desc = "Window Hydra Mode (which-key)",
    --},
    --},
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.register(opts.defaults)
      end
    end,
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "下一个变更点")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "上一个变更点")
        map("n", "]H", function() gs.nav_hunk("last") end, "末一个变更点")
        map("n", "[H", function() gs.nav_hunk("first") end, "首一个变更点")
        --map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        --map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        --map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        --map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        --map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        --map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        --map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        --map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        --map("n", "<leader>ghd", gs.diffthis, "Diff This")
        --map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        --map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  --{
  --"gitsigns.nvim",
  --opts = function()
  --Snacks.toggle({
  --name = "Git Signs",
  --get = function()
  --return require("gitsigns.config").config.signcolumn
  --end,
  --set = function(state)
  --require("gitsigns").toggle_signs(state)
  --end,
  --}):map("<leader>uG")
  --end,
  --},

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      --Lance: 不使用
      --{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "诊断 (Trouble)" },
      --{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      --{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      --{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      --{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      --{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "上一个修复点",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "下一个修复点",
      },
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "转到下一标签" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "转到上一标签" },
      --{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "列出标签 (Trouble)" },
      --{ "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "查找标签" },
      --{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    vscode = true,
    opts = {},
    keys = {
      {
        "s",
        function()
          require("hop").hint_words()
        end,
        mode = { "n", "v" },
        desc = "Hop hint words",
      },
      {
        "<S-s>",
        function()
          require("hop").hint_lines()
        end,
        mode = { "n", "v" },
        desc = "Hop hint lines",
      },
    },
  },
}
