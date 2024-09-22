-- local short hands
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")


-- return table
LuaSnipTool = {}
LuaSnipTool.snipNewline = ""
LuaSnipTool.filetype = "all"


-- merge snippets table
---@param target_table table
---@param snip_table table
LuaSnipTool.merge_snip_tables = function(target_table, snip_table)
  for i = 1, #snip_table do
    table.insert(target_table, snip_table[i])
  end
end


-- add snippet function
---@param trigger string
---@param snippet table
LuaSnipTool.addSnip = function(trig, snippet, condition)
  if type(trig) == "string" then
    trig = {trig, "snippet"}
  end
  return s({filetype = LuaSnipTool.filetype, trig = trig[1], snippetType=trig[2]}, snippet, condition)
end


-- get visual / select text
LuaSnipTool.get_visual = function(args, parent)
  if #parent.env.LS_SELECT_RAW > 0 then
    return sn(nil, t(parent.env.LS_SELECT_RAW))
  else 
    return sn(nil, i(1))
  end
end



-- environment checker
---@param name string
LuaSnipTool.envChecker = function(name) 
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- math env checker
LuaSnipTool.mathChecker = function()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end 


return LuaSnipTool