-- [nfnl] Compiled from ftplugin/rust.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.cmd.RustLsp({"hover", "actions"})
end
return vim.keymap.set("n", "K", _1_, {buffer = true})
