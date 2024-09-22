copilot = {
{
  "github/copilot.vim",
  enabled = true,
  event = {"BufRead", "BufNewFile"},
  keys = {
    {"<leader>cd", "<cmd>Copilot disable<CR>", silent = true, desc = "Disable Copilot"},
    {"<leader>ce", "<cmd>Copilot enable<CR>", silent = true, desc = "Enable Copilot"},
  },
  config = function()
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
  end
},
}

return copilot
