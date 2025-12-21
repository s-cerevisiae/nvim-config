-- [nfnl] init.fnl
vim.loader.enable()
local function bootstrap(plugin)
  local _let_1_ = vim.split(plugin, "/")
  local _ = _let_1_[1]
  local name = _let_1_[2]
  local plugin_path = (vim.fn.stdpath("data") .. "/lazy/" .. name)
  if not vim.loop.fs_stat(plugin_path) then
    vim.notify(("Installing " .. plugin .. " to " .. plugin_path), vim.log.levels.INFO)
    vim.fn.system({"git", "clone", "--filter=blob:none", "--single-branch", ("https://github.com/" .. plugin), plugin_path})
  else
  end
  return vim.opt.runtimepath:prepend(plugin_path)
end
bootstrap("folke/lazy.nvim")
local function _3_(_241, _242)
  return math.floor((_241 / _242))
end
_G.quotient = _3_
local function prequire(mod)
  local function _4_()
    return require(mod)
  end
  local function _5_(_241)
    print("Failed to require module", mod)
    return print(_241)
  end
  return xpcall(_4_, _5_)
end
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup("plugins")
prequire("config.options")
prequire("config.events")
prequire("config.filetypes")
prequire("config.commands")
prequire("config.diagnostics")
prequire("config.keymaps")
local function _6_()
  return require("environmental")
end
return pcall(_6_)
