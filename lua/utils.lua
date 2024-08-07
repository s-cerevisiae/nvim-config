-- [nfnl] Compiled from fnl/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local function augroup(group, clear)
  return vim.api.nvim_create_augroup(group, {clear = clear})
end
local function autocmd_21(group, event, pattern, cmd)
  local tbl = {pattern = pattern, group = group}
  if ("string" == type(cmd)) then
    tbl["command"] = cmd
  else
    tbl["callback"] = cmd
  end
  return vim.api.nvim_create_autocmd(event, tbl)
end
return {augroup = augroup, ["autocmd!"] = autocmd_21}
