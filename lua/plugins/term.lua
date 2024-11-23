-- [nfnl] Compiled from fnl/plugins/term.fnl by https://github.com/Olical/nfnl, do not edit.
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
return {{"akinsho/toggleterm.nvim", cmd = "ToggleTerm", opts = {size = _1_, float_opts = {border = "curved"}, persist_mode = false}}}
