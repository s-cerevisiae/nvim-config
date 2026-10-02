-- [nfnl] fnl/config/commands.fnl
local function _2_(_1_)
  local names = _1_.fargs
  if vim.tbl_isempty(names) then
    return vim.pack.update()
  else
    return vim.pack.update(names)
  end
end
local function _4_()
  local tbl_26_ = {}
  local i_27_ = 0
  for _, p in ipairs(vim.pack.get(nil, {info = false})) do
    local val_28_ = p.spec.name
    if (nil ~= val_28_) then
      i_27_ = (i_27_ + 1)
      tbl_26_[i_27_] = val_28_
    else
    end
  end
  return tbl_26_
end
vim.api.nvim_create_user_command("PackUpdate", _2_, {nargs = "*", complete = _4_})
local function _6_()
  return vim.pack.update(nil, {target = "lockfile"})
end
vim.api.nvim_create_user_command("PackSync", _6_, {nargs = 0})
local function _7_()
  return vim.pack.update(nil, {target = "lockfile", offline = true})
end
vim.api.nvim_create_user_command("PackRevert", _7_, {nargs = 0})
local function _10_(_8_)
  local _arg_9_ = _8_.fargs
  local kind = _arg_9_[1]
  local name = _arg_9_[2]
  local _let_11_ = vim.pack.get({name}, {info = false})
  local _let_12_ = _let_11_[1]
  local active = _let_12_.active
  local path = _let_12_.path
  if not PackHook.run({name = name, kind = kind, active = active, path = path}) then
    return vim.notify(("No " .. kind .. " hook available for plugin " .. name))
  else
    return nil
  end
end
local function _14_(_, cmdline, _0)
  local hooks = PackHook.get()
  local case_15_ = vim.split(cmdline, " ", {trimempty = true})
  if ((_G.type(case_15_) == "table") and (nil ~= case_15_[1]) and (nil ~= case_15_[2])) then
    local cmd = case_15_[1]
    local kind = case_15_[2]
    if (nil ~= hooks) then
      local tmp_3_ = hooks[kind]
      if (nil ~= tmp_3_) then
        return vim.tbl_keys(tmp_3_)
      else
        return nil
      end
    else
      return nil
    end
  elseif ((_G.type(case_15_) == "table") and (nil ~= case_15_[1])) then
    local cmd = case_15_[1]
    return vim.tbl_keys(hooks)
  else
    local _1 = case_15_
    return {}
  end
end
vim.api.nvim_create_user_command("PackRunHook", _10_, {nargs = "+", complete = _14_})
local function _19_()
  local function _20_()
    local tbl_26_ = {}
    local i_27_ = 0
    for _, p in ipairs(vim.pack.get(nil, {info = false})) do
      local val_28_
      if not p.active then
        val_28_ = p.spec.name
      else
        val_28_ = nil
      end
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    return tbl_26_
  end
  return vim.pack.del(_20_())
end
return vim.api.nvim_create_user_command("PackClean", _19_, {nargs = 0})
