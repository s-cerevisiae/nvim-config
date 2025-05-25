-- [nfnl] fnl/plugins/colorscheme.fnl
local function _1_()
  vim.g.bones_compat = 1
  return nil
end
local function _2_()
  return vim.cmd("colorscheme zenupright")
end
return {{"mcchrish/zenbones.nvim", priority = 100, init = _1_, config = _2_}}
