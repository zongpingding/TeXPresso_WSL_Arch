Doc_plugins = { 
-- LaTeX: vimtex
{
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_general_viewer = 'sumatra'
    vim.g.vimtex_cache_persistent = 0
  end,
  keys = {
    {'<leader>lp', "<cmd>!pdflatex --shell-escape %<CR>", noremap = true, desc = "compile by pdflatex"},
    {'<leader>lx', "<cmd>!xelatex  --shell-escape %<CR>", noremap = true, desc = "compile by xelatex"},
    {'<leader>lm', "<cmd>VimtexTocToggle<CR>",            noremap = true, desc = "toggle document toc"},
  }
},


-- TeXPresso
{
  "let-def/texpresso.vim",
},

-- MarkDown: markdown-preview
{
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = {
    {"<A-1>",  "<Cmd>MarkdownPreviewToggle<CR>", noremap = true, desc = "markdown preview toggle"},
  },
},


-- Typst: typst-preview.nvim
{
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '0.3.*',
  build = function() 
    require 'typst-preview'.update() 
  end,
  keys = {
    {"<A-2>",  "<Cmd>TypstPreviewToggle<CR>", noremap = true, desc = "Typst preview toggle"},
  }
},
}

return Doc_plugins 
