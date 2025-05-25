-- [nfnl] fnl/plugins/term.fnl
local function _1_(term)
  local _2_ = term.direction
  if (_2_ == "horizontal") then
    return quotient(vim.o.lines, 4)
  elseif (_2_ == "vertical") then
    return quotient(vim.o.columns, 2)
  else
    return nil
  end
end
return {{"akinsho/toggleterm.nvim", cmd = "ToggleTerm", opts = {size = _1_, float_opts = {border = "curved"}, persist_mode = false}}, {"s-cerevisiae/flatten.nvim", priority = 1000, opts = true}}
