which_key = {
{
  "folke/which-key.nvim",
  event = {"BufRead", "BufNewFile"},
  opts = {
    icons = {
      mappings = false,
    },
    title = false,
    show_help = false, 
    win = {
      border = "none",
      zindex = 1000,
      height = { min = 2, max = 8 },
      padding = { 1, 0, 1, 0 },
      wo = { winblend = 0 },
    }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    }
  },
}
}

return which_key