EXPERIMENT_PLUGINS = {
-- Mason install the following 'guard.nvim':
-- 1. DAP, LINTER and FORMATTER
-- 2. except for LSP
-- Mason to path: C:\Users\<User Name>\AppData\Local\nvim-data\mason\bin
{
  "williamboman/mason.nvim",
  cmd = "Mason",
  enabled = true,
  config = function()
    require("mason").setup()
  end
},


-- code format and linter: guard.nvim
{
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  enabled = true,
  event = "BufRead",
  opts = {
    fmt_on_save = false,
    lsp_as_default_formatter = false,
  },
  config = function(_, opts)
    local ft = require('guard.filetype')
    ft('c'):fmt('clang-format')
		ft('rust'):fmt('rustfmt')
    ft('lua'):fmt('lsp'):append('stylua')--:lint('selene')
    ft('python'):fmt('ruff')--:lint('ruff')
    ft('tex'):fmt('latexindent')--:lint('vale')
    ft('markdown'):fmt('prettier')
    -- linter messages
    local isLspDiagnosticsVisible = true
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
      signs = false,
      virtual_text = isLspDiagnosticsVisible,
      underline = isLspDiagnosticsVisible
    }) 
    -- setup
    require('guard').setup(opts)
  end,
  keys = {
    -- >> format keymaps
    map("n", "<leader>xff", "<cmd>GuardFmt<CR>", {silent = true, desc = "format code using guard(recommand)"}),
    map("n", "<leader>xfc", "<cmd>%!clang-format<CR>", {silent = true, desc = "format code using clang-format"}),
    map("n", "<leader>xfp", "<cmd>%!black %<CR>", {silent = true, desc = "format code using python-black"}),
  }
},


-- linter: nvim-lint
{
  "mfussenegger/nvim-lint",
  enabled = true,
  event = {"BufRead", "BufNewFile"},
  config = function()
    api.nvim_create_autocmd(
      "BufWritePost", { 
        pattern="*", 
        callback = function() 
          require("lint").try_lint() 
        end 
      }
    )
    require('lint').linters_by_ft = {
      tex = { "chktex", "typos" },
      markdown = { "chktex", "markdownlint", "typos" },
      python = { "ruff" },
      lua = { "selene" }
    }
  end,
  keys = {
    map("n", "<leader>xll", function() require("lint").try_lint() end, {silent = true, desc = "lint code using nvim-lint"}),
    map(
      "n", "<leader>xls", 
      function() vim.diagnostic.config({ signs = true, virtual_text = true, underline = true }) end, 
      {silent = true, desc = "show linter virtual messages"}
    ),
    map(
      "n", "<leader>xlx", 
      function() vim.diagnostic.config({ signs = false, virtual_text = false, underline = false }) end, 
      {silent = true, desc = "close linter virtual messages"}
    )
  }
},
}

return EXPERIMENT_PLUGINS
