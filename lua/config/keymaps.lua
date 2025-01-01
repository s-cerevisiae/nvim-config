-- [nfnl] Compiled from fnl/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local function _2_()
  if (0 == vim.v.count) then
    return "gk"
  else
    return "k"
  end
end
vim.keymap.set("n", "k", _2_, {expr = true, silent = true})
local function _4_()
  if (0 == vim.v.count) then
    return "gj"
  else
    return "j"
  end
end
vim.keymap.set("n", "j", _4_, {expr = true, silent = true})
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", {remap = true})
vim.keymap.set({"n", "v"}, "<leader>Y", "\"+Y", {remap = true})
vim.keymap.set({"n", "v"}, "<leader>p", "\"+p", {remap = true})
vim.keymap.set({"n", "v"}, "<leader>P", "\"+P", {remap = true})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
local function _6_()
  return vim.snippet.jump(1)
end
vim.keymap.set({"i", "s"}, "<c-l>", _6_, {expr = true, silent = true})
local function _7_()
  return vim.snippet.jump(-1)
end
vim.keymap.set({"i", "s"}, "<c-h>", _7_, {expr = true, silent = true})
local function _8_()
  return require("flash").remote()
end
vim.keymap.set({"o"}, "r", _8_)
local function fzf(cmd)
  local small = (vim.o.lines < 30)
  local _9_
  if small then
    _9_ = "hidden"
  else
    _9_ = "nohidden"
  end
  return require("fzf-lua")[cmd]({fzf_colors = true, winopts = {fullscreen = small, preview = {wrap = "wrap", hidden = _9_}}})
end
local wk = require("which-key")
local file
local function _11_()
  return fzf("files")
end
file = {name = "file", f = {_11_, "Find file"}, t = {"<cmd>Neotree toggle reveal=true position=current<cr>", "Toggle NeoTree"}, b = {"<cmd>Oil<cr>", "Oil.nvim file browser"}}
local _goto = {name = "goto", i = {vim.lsp.buf.implementation, "Go to implementation"}, d = {vim.lsp.buf.definition, "Go to definition"}, D = {vim.lsp.buf.declaration, "Go to declaration"}, t = {vim.lsp.buf.type_definition, "Go to type definition"}, r = {vim.lsp.buf.references, "Go to references"}}
local lang
local function _12_()
  return fzf("lsp_code_actions")
end
local function _13_()
  return fzf("diagnostics_workspace")
end
local function _14_()
  return require("conform").format({lsp_fallback = true, stop_after_first = true, async = true})
end
local function _15_()
  return vim.lsp.buf.document_highlight()
end
local function _16_()
  return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
lang = {name = "lang", a = {_12_, "Code actions"}, d = {_13_, "Show diagnostics"}, f = {_14_, "Format buffer"}, h = {_15_, "Document highlight"}, r = {vim.lsp.buf.rename, "Rename symbol"}, i = {_16_, "Toggle inlay hint"}, g = _goto}
local term = {name = "term", l = {"<cmd>ToggleTerm direction=vertical<cr>", "Toggle \226\134\146 terminal"}, j = {"<cmd>ToggleTerm direction=horizontal<cr>", "Toggle \226\134\147 terminal"}, t = {"<cmd>ToggleTerm direction=float<cr>", "Toggle floating terminal"}, s = {"<cmd>TermSelect<cr>", "Select term"}}
local repl
do
  local iron = autoload("iron.core")
  local toggle_repl = "<cmd>IronRepl<cr>"
  local send_visual
  local function _17_()
    iron.mark_visual()
    return iron.send_mark()
  end
  send_visual = _17_
  local function _18_()
    return iron.run_motion("send_motion")
  end
  local function _19_()
    return iron.send_line()
  end
  local function _20_()
    return iron.send_file()
  end
  local function _21_()
    return iron.send_mark()
  end
  repl = {name = "repl", r = {toggle_repl, "Toggle REPL"}, v = {send_visual, "Send visual selection"}, s = {_18_, "Send motion"}, l = {_19_, "Send current line"}, f = {_20_, "Send the whole file"}, m = {_21_, "Send marked"}}
end
local toggle_diags
local function _22_()
  local _let_23_ = vim.diagnostic.config()
  local virtual_text = _let_23_["virtual_text"]
  local virtual_lines = _let_23_["virtual_lines"]
  return vim.diagnostic.config({virtual_text = not virtual_text, virtual_lines = not virtual_lines})
end
toggle_diags = _22_
local function _24_()
  return fzf("commands")
end
local function _25_()
  return fzf("buffers")
end
return wk.register({["<leader>"] = {_24_, "Find command"}, b = {_25_, "buffers"}, d = {toggle_diags, "Toggle linewise diagnostics"}, f = file, l = lang, g = {"<cmd>Neogit<cr>", "Neogit"}, t = term, r = repl, w = {"<c-w>", "Window commands", noremap = false}}, {mode = {"n", "v"}, prefix = "<leader>"})
