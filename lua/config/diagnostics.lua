-- [nfnl] Compiled from fnl/config/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
local signs = {"Error", "Warn", "Info", "Hint"}
vim.diagnostic.config({severity_sort = true})
for _, name in ipairs(signs) do
  local hl = vim.api.nvim_get_hl(0, {name = ("DiagnosticVirtualText" .. name), link = false})
  local hl_name = ("DiagnosticLine" .. name)
  vim.api.nvim_set_hl(0, hl_name, {bg = hl.bg})
  vim.fn.sign_define(("DiagnosticSign" .. name), {linehl = hl_name})
end
return nil
