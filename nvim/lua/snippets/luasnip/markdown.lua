tool = require("snippets.luasnip.LuaSnipTool")
addSnip = tool.addSnip
newline = tool.snipNewline


markdown_snip = {
  addSnip(
    "newtag", fmt([[
    <blockquote style="background-color: #f0f0f0; padding: 10px; border-left: 8px solid #007bff;">
      <p style="margin-bottom: 0; color: #3c4858">
      {}
      </p>
    </blockquote>
    ]], 
    {i(1, "<!-- your text -->")})
  ),
  addSnip(
    "tag", fmt([[
    {% note <> %}
    <>
    {% endnote %}
    ]], 
    {c(1, {t("primary"), t("success"), t("danger"), t("warning"), t("info")}), i(2)}, 
    {delimiters = "<>"})
  ),
}


return markdown_snip