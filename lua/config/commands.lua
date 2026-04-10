-- [nfnl] fnl/config/commands.fnl
local function _1_()
  return vim.pack.update()
end
vim.api.nvim_create_user_command("PackUpdate", _1_, {nargs = 0})
local function _2_()
  return vim.pack.update(nil, {target = "lockfile"})
end
vim.api.nvim_create_user_command("PackSync", _2_, {nargs = 0})
local function _3_()
  return vim.pack.update(nil, {target = "lockfile", offline = true})
end
vim.api.nvim_create_user_command("PackRevert", _3_, {nargs = 0})
local function _6_(_4_)
  local _arg_5_ = _4_.fargs
  local kind = _arg_5_[1]
  local name = _arg_5_[2]
  if not PackHook.run(name, kind) then
    return vim.notify(("No " .. kind .. " hook available for plugin " .. name))
  else
    return nil
  end
end
local function _8_(_, cmdline, _0)
  local hooks = PackHook.get()
  local case_9_ = vim.split(cmdline, " ", {trimempty = true})
  if ((_G.type(case_9_) == "table") and (nil ~= case_9_[1]) and (nil ~= case_9_[2])) then
    local cmd = case_9_[1]
    local kind = case_9_[2]
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
  elseif ((_G.type(case_9_) == "table") and (nil ~= case_9_[1])) then
    local cmd = case_9_[1]
    return vim.tbl_keys(hooks)
  else
    local _1 = case_9_
    return {}
  end
end
vim.api.nvim_create_user_command("PackRunHook", _6_, {nargs = "+", complete = _8_})
local function _13_()
  local function _14_()
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
  return vim.pack.del(_14_())
end
return vim.api.nvim_create_user_command("PackClean", _13_, {nargs = 0})
