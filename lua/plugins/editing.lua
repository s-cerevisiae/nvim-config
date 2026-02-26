-- [nfnl] fnl/plugins/editing.fnl
local function _1_()
  vim.g.nvim_surround_no_mappings = true
  return nil
end
local function _2_()
  local insx = require("insx")
  local esc = insx.helper.regex.esc
  local function auto_pair_21(l, r)
    return insx.add(l, insx.with(require("insx.recipe.auto_pair")({open = l, close = r}), {insx.with.undopoint()}))
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
    return insx.add("<BS>", insx.with(soft_delete(pats), {insx.with.in_string(false)}))
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
return {{"folke/flash.nvim", opts = {modes = {search = {enabled = true}, char = {enabled = false}}, prompt = {enabled = true, prefix = {{"r/", "FlashPromptIcon"}}}}}, {"kylechui/nvim-surround", init = _1_}, {"jake-stewart/multicursor.nvim", config = true}, {"nvim-mini/mini.align", config = true}, {"numToStr/Comment.nvim", opts = {ignore = "^$"}}, {"hrsh7th/nvim-insx", config = _2_}, {"s-cerevisiae/parinfer-rust", build = "cargo build --release"}, "tpope/vim-repeat"}
