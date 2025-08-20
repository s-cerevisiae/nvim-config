-- [nfnl] fnl/config/keymaps.fnl
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
local function fzf(cmd, opts)
  return require("fzf-lua")[cmd](opts)
end
local function map(key, val, desc, opts)
  local opts0 = (opts or {})
  local mode = (opts0.mode or "n")
  opts0.mode = nil
  opts0.desc = desc
  return vim.keymap.set(mode, key, val, opts0)
end
local function map_group(prefix, desc, ...)
  local group = {...}
  map(prefix, "", desc)
  for _, m in ipairs(group) do
    m[1] = (prefix .. m[1])
    map(unpack(m))
  end
  return nil
end
local function _9_()
  return fzf("files")
end
map_group("<leader>f", "file", {"f", _9_, "File Finder"}, {"b", "<cmd>Oil<cr>", "File Browser"}, {"t", "<cmd>Fyler<cr>", "File Tree"})
local function _10_()
  return fzf("lsp_code_actions")
end
local function _11_()
  return fzf("diagnostics_document", {sort = true})
end
local function _12_()
  return fzf("diagnostics_workspace", {sort = true})
end
local function _13_()
  return require("conform").format({lsp_fallback = true, stop_after_first = true, async = true})
end
local function _14_()
  return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
map_group("<leader>l", "lang", {"a", _10_, "Code Actions", {mode = {"n", "v"}}}, {"d", _11_, "Local Diagnostics"}, {"D", _12_, "Workspace Diagnostics"}, {"f", _13_, "Format buffer", {mode = {"n", "v"}}}, {"h", vim.lsp.buf.document_highlight, "Document Highlight"}, {"r", vim.lsp.buf.rename, "Rename Symbol"}, {"i", _14_, "Toggle inlay hint"})
map_group("<leader>lg", "goto", {"i", vim.lsp.buf.implementation, "Go to Implementation"}, {"d", vim.lsp.buf.definition, "Go to Definition"}, {"D", vim.lsp.buf.declaration, "Go to Declaration"}, {"t", vim.lsp.buf.type_definition, "Go to Type Definition"}, {"r", vim.lsp.buf.references, "Go to References"})
map_group("<leader>t", "term", {"t", "<cmd>ToggleTerm direction=float<cr>", "Toggle Floating Terminal"}, {"l", "<cmd>ToggleTerm direction=vertical<cr>", "Toggle \226\134\146 Terminal"}, {"j", "<cmd>ToggleTerm direction=horizontal<cr>", "Toggle \226\134\147 Terminal"}, {"s", "<cmd>TermSelect<cr>", "Select Terminal"})
do
  local iron = autoload("iron.core")
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
  map_group("<leader>r", "repl", {"r", send_visual, "Send visual selection", {mode = "v"}}, {"r", _16_, "Send motion", {mode = "n"}}, {"t", "<cmd>IronRepl<cr>", "Toggle REPL"}, {"l", _17_, "Send current line"}, {"f", _18_, "Send the whole file"}, {"m", _19_, "Send marked"})
end
do
  local dap = autoload("dap")
  local function _20_()
    return dap.continue()
  end
  local function _21_()
    return dap.toggle_breakpoint()
  end
  local function _22_()
    return dap.step_over()
  end
  local function _23_()
    return dap.step_into()
  end
  local function _24_()
    return dap.step_out()
  end
  local function _25_()
    return dap.step_back()
  end
  local function _26_()
    return dap.terminate()
  end
  map_group("<leader>d", "debugging", {"d", _20_, "Run / Continue"}, {"b", _21_, "Toggle Breakpoint"}, {"j", _22_, "Step Over"}, {"h", _23_, "Step Into"}, {"l", _24_, "Step Out"}, {"k", _25_, "Step Back"}, {"q", _26_, "Quit Session"}, {"w", "<cmd>DapViewWatch<cr>", "Watch Variable"}, {"v", "<cmd>DapViewToggle<cr>", "Toggle Debug View"})
end
local toggle_diags
local function _27_()
  local _let_28_ = vim.diagnostic.config()
  local virtual_text = _let_28_["virtual_text"]
  local virtual_lines = _let_28_["virtual_lines"]
  return vim.diagnostic.config({virtual_text = not virtual_text, virtual_lines = not virtual_lines})
end
toggle_diags = _27_
local mc = require("multicursor-nvim")
local function _29_()
  return fzf("commands")
end
local function _30_()
  return fzf("buffers")
end
local function _31_()
  return require("which-key").show({keys = "<c-w>", loop = true})
end
map_group("<leader>", "leader", {"<leader>", _29_, "Command Palette"}, {"b", _30_, "Buffers"}, {"D", toggle_diags, "Toggle Diagnostics Style"}, {"g", "<cmd>Neogit<cr>", "Neogit"}, {"w", "<c-w>", "window", {remap = true}}, {"W", _31_, "window persist"}, {"c", mc.toggleCursor, "Multiple Cursors"}, {"c/", mc.matchCursors, "Match Cursors", {mode = "v"}})
local function _32_(layer)
  local function _33_()
    if not mc.cursorsEnabled() then
      return mc.enableCursors()
    else
      return mc.clearCursors()
    end
  end
  return layer("n", "<esc>", _33_)
end
return mc.addKeymapLayer(_32_)
