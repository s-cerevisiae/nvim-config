-- [nfnl] init.fnl
vim.loader.enable()
require("vim._core.ui2").enable({enable = true, msg = {targets = "msg", msg = {timeout = 1500}}})
local function _1_(_241, _242)
  return math.floor((_241 / _242))
end
_G.quotient = _1_
local function prequire(mod)
  local function _2_()
    return require(mod)
  end
  local function _3_(_241)
    print("Failed to require module", mod)
    return print(_241)
  end
  return xpcall(_2_, _3_)
end
prequire("config.flatten")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
prequire("plugins")
prequire("config.options")
prequire("config.ui")
prequire("config.file")
prequire("config.editing")
prequire("config.completion")
prequire("config.language")
prequire("config.term")
prequire("config.git")
prequire("config.events")
prequire("config.commands")
prequire("config.diagnostics")
prequire("config.keymaps")
local function _4_()
  return require("environmental")
end
return pcall(_4_)
