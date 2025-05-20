-- [nfnl] ftplugin/rust.fnl
local function _1_()
  return vim.cmd.RustLsp({"hover", "actions"})
end
return vim.keymap.set("n", "K", _1_, {buffer = true})
