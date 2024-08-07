-- [nfnl] Compiled from fnl/plugins/colorscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g.bones_compat = 1
  return nil
end
local function _2_()
  return vim.cmd("colorscheme zenupright")
end
return {{"mcchrish/zenbones.nvim", priority = 1000, init = _1_, config = _2_}}
