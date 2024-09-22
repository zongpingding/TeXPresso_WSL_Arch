-- >> basic options
opt.number      = true
opt.wrap        = false
opt.autochdir   = true
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.expandtab   = true
opt.cmdheight   = 0
opt.cursorline  = true
opt.clipboard   = 'unnamedplus'
opt.formatoptions:remove('cro')


-- >> key mappings
-- mode switch 
map('i', 'jj', '<Esc>', {desc = "jj to escape insert mode"})
map('n', 'e',  '$',     {desc = "move to end of line"})
map('n', 'de', 'd$',    {desc = "move to end of line"})
map('i', 'tt', '<Tab>', {silent = true, desc = "tab to expand"})
-- move cursor
map('n', '<A-l>', '<C-w>l',     {desc = "move to right window"})
map('n', '<A-h>', '<C-w>h',     {desc = "move to left window"})
map('n', '<A-k>', '<C-w>k',     {desc = "move to below window"})
map('n', '<A-j>', '<C-w>j',     {desc = "move to upper window"}) 
map('n', '<A-w>', ':wincmd w<cr>', {desc = "cycle through all windows"})
-- windows width/height 
map('n', '<S-l>', '<C-w>>',     {desc = "increase window width"})
map('n', '<S-h>', '<C-w><',     {desc = "decrease window width"})
map('n', '<S-k>', '<C-w>+',     {desc = "increase window height"})
map('n', '<S-j>', '<C-w>-',     {desc = "decrease window height"})
-- move windows
map('n', '<C-l>', '<C-w><S-l>', {desc = "move window to right"})
map('n', '<C-h>', '<C-w><S-h>', {desc = "move window to left"})
-- buffers operations
map('n', '<A-b>',      ':bn<CR>', {desc = "cycle through buffers -> next"})
map('n', '<leader>bf', ':bf<CR>', {desc = "switch to first buffer"})
map('n', '<leader>bd', ':bd<CR>', {desc = "delete current buffer"})
map('n', '<leader>bb', ':buffers<CR>', {desc = "buffer list"})
-- save, exit etc.
map({'i', 'n', 'v'},  '<C-s>', '<Esc>:w<CR>', {desc = "save current file"})
map('n', '<leader>qq', ':bufdo bwipeout<CR>', {desc = "close all buffers"})


-- >> auto commands
local auto_cmds = {
  -- { "InsertEnter",  {pattern="*", callback = function() api.nvim_set_hl(0, 'CursorLine', {underline=true}) end }},
  -- { "InsertLeave",  {pattern="*", callback = function() api.nvim_set_hl(0, 'CursorLine', {underline=false}) end }},
  { "FileType", {pattern={"tex", "lua", "c", "cpp", "ps1", "rust"}, callback = function() opt.wrap = false; vim.opt_local.shiftwidth = 2; vim.opt_local.tabstop = 2 end }},
  { "FileType", {pattern={"markdown", "typst", "txt"}, callback = function() opt.wrap = true end }},
}
for i = 1, #auto_cmds do
  api.nvim_create_autocmd(auto_cmds[i][1], auto_cmds[i][2])
end


-- >> Trouble catch 
-- LSP diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
  }
)
-- linter messages
-- see EXPEIRMENT.lua for guard.nvim
