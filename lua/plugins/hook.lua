-- [nfnl] fnl/plugins/hook.fnl
local _local_1_ = require("utils")
local autocmd = _local_1_.autocmd
local augroup = _local_1_.augroup
local hooks = {install = {}, update = {}, delete = {}}
local function run(_2_)
  local name = _2_.name
  local kind = _2_.kind
  local active = _2_.active
  local path = _2_.path
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
  local function _5_()
    for _, args in ipairs(pending_events) do
      run(args)
    end
    pending_events = nil
    return nil
  end
  autocmd(tmp_9_, "VimEnter", "*", _5_)
  local function _9_(_6_)
    local _arg_7_ = _6_.data
    local _arg_8_ = _arg_7_.spec
    local name = _arg_8_.name
    local kind = _arg_7_.kind
    local active = _arg_7_.active
    local path = _arg_7_.path
    local args = {name = name, kind = kind, active = active, path = path}
    if pending_events then
      table.insert(pending_events, args)
    else
      run(args)
    end
    return nil
  end
  autocmd(tmp_9_, "PackChanged", "*", _9_)
end
local function _11_()
  return hooks
end
_G.PackHook = {run = run, create = create, get = _11_}
return nil
