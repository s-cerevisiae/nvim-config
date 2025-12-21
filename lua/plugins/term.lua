-- [nfnl] fnl/plugins/term.fnl
local function _1_(term)
  local case_2_ = term.direction
  if (case_2_ == "horizontal") then
    return quotient(vim.o.lines, 4)
  elseif (case_2_ == "vertical") then
    return quotient(vim.o.columns, 2)
  else
    return nil
  end
end
local function _4_()
  local flatten = require("flatten")
  local function _5_(argv)
    return (flatten.hooks.should_block(argv) or vim.env.FLATTEN_BLOCK or false)
  end
  return {window = {open = "tab"}, block_for = {fish = true, jjdescription = true}, hooks = {should_block = _5_}}
end
return {{"akinsho/toggleterm.nvim", cmd = "ToggleTerm", opts = {size = _1_, persist_mode = false, start_in_insert = false}}, {"s-cerevisiae/flatten.nvim", priority = 1000, opts = _4_}}
