Appearance_plugins = {
-- *** enable Transparent using => :TransparentEnable ***
-- colorscheme: sonokai
{
  'sainnhe/sonokai',
  priority = 1000,
  -- event = {"BufRead", "BufNewFile"},
  config = function()
    -- vim.g.sonokai_enable_italic = true
    -- vim.g.sonokai_style = 'andromeda'
    vim.g.sonokai_better_performance = 1
    vim.cmd.colorscheme('sonokai')
  end
},


-- search highlight cancle: nvim-cool
{
  "romainl/vim-cool",
  event = "BufRead"
},


-- tabline: barbar
{
  'romgrk/barbar.nvim',
  event = "InsertEnter",
  enabled = false,
  dependencies = {
    'lewis6991/gitsigns.nvim', 
    'nvim-tree/nvim-web-devicons', 
  },
  init = function() 
    vim.g.barbar_auto_setup = false 
  end,
  opts = {
    animation = false,	
  },
  version = '^1.0.0', 
},


-- statusbar: lualine
{
  'nvim-lualine/lualine.nvim',
  event = {"BufRead", "BufNewFile"},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = { 
      theme = 'powerline', 
      component_separators = { left = '', right = ''},
      section_separators   = { left = '', right = ''}
    },
    sections = { lualine_a = {'FugitiveHead'} }
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end
},


-- indent line: indent-blankline.nvim
{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  enabled = false,
  event = "BufRead",
  config = function()
    require("ibl").setup { indent = {char = "▏"} }
  end
},


-- file explorer: NeoTree
{
  "nvim-neo-tree/neo-tree.nvim",
  -- event = "VeryLazy",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", 
    "MunifTanjim/nui.nvim",
  },
  opts = {
    popup_border_style = "rounded",
    enable_git_status = true,
    window = {
      width = 20,
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = false } },
        ["l"] = "focus_preview",
        ["<C-b>"] = { "scroll_preview", config = {direction = 10} },
        ["<C-f>"] = { "scroll_preview", config = {direction = -10} },
      }
    }
  },
	config = function(_, opts)
    require("neo-tree").setup(opts)
	end,
  keys = {
    {'<F1>', "<cmd>Neotree float toggle<CR>", noremap = true, desc = "toggle float tree"},
    {'<F2>', "<cmd>Neotree left toggle<CR>",  noremap = true, desc = "toggle left tree"},
  }
},


-- syntax highlight: nvim-treesitter
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- enabled = false,
  dependencies = { "hiphish/rainbow-delimiters.nvim" },
  event = {"BufRead", "BufNewFile"},
  main = "nvim-treesitter",
  opts = {
    auto_install = false,
    ensure_installed = {
      "c",
      "cpp",
      "css",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "typst",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      -- disable for large files, and latex
      disable = {
        function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        "latex"
      }
    }
  },
  config = function(_, opts)
    require('nvim-treesitter.install').compilers = {"gcc", "clang", "zig"}
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end
},


-- transparent: nvim-transparent
{
  "xiyaowong/nvim-transparent",
  -- lazy = false,
  priority = 1000,
  opts = { 
    extra_groups = {
      -- menu and float
      'Pmenu', 'Float', 'NormalFloat', 
      -- plugin: barbar
      -- 'BufferTabpageFill', 'BufferCurrent', 'BufferInactive', 
      -- 'BufferInactiveSign','BufferCurrentSign',
    }
  },
  config = function(_, opts)
    -- 1. transparent group
    require("transparent").setup(opts)
    -- 2. transparent lualine, lazy or Neotree
    require('transparent').clear_prefix('NeoTree')
  end,
},
}

return Appearance_plugins
