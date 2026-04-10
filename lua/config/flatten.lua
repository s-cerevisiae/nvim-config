-- [nfnl] fnl/config/flatten.fnl
vim.pack.add({"https://github.com/s-cerevisiae/flatten.nvim"})
local flatten = require("flatten")
local function _1_(argv)
  return (flatten.hooks.should_block(argv) or vim.env.FLATTEN_BLOCK or false)
end
return flatten.setup({window = {open = "tab"}, block_for = {fish = true, jjdescription = true}, hooks = {should_block = _1_}})
