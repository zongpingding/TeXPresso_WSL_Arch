tool = require("snippets.luasnip.LuaSnipTool")
addSnip = tool.addSnip
merge_snip_tables = tool.merge_snip_tables
mathChecker = tool.mathChecker
get_visual = tool.get_visual


-- >> INTERNAL snip
local function LUASNIP_TWICE(args, parent, user_args)
  node_value = args[1][1]
  a = tonumber(node_value)
  b = 2*a
  return '*2 = '..tostring(b)..'. '
end
local function LUASNIP_CURRENTTIME() 
  local time = os.date("*t") 
  return ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec) 
end
local function LUASNIP_CALCULATE(args, snip)
  expression = 'return '..args[1][1]
  values = load(expression)
  return ' = '..tostring(values())
end
INTERNAL_snip = {
  -- welcome luasnip
  addSnip("LUASNIP-WELCOME", fmt("I am {iNode1}, Hello {iNode2}", {iNode1 = i(1, "LUASNIP"), iNode2 = i(2, "Tom")})),
  addSnip("LUASNIP-LAMBDA", {i(1), extras.dynamic_lambda(2, l._1 .. l._1, 1), i(0)}),
  -- current time
  addSnip("LUASNIP-CURRENTTIME", f(LUASNIP_CURRENTTIME), i(0)),
  -- calculation
  addSnip("LUASNIP-TWICE", {i(1, "1"), f(LUASNIP_TWICE, 1, {user_args={"p-arg1, p-arg2"}}), i(0)}),
  addSnip("LUASNIP-CALCULATE", {t("Calculation: "), i(1, "1+1"), f(LUASNIP_CALCULATE, 1), i(0)} ),
}


-- >> EXPERIMENT SNIP
local table_node= function(args)
	local tabs = {}
	local count
	table = args[1][1]:gsub("%s",""):gsub("|","")
	count = table:len()
	for j=1, count do
		local iNode
		iNode = i(j)
		tabs[2*j-1] = iNode
		if j~=count then
			tabs[2*j] = t" & "
		end
	end
	return sn(nil, tabs)
end
rec_table = function ()
	return sn(nil, {
		c(1, {
			t({""}),
			sn(nil, {t{"\\\\",""} ,d(1,table_node, {ai[1]}), d(2, rec_table, {ai[1]})})
		}),
	});
end
EXPERIMENT_snip = {
  -- >> auto expand
  -- s({filetype = "all", trig = "testalpha", snippetType = "autosnippet", wordTrig = true }, {
  --   t("\\alpha"),
  -- }),

  -- >> Select Raw
  -- addSnip("debug", {f(function(args, parent) return tostring(#parent.env.LS_SELECT_RAW) end, {1}), i(0)}),
  -- For Node 1 doesn't exist, so the function 'get_visual' will b skip; remove '{1}' to fix it.
  addSnip("aaa", fmta("\\textbf{<>}", d(1, get_visual))), 
  s("bbb", f(
    function(args, snip)
      local res, env = {}, snip.env
      table.insert(res, "Length is: " .. #env.LS_SELECT_RAW)
      for i = 1, #env.LS_SELECT_RAW do
        table.insert(res, "Item " .. i .. " is: " .. env.LS_SELECT_RAW[i])
      end
      return res
    end, {})
  ),

  -- >> Dynamic i-node
  -- addSnip("dynamic", {i(1, "abcd"), d(2, dynam_inode, {ai[1]})}),
  s("Dynamic", {
    t"text:( ", i(1), t({"", ")"}),
    d(2, 
      function(args)
        local args_value = args[1][1]
        local args_len = string.len(args_value:gsub("%s",""))
        local TABEL = {}
        for index = 1, 2 do
          table.insert(TABEL, t(""))
          table.insert(TABEL, i(index, "inode "..index))
        end
        return sn(nil, TABEL)
      end,
    {1})
  }),
  -- Trig endless by: 
  -- 1. <Tab>:into choice node
  -- 2. <Alt-C>:insert current line to next line
  s("Table", {
    t"\\begin{tabular}{",
    i(1,"0"),
    t{"}",""},
    d(2, table_node, {1}, {}),
    d(3, rec_table, {1}),
    t{"","\\end{tabular}"}
  }),
}
merge_snip_tables(INTERNAL_snip, EXPERIMENT_snip)


return INTERNAL_snip