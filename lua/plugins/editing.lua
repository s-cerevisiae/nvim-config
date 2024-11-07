-- [nfnl] Compiled from fnl/plugins/editing.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local leap = require("leap")
  return leap.add_default_mappings()
end
local function _2_()
  local insx = require("insx")
  local esc = insx.helper.regex.esc
  local function auto_pair_21(l, r)
    return insx.add(l, insx.with(require("insx.recipe.auto_pair")({open = l, close = r}), {insx.with.in_string(false), insx.with.undopoint()}))
  end
  local function fast_break_21(l, r)
    return insx.add("<CR>", require("insx.recipe.fast_break")({open_pat = esc(l), close_pat = esc(r)}))
  end
  local function soft_delete(option)
    local function _3_(_2410)
      return _2410.send("<Left>")
    end
    local function _4_(_2410)
      return _2410.match((option.close_pat .. "\\%#"))
    end
    return {action = _3_, enabled = _4_}
  end
  local function delete_pair_21(l, r)
    local pats = {open_pat = esc(l), close_pat = esc(r)}
    insx.add("<BS>", require("insx.recipe.delete_pair")(pats))
    return insx.add("<BS>", soft_delete(pats))
  end
  for _, _5_ in ipairs({{"(", ")"}, {"[", "]"}, {"{", "}"}}) do
    local l = _5_[1]
    local r = _5_[2]
    auto_pair_21(l, r)
    fast_break_21(l, r)
    delete_pair_21(l, r)
  end
  return nil
end
return {{"ggandor/leap.nvim", config = _1_}, {"kylechui/nvim-surround", opts = {keymaps = {normal = " s", normal_cur = " ss", normal_line = " S", normal_cur_line = " SS", visual = " s", visual_line = " S", delete = "d s", change = "c s"}}}, {"numToStr/Comment.nvim", opts = {ignore = "^$"}}, {"hrsh7th/nvim-insx", config = _2_}, "eraserhd/parinfer-rust", "tpope/vim-repeat"}
