vim.opt.runtimepath:prepend(vim.fn.getcwd())
local palette = require("static-noise.palette")
local semantic = require("static-noise.semantic")
local colors = semantic.resolve(palette, true)

for _, group in ipairs({ "surface", "content", "outline", "interaction", "status", "syntax", "diff" }) do
  assert(type(colors[group]) == "table", "missing semantic group " .. group)
end
for name, value in pairs(colors.content) do
  if name ~= "primary" and name ~= "secondary" and name ~= "muted" and name ~= "subtle" then
    error("unexpected content role " .. name)
  end
  assert(value == "none" or value:match("^#%x%x%x%x%x%x$"), "invalid semantic color " .. name)
end
assert(colors.surface.root == "none")
print("contract spec passed")
