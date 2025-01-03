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
local wk = require("which-key")
local _let_9_ = require("telescope.builtin")
local find_files = _let_9_["find_files"]
local diagnostics = _let_9_["diagnostics"]
local commands = _let_9_["commands"]
local file
local function _10_()
  return find_files({hidden = true})
end
file = {name = "file", f = {find_files, "Find file"}, h = {_10_, "Find hidden file"}, t = {"<cmd>Neotree toggle reveal=true position=current<cr>", "Toggle NeoTree"}, b = {"<cmd>Oil<cr>", "Oil.nvim file browser"}}
local _goto = {name = "goto", i = {vim.lsp.buf.implementation, "Go to implementation"}, d = {vim.lsp.buf.definition, "Go to definition"}, D = {vim.lsp.buf.declaration, "Go to declaration"}, t = {vim.lsp.buf.type_definition, "Go to type definition"}, r = {vim.lsp.buf.references, "Go to references"}}
local lang
local function _11_()
  return diagnostics({bufnr = 0})
end
local function _12_()
  return require("conform").format({lsp_fallback = true, stop_after_first = true, async = true})
end
local function _13_()
  return vim.lsp.buf.document_highlight()
end
local function _14_()
  return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
lang = {name = "lang", a = {vim.lsp.buf.code_action, "Code actions"}, d = {_11_, "Show diagnostics"}, f = {_12_, "Format buffer"}, h = {_13_, "Document highlight"}, r = {vim.lsp.buf.rename, "Rename symbol"}, i = {_14_, "Toggle inlay hint"}, g = _goto}
local term = {name = "term", l = {"<cmd>ToggleTerm direction=vertical<cr>", "Toggle \226\134\146 terminal"}, j = {"<cmd>ToggleTerm direction=horizontal<cr>", "Toggle \226\134\147 terminal"}, t = {"<cmd>ToggleTerm direction=float<cr>", "Toggle floating terminal"}, s = {"<cmd>TermSelect<cr>", "Select term"}}
local repl
do
  local iron = autoload("iron.core")
  local toggle_repl = "<cmd>IronRepl<cr>"
  local send_visual
  local function _15_()
    iron.mark_visual()
    return iron.send_mark()
  end
  send_visual = _15_
  local function _16_()
    return iron.run_motion("send_motion")
  end
  local function _17_()
    return iron.send_line()
  end
  local function _18_()
    return iron.send_file()
  end
  local function _19_()
    return iron.send_mark()
  end
  repl = {name = "repl", r = {toggle_repl, "Toggle REPL"}, v = {send_visual, "Send visual selection"}, s = {_16_, "Send motion"}, l = {_17_, "Send current line"}, f = {_18_, "Send the whole file"}, m = {_19_, "Send marked"}}
end
local toggle_diags
local function _20_()
  local _let_21_ = vim.diagnostic.config()
  local virtual_text = _let_21_["virtual_text"]
  local virtual_lines = _let_21_["virtual_lines"]
  return vim.diagnostic.config({virtual_text = not virtual_text, virtual_lines = not virtual_lines})
end
toggle_diags = _20_
return wk.register({["<leader>"] = {commands, "Find command"}, b = {"<cmd>Telescope buffers<cr>", "buffers"}, d = {toggle_diags, "Toggle linewise diagnostics"}, f = file, l = lang, g = {"<cmd>Neogit<cr>", "Neogit"}, t = term, r = repl, w = {"<c-w>", "Window commands", noremap = false}}, {mode = {"n", "v"}, prefix = "<leader>"})
