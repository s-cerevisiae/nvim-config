-- [nfnl] fnl/config/editing.fnl
require("multicursor-nvim").setup()
require("mini.align").setup()
require("mini.comment").setup({options = {ignore_blank_line = true}})
local insx = require("insx")
local esc = insx.helper.regex.esc
local function auto_pair_21(l, r)
  return insx.add(l, insx.with(require("insx.recipe.auto_pair")({open = l, close = r}), {insx.with.undopoint()}))
end
local function fast_break_21(l, r)
  return insx.add("<CR>", require("insx.recipe.fast_break")({open_pat = esc(l), close_pat = esc(r)}))
end
local function soft_delete(option)
  local function _1_(_241)
    return _241.send("<Left>")
  end
  local function _2_(_241)
    return _241.match((option.close_pat .. "\\%#"))
  end
  return {action = _1_, enabled = _2_}
end
local function delete_pair_21(l, r)
  local pats = {open_pat = esc(l), close_pat = esc(r)}
  insx.add("<BS>", require("insx.recipe.delete_pair")(pats))
  return insx.add("<BS>", insx.with(soft_delete(pats), {insx.with.in_string(false)}))
end
for _, _3_ in ipairs({{"(", ")"}, {"[", "]"}, {"{", "}"}}) do
  local l = _3_[1]
  local r = _3_[2]
  auto_pair_21(l, r)
  fast_break_21(l, r)
  delete_pair_21(l, r)
end
return nil
