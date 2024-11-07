-- [nfnl] Compiled from fnl/plugins/keymapper.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return require("which-key").setup({icons = {separator = "\226\134\146"}})
end
return {{"folke/which-key.nvim", tag = "v2.1.0", config = _1_}}
