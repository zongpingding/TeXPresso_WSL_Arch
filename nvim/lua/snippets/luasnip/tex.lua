tool = require("snippets.luasnip.LuaSnipTool")
addSnip = tool.addSnip
vstext = LuaSnipTool.get_visual
merge_snip_tables = tool.merge_snip_tables
mathChecker = tool.mathChecker
newline = tool.snipNewline
tool.filetype = "tex"
tex_snip = {}


-- tex snippets map
---@param trig string
---@param pattern string
---@param values table
---@param condition function
local function tex_map(trig, pattern, values, condition)
  return addSnip(
    trig, fmt(pattern, values, {delimiters='<>'}), 
    {condition=condition, show_condition=condition}
  )
end


-- 1. basic tex snippets
tex_basic = {
  -- structures: SPA / SCH / SSE / SSS / SS2 / SPG / SSP
  tex_map("SPA", "\\part{<a>}", {a=d(1,vstext)}),
  tex_map("SCH", "\\chapter{<a>}", {a=d(1,vstext)}),
  tex_map("SSE", "\\section{<a>}", {a=d(1,vstext)}),
  tex_map("SSS", "\\subsection{<a>}", {a=d(1,vstext)}),
  tex_map("SS2", "\\subsubsection{<a>}", {a=d(1,vstext)}),
  tex_map("SPG", "\\paragraph{<a>}", {a=d(1,vstext)}),
  tex_map("SSP", "\\subparagraph{<a>}", {a=d(1,vstext)}),

  -- font commands: FNO / FRM / FEM / FSF / FBF / FIT / FTT / FSC
  tex_map("FEM", "\\emph{<a>}", {a=d(1,vstext)}),
  tex_map("FSF", "\\textsf{<a>}", {a=d(1,vstext)}),
  tex_map("FBF", "\\textbf{<a>}", {a=d(1,vstext)}),
  tex_map("FIT", "\\textit{<a>}", {a=d(1,vstext)}),
  tex_map("FTT", "\\texttt{<a>}", {a=d(1,vstext)}),
  tex_map("FSC", "\\textsc{<a>}", {a=d(1,vstext)}),
  tex_map("FRM", "\\textrm{<a>}", {a=d(1,vstext)}),
  tex_map("FNO", "\\textnormal{<a>}", {a=d(1,vstext)}),

  -- math commands: MRM/ MSF / MBF / MIT / MTT / MCA
  tex_map("MRM", "\\mathrm{<a>}", {a=d(1,vstext)}, mathChecker),
  tex_map("MSF", "\\mathsf{<a>}", {a=d(1,vstext)}, mathChecker),
  tex_map("MBF", "\\mathbf{<a>}", {a=d(1,vstext)}, mathChecker),
  tex_map("MIT", "\\mathit{<a>}", {a=d(1,vstext)}, mathChecker),
  tex_map("MTT", "\\mathcal{<a>}", {a=d(1,vstext)}, mathChecker),

  -- macros alias
  tex_map({"\\\\", "autosnippet"}, "\\\\ ", {}, mathChecker),
  tex_map({"h...", "autosnippet"}, "\\cdots ", {}, mathChecker),
  tex_map({"v...", "autosnippet"}, "\\vdots ", {}, mathChecker),
  tex_map({"__", "autosnippet"},  "_{<a>}", {a=i(1)}, mathChecker),
  tex_map({"^^", "autosnippet"},  "^{<a>}", {a=i(1)}, mathChecker),
  tex_map({"lim", "autosnippet"}, "\\lim_{<a>}", {a=i(1)}, mathChecker),
  tex_map({"/f", "autosnippet"},   "\\frac{<a>}{<b>}", {a=i(1), b=i(2)}, mathChecker),
  tex_map({"sqt", "autosnippet"}, "\\sqrt<a>{<b>}", {a=i(1), b=i(2, "[2]")}, mathChecker),
  tex_map({"/p", "autosnippet"},  "\\frac{\\partial <a>}{\\partial <b>}", {a=i(1), b=i(2)}, mathChecker),
  tex_map({"))", "autosnippet"},  "\\left(<a>\\right)", {a=i(1)}, mathChecker),
  tex_map({"]]", "autosnippet"},  "\\left[<a>\\right]", {a=i(1)}, mathChecker),
  tex_map({"}}", "autosnippet"},  "\\left\\{<a>\\right\\}", {a=i(1)}, mathChecker),
}
merge_snip_tables(tex_snip, tex_basic)


-- 2. geek letters, symbols and latex functions
local table_to_tex_snip = function(snip_tables)
  for i = 1, #snip_tables do
    local current_table = snip_tables[i]
    for j = 1, #current_table do
      local temp_snip_item = tex_map({current_table[j], "autosnippet"}, "\\"..current_table[j].." ", {}, tool.mathChecker)
      table.insert(tex_snip, temp_snip_item)
    end
  end
end
local geek_letters = {
  "alpha", "beta", "chi", "delta", "varepsilon", "varphi", "gamma", 
  "eta", "kappa", "lambda", "mu", "nu", "omega", "pi", "theta", "rho", 
  "sigma", "tau", "upsilon", "zeta", "nabla", "varrho",
  "Alpha", "Beta", "Delta", "Phi", "Gamma", "Lambda", "Omega", "Pi", 
  "Theta", "Sigma", "Upsilon", "Xi", "Psi"
} 
local latex_function = {
  "sin", "cos",  "tan", "cot", "sec", "csc", "arcsin", "arccos",
  "arctan", "sinh", "cosh", "tanh", "coth", "log", "exp", "max", 
  "min", "lg", "ln", "arg", "dim", "deg", "det", "gcd", "hom",
  "ker", "lim", "liminf", "limsup", "mod", "Pr", "sup", "inf",
}
local common_symbols = {
  -- operators
  "infty", "partial", "nabla", "forall", "exists", "neg", "flat",
  "sum", "prod", "coprod", "int", "oint", "iint", "iiint", "iiiint",
  -- set symbols
  "in", "notin", "subset", "subseteq", "supset", "supseteq", "cup",
  "cap", "bigcup", "bigcap", "bigvee", "bigwedge", "bigodot", "bigotimes",
  -- arrows
  "to", "leftarrow", "rightarrow", "leftrightarrow", "Leftarrow", "Rightarrow",
  "Leftrightarrow", "mapsto", "longleftarrow", "longrightarrow", "longleftrightarrow",
  "Longleftarrow", "Longrightarrow", "Longleftrightarrow", "longmapsto",
  -- others symbols
  "bigoplus", "biguplus", "pm", "mp", "times", "div", "cdot", "ast",
  "star", "circ", "bullet", "oplus", "ominus", "otimes", "oslash",
}
table_to_tex_snip({geek_letters, latex_function, common_symbols})


-- 3. tikz snippets
local function tikz()
  return tool.envChecker("tikzpicture")
end
tex_tikz = {
  addSnip("tikz", {t({"\\begin{tikzpicture}", newline}), i(1), t({newline, "\\end{tikzpicture}"})}),
  tex_map("coor", "\\coordinate (<a>) at (<b>);", {a=i(1), b=i(2, "0, 0")}, tikz),
  tex_map("node", "\\node[<a>] at (<b>) {<c>};", {a=i(1), b=i(2), c=i(3)}, tikz),
  tex_map("draw", "\\draw[<a>] (<b>) -- (<c>);", {a=i(1, "->"), b=i(2), c=i(3)}, tikz),
}
merge_snip_tables(tex_snip, tex_tikz)


-- 4. latex 2e programming
tex_program_2e = {
  -- newcommand and environments
  tex_map("newcommand{}{}", "\\newcommand{\\<cmd>}{<def>}", 
    {cmd=i(1, "cmd"), def=i(2, "def")}
  ),
  tex_map("newcommand{}[]{}", "\\newcommand{\\<cmd>}[<arg_num>]{<def>}", 
    {cmd=i(1, "cmd"), arg_num=i(2, "arg_num"), def=i(3, "def")}
  ),
  tex_map("newcommand{}[][]{}", "\\newcommand{\\<cmd>}[<arg_num>][<default>]{<def>}", 
    {cmd=i(1, "cmd"), arg_num=i(2, "arg_num"), default=i(3, "default"), def=i(3, "def")}
  ),
  tex_map("NewDocumentCommand", "\\NewDocumentCommand{\\<cmd>}{<spec>}{<def>}", 
    {cmd=i(1, "cmd"), spec=i(2, "spec"), def=i(3, "def")}
  ),
  tex_map("NewDocumentEnvironment", "\\NewDocumentEnvironment{<envname>}{<xargs>}{<begdef>}{<enddef>}", 
    {envname=i(1, "envname"), xargs=i(2, "xargs"), begdef=i(3, "begdef"), enddef=i(4, "enddef")}
  ),
  -- catcode
  addSnip("makeatletter", {t({"\\makeatletter", newline}), i(1), t({newline, "\\makeatother"})}),
}
merge_snip_tables(tex_snip, tex_program_2e)


-- 5. latex3
tex_program_3 = {
  addSnip("ExplSyntax", {t({"\\ExplSyntaxOn", newline}), i(1), t({newline, "\\ExplSyntaxOff"})}),
}
merge_snip_tables(tex_snip, tex_program_3)


-- Debug section
-- generating function
local mat = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1 
  for j = 1, rows do 
      table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
      ins_indx = ins_indx + 1 
      for k = 2, cols do 
          table.insert(nodes, t(" & "))
          table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1))) 
          ins_indx = ins_indx + 1 
      end 
      table.insert(nodes, t({ " \\\\", "" }))
  end
  -- fix last node.
  nodes[#nodes] = t(" \\\\")
  return sn(nil, nodes)
end

table.insert(
  tex_snip,
  s(
    { trig = "([bBpvV])mat(%d+)x(%d+)([ar])", regTrig = true, name = "matrix", dscr = "matrix trigger lets go", hidden = true },
    fmt([[
    \begin{<>}<>
    <>
    \end{<>}]], 
    {f(function(_, snip)
        return snip.captures[1] .. "matrix" -- captures matrix type
    end),
    f(function(_, snip)
        if snip.captures[4] == "a" then
            out = string.rep("c", tonumber(snip.captures[3]) - 1) -- array for augment 
            return "[" .. out .. "|c]"
        end
        return "" -- otherwise return nothing
    end),
    d(1, mat),
    f(function(_, snip)
        return snip.captures[1] .. "matrix" -- i think i could probably use a repeat node but whatever
    end),},
    { delimiters = "<>" }),
    { condition = math, show_condition = math }
  )
)


return tex_snip