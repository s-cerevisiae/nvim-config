-- [nfnl] fnl/plugins/hook.fnl
local _local_1_ = require("utils")
local autocmd = _local_1_.autocmd
local augroup = _local_1_.augroup
local hooks = {install = {}, update = {}, delete = {}}
local function run(name, kind)
  local _let_2_ = vim.pack.get({name}, {info = false})
  local _let_3_ = _let_2_[1]
  local active = _let_3_.active
  local path = _let_3_.path
  local maybe_hook = hooks[kind][name]
  if maybe_hook then
    if not active then
      vim.cmd.packadd(name)
    else
    end
    vim.notify(("Running " .. kind .. " hook for package " .. name), vim.log.levels.INFO)
    maybe_hook(path)
    return true
  else
    return false
  end
end
local function create(kinds, name, hook)
  for _, kind in ipairs(kinds) do
    hooks[kind][name] = hook
  end
  return nil
end
local pending_events = {}
do
  local tmp_9_ = augroup("PackHook")
  local function _6_()
    for _, _7_ in ipairs(pending_events) do
      local name = _7_.name
      local kind = _7_.kind
      run(name, kind)
    end
    pending_events = nil
    return nil
  end
  autocmd(tmp_9_, "VimEnter", "*", _6_)
  local function _11_(_8_)
    local _arg_9_ = _8_.data
    local _arg_10_ = _arg_9_.spec
    local name = _arg_10_.name
    local kind = _arg_9_.kind
    if pending_events then
      table.insert(pending_events, {name = name, kind = kind})
    else
      run(name, kind)
    end
    return nil
  end
  autocmd(tmp_9_, "PackChanged", "*", _11_)
end
local function _13_()
  return hooks
end
_G.PackHook = {run = run, create = create, get = _13_}
return nil
