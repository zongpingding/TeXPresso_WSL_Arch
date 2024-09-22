-- >> zVIM -- ATTENTION
-- 1. install zig     : scoop install zig
-- 2. install lua     : scoop install lua
-- 3. install luarocks: scoop install luarocks


-- >> set nvim options and keymap
opt = vim.opt
api = vim.api
function map(mode, shortcut, command, options)
  vim.keymap.set(mode, shortcut, command, options)
end


-- >> require config and plugins
require("config.lazy")
require("config.options")