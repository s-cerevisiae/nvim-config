-- [nfnl] fnl/config/diagnostics.fnl
local function gen_sign(f)
  local sign_names = {"Error", "Warn", "Info", "Hint"}
  local tbl_16_ = {}
  for _, name in ipairs(sign_names) do
    local k_17_, v_18_ = vim.diagnostic.severity[string.upper(name)], f(name)
    if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
      tbl_16_[k_17_] = v_18_
    else
    end
  end
  return tbl_16_
end
local function define_linehl(severity)
  local _let_2_ = vim.api.nvim_get_hl(0, {name = ("DiagnosticVirtualText" .. severity), link = false})
  local bg = _let_2_["bg"]
  local hl_name = ("DiagnosticLine" .. severity)
  vim.api.nvim_set_hl(0, hl_name, {bg = bg})
  return hl_name
end
local signs
do
  local linehl = gen_sign(define_linehl)
  local cancel
  local function _3_()
    return ""
  end
  cancel = gen_sign(_3_)
  signs = {text = cancel, numhl = cancel, linehl = linehl}
end
return vim.diagnostic.config({severity_sort = true, virtual_text = true, signs = signs})
