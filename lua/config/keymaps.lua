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
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", {remap = true, desc = "y to clip"})
vim.keymap.set({"n", "v"}, "<leader>Y", "\"+Y", {remap = true, desc = "Y to clip"})
vim.keymap.set({"n", "v"}, "<leader>p", "\"+p", {remap = true, desc = "p from clip"})
vim.keymap.set({"n", "v"}, "<leader>P", "\"+P", {remap = true, desc = "P from clip"})
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
  return require("fzf-lua")[cmd]()
end
local wk = require("which-key")
local file
local function _9_()
  return fzf("files")
end
file = {{"<leader>f", group = "file"}, {"<leader>ff", _9_, desc = "File Finder"}, {"<leader>fb", "<cmd>Oil<cr>", desc = "File Browser"}, {"<leader>ft", "<cmd>Neotree toggle reveal=true position=current<cr>", desc = "File Tree"}}
local lang
local function _10_()
  return fzf("lsp_code_actions")
end
local function _11_()
  return fzf("diagnostics_document")
end
local function _12_()
  return fzf("diagnostics_workspace")
end
local function _13_()
  return require("conform").format({lsp_fallback = true, stop_after_first = true, async = true})
end
local function _14_()
  return vim.lsp.buf.document_highlight()
end
local function _15_()
  return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
lang = {{"<leader>l", group = "lang"}, {"<leader>la", _10_, desc = "Code actions", mode = {"n", "v"}}, {"<leader>ld", _11_, desc = "Current file diagnostics"}, {"<leader>lD", _12_, desc = "Workspace diagnostics"}, {"<leader>lf", _13_, desc = "Format buffer", mode = {"n", "v"}}, {"<leader>lh", _14_, desc = "Document highlight"}, {"<leader>lr", vim.lsp.buf.rename, desc = "Rename symbol"}, {"<leader>li", _15_, desc = "Toggle inlay hint"}}
local _goto = {{"<leader>lg", group = "goto"}, {"<leader>lgi", vim.lsp.buf.implementation, desc = "Go to implementation"}, {"<leader>lgd", vim.lsp.buf.definition, desc = "Go to definition"}, {"<leader>lgD", vim.lsp.buf.declaration, desc = "Go to declaration"}, {"<leader>lgt", vim.lsp.buf.type_definition, desc = "Go to type definition"}, {"<leader>lgr", vim.lsp.buf.references, desc = "Go to references"}}
local term = {{"<leader>t", desc = "term"}, {"<leader>tl", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle \226\134\146 terminal"}, {"<leader>tj", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle \226\134\147 terminal"}, {"<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal"}, {"<leader>ts", "<cmd>TermSelect<cr>", desc = "Select term"}}
local repl
do
  local iron = autoload("iron.core")
  local toggle_repl = "<cmd>IronRepl<cr>"
  local send_visual
  local function _16_()
    iron.mark_visual()
    return iron.send_mark()
  end
  send_visual = _16_
  local function _17_()
    return iron.run_motion("send_motion")
  end
  local function _18_()
    return iron.send_line()
  end
  local function _19_()
    return iron.send_file()
  end
  local function _20_()
    return iron.send_mark()
  end
  repl = {{"<leader>r", desc = "repl"}, {"<leader>rr", send_visual, desc = "Send visual selection", mode = "v"}, {"<leader>rr", _17_, desc = "Send motion", mode = "n"}, {"<leader>rt", toggle_repl, desc = "Toggle REPL"}, {"<leader>rl", _18_, desc = "Send current line"}, {"<leader>rf", _19_, desc = "Send the whole file"}, {"<leader>rm", _20_, desc = "Send marked"}}
end
local toggle_diags
local function _21_()
  local _let_22_ = vim.diagnostic.config()
  local virtual_text = _let_22_["virtual_text"]
  local virtual_lines = _let_22_["virtual_lines"]
  return vim.diagnostic.config({virtual_text = not virtual_text, virtual_lines = not virtual_lines})
end
toggle_diags = _21_
local function _23_()
  return fzf("commands")
end
local function _24_()
  return fzf("buffers")
end
local function _25_()
  return wk.show({keys = "<c-w>", loop = true})
end
return wk.add({{file, lang, _goto, term, repl}, {"<leader><leader>", _23_, desc = "Command Palette"}, {"<leader>b", _24_, desc = "buffers"}, {"<leader>d", toggle_diags, desc = "Draw Diagnostics"}, {"<leader>g", "<cmd>Neogit<cr>", desc = "Neogit"}, {"<leader>w", _25_, desc = "window"}})
