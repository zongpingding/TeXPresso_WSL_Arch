Coding_plugins = {
-- zen mode: zen-mode.nvim
{
  "folke/zen-mode.nvim",
  lazy = true,
  opts = {
    window = {
      backdrop = 0.8,
      width = vim.fn.winwidth(0) - 40,
      height = vim.fn.winheight(0) + 1,
    }
  },
  config = function(_, opts)
    require("zen-mode").setup(opts)
  end,
  keys = {
    { "<leader>zz", "<Cmd>ZenMode<CR>", desc = "toggle zen mode", silent = true, noremap = true },
  }
},


-- auto pairs: nvim-autopairs
{
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = true
},


-- surround: nvim-surround
{
  "kylechui/nvim-surround",
  version = "*",
  event = {"BufRead", "BufNewFile"},
  opts = {},
  config = function(_, opts)
    require("nvim-surround").setup(opts)
  end
},


-- comment: Comment.nvim
{
  'numToStr/Comment.nvim',
  event = {"BufRead", "BufNewFile"},
  opts = {
    toggler  = {line = 'cc', block = 'gc'},
    opleader = {line = 'cc', block = 'gc'},
  },
  config = function(_, opts) 
    require('Comment').setup(opts)
  end
},


-- cursor jumping: hop.nvim
{
  'smoka7/hop.nvim',
  version = "*",
  event = {"BufRead", "BufNewFile"},
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
    term_seq_bias = 0.5
  },
  config = function(_, opts)
    require'hop'.setup(opts)
  end,
  keys = {
    -- in-buffer jumping
    {'<leader>/', "<cmd>HopPattern<CR>",noremap = true, desc = "search"},
    {'<leader>j', "<cmd>HopLineAC<CR>", noremap = true, desc = "jump down"},
    {'<leader>k', "<cmd>HopLineBC<CR>", noremap = true, desc = "jump up"},
    {'<leader>f', "<cmd>HopWordAC<CR>", noremap = true, desc = "word search after cursor"},
    {'<leader>F', "<cmd>HopWordBC<CR>", noremap = true, desc = "word search before cursor"},
    -- in-line jumping
    {'f', "<cmd>HopChar1CurrentLineAC<CR>", noremap = true, desc = "char search after cursor inline"},
    {'F', "<cmd>HopChar1CurrentLineBC<CR>", noremap = true, desc = "char search before cursor inline"},
  }
},


-- source search: telescope
{
  'nvim-telescope/telescope.nvim', 
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {'<leader>o', "<cmd>Telescope find_files<CR>", noremap = true, desc = "find files"},
    {'<leader>g', "<cmd>Telescope live_grep<CR>",  noremap = true, desc = "live grep"},
    {'<leader>h', "<cmd>Telescope oldfiles<CR>",   noremap = true, desc = "recently files"},
  }
},


-- terminal: toggleterm.nvim
{
  'akinsho/toggleterm.nvim', 
  version = "*", 
  event = "VeryLazy",
  config = true,
  opts = {
    direction = 'float',
    shell = "zsh",
    float_opts = { border="curved" }
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
  keys = {
    {'<leader>t', "<cmd>ToggleTerm<CR>", mode = "n", noremap = true, desc = "toggle terminal"},
    {'jj',        "<C-\\><C-n>",         mode = "t", noremap = true, desc = "enter normal mode in terminal"},
    {'<Esc>',     "<C-\\><C-n>:q<CR>",   mode = "t", noremap = true, desc = "exit terminal mode"},
  }
},


-- snippets: LuaSnip
{
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = "VeryLazy",
  -- enabled = false,
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    ls.config.setup({store_selection_keys="ss"})
    -- load snippest
    require("luasnip.loaders.from_vscode").lazy_load({paths = "./lua/snippets/vscode"})
    require("luasnip.loaders.from_lua").lazy_load({paths = "./lua/snippets/luasnip"})
    -- auto expand
    ls.config.setup({ enable_autosnippets = true })
    -- key mappings
    active_choice = function() if ls.choice_active() then ls.change_choice(1) end end
    map({"i"},      "<Enter>", function() ls.expand() end, {silent = true, desc = "expand snippet"})
    map({"i", "s"}, "<Tab>",   function() ls.jump( 1) end, {silent = true, desc = "jump forward"})
    map({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true, desc = "jump backward"})
    map({"i", "s"}, "<A-c>",   function() active_choice() end, {silent = true, desc = "change choice"})
    map({"i", "s"}, "<maplocalleader><Down>", function() ls.change_choice(1) end, {silent = true, desc = "the below choice"})
    map({"i", "s"}, "<maplocalleader><Up>",   function() ls.change_choice(-1) end, {silent = true, desc = "the above choice"})
  end,
},


-- diagnose code 
{
  "folke/trouble.nvim", 
  cmd = "Trouble",
  opts = {},
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  }
},


-- lsp config
{
  "neovim/nvim-lspconfig",
  enabled = true,
  envent = "InsertEnter",
  opts = {
    servers = {
      tinymist = {
        single_file_support = true,
        root_dir = function()
          return vim.fn.getcwd()
        end,
        settings = {}
      }
    }
  },
  config = function()
    -- >> lsp general settings
    -- use ":LspInfo" to see
    require'lspconfig'.texlab.setup{}
    require'lspconfig'.lua_ls.setup{}
    require'lspconfig'.pyright.setup{}
    local lspconfig = require('lspconfig')
    -- clangd config
    lspconfig.clangd.setup({
      name = 'clangd',
      cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
      initialization_options = {
        fallback_flags = { '-std=c++17' },
      },
    })
    -- Haskell
    require('lspconfig')['hls'].setup{
      filetypes = { 'haskell', 'lhaskell', 'cabal' },
    }
    -- json/jsonc
    require'lspconfig'.jsonls.setup{}
    -- typst
    require'lspconfig'.typst_lsp.setup{
      settings = {
        exportPdf = "onType"
      }
    }
    -- rust 
    require'lspconfig'.rust_analyzer.setup({})
  end
},


-- lsp and auto-complete: nvim-cmp
{
  "hrsh7th/nvim-cmp",
  event = {"BufRead", "BufNewFile"},
  dependencies = {
    -- original dependencies
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    -- for luasnip user
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    -- >> Auto-Complete source/Keymaps
    local cmp = require'cmp'
    local luasnip = require("luasnip")
    local kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = " ",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = " ",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "",
      Struct = " ",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }
    local cmd_setup_opts = {
      -- snippet support
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      -- key mappings
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['jk'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {"i", "s"}),
      }),
      -- completion sources
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },{
        { name = 'buffer' },
        { name = "path" },
      }),
      -- menu format
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) 
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]
          return vim_item
        end
      },
    }
    cmp.setup(cmd_setup_opts)
    -- >> CommandLine Auto-completion
    cmp.setup(cmd_setup_opts)
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
  end
},
}
  
return Coding_plugins
