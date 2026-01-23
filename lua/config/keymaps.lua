-- [nfnl] fnl/config/keymaps.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
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
do
  local select = autoload("nvim-treesitter-textobjects.select")
  local mode = {"x", "o"}
  local function map_ts(key, sel)
    local function _9_()
      return select.select_textobject(sel, "textobjects")
    end
    return vim.keymap.set(mode, key, _9_, {desc = sel})
  end
  map_ts("af", "@function.outer")
  map_ts("if", "@function.inner")
  map_ts("ac", "@conditional.outer")
  map_ts("ic", "@conditional.inner")
  map_ts("aa", "@parameter.outer")
  map_ts("ia", "@parameter.inner")
end
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
local function map_group(prefix, ...)
  local group = {...}
  for _, m in ipairs(group) do
    m[1] = (prefix .. m[1])
    map(unpack(m))
  end
  return nil
end
local function _10_()
  return fzf("files")
end
map_group("<leader>f", {"f", _10_, "File Finder"}, {"b", "<cmd>Oil<cr>", "File Browser"}, {"t", "<cmd>Neotree toggle reveal=true position=current<cr>", "File Tree"})
local function _11_()
  return fzf("lsp_code_actions")
end
local function _12_()
  return fzf("diagnostics_document", {sort = true})
end
local function _13_()
  return fzf("diagnostics_workspace", {sort = true})
end
local function _14_()
  return require("conform").format({lsp_fallback = true, stop_after_first = true, async = true})
end
local function _15_()
  return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
map_group("<leader>l", {"a", _11_, "Code Actions", {mode = {"n", "v"}}}, {"d", _12_, "Local Diagnostics"}, {"D", _13_, "Workspace Diagnostics"}, {"f", _14_, "Format Buffer", {mode = {"n", "v"}}}, {"h", vim.lsp.buf.document_highlight, "Document Highlight"}, {"r", vim.lsp.buf.rename, "Rename Symbol"}, {"i", _15_, "Toggle Inlay Hint"})
map_group("<leader>lg", {"i", vim.lsp.buf.implementation, "Go to Implementation"}, {"d", vim.lsp.buf.definition, "Go to Definition"}, {"D", vim.lsp.buf.declaration, "Go to Declaration"}, {"t", vim.lsp.buf.type_definition, "Go to Type Definition"}, {"r", vim.lsp.buf.references, "Go to References"})
map_group("<leader>t", {"t", "<cmd>ToggleTerm direction=float<cr>", "Toggle Floating Terminal"}, {"l", "<cmd>ToggleTerm direction=vertical<cr>", "Toggle \226\134\146 Terminal"}, {"j", "<cmd>ToggleTerm direction=horizontal<cr>", "Toggle \226\134\147 Terminal"}, {"s", "<cmd>TermSelect<cr>", "Select Terminal"})
do
  local iron = autoload("iron.core")
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
  map_group("<leader>r", {"r", send_visual, "Send visual selection", {mode = "v"}}, {"r", _17_, "Send motion", {mode = "n"}}, {"t", "<cmd>IronRepl<cr>", "Toggle REPL"}, {"l", _18_, "Send current line"}, {"f", _19_, "Send the whole file"}, {"m", _20_, "Send marked"})
end
do
  local dap = autoload("dap")
  local function _21_()
    return dap.continue()
  end
  local function _22_()
    return dap.toggle_breakpoint()
  end
  local function _23_()
    return dap.step_over()
  end
  local function _24_()
    return dap.step_into()
  end
  local function _25_()
    return dap.step_out()
  end
  local function _26_()
    return dap.step_back()
  end
  local function _27_()
    return dap.terminate()
  end
  map_group("<leader>d", {"d", _21_, "Run / Continue"}, {"b", _22_, "Toggle Breakpoint"}, {"j", _23_, "Step Over"}, {"h", _24_, "Step Into"}, {"l", _25_, "Step Out"}, {"k", _26_, "Step Back"}, {"q", _27_, "Quit Session"}, {"w", "<cmd>DapViewWatch<cr>", "Watch Variable"}, {"v", "<cmd>DapViewToggle<cr>", "Toggle Debug View"})
end
local toggle_diags
local function _28_()
  local _let_29_ = vim.diagnostic.config()
  local virtual_text = _let_29_.virtual_text
  local virtual_lines = _let_29_.virtual_lines
  return vim.diagnostic.config({virtual_text = not virtual_text, virtual_lines = not virtual_lines})
end
toggle_diags = _28_
local mc = require("multicursor-nvim")
local function _30_()
  return fzf("commands")
end
local function _31_()
  return fzf("buffers")
end
local function _32_()
  return fzf("undotree")
end
map_group("<leader>", {"<leader>", _30_, "Command Palette"}, {"b", _31_, "Buffers"}, {"u", _32_, "Undo Tree"}, {"D", toggle_diags, "Toggle Diagnostics Style"}, {"g", "<cmd>Neogit<cr>", "Neogit"}, {"w", "<c-w>", "window", {remap = true}}, {"c", mc.toggleCursor, "Multiple Cursors"}, {"c", mc.matchCursors, "Match Cursors", {mode = "v"}})
local function _33_(layer)
  local function _34_()
    if not mc.cursorsEnabled() then
      return mc.enableCursors()
    else
      return nil
    end
  end
  layer("n", "<cr>", _34_)
  local function _36_()
    return mc.clearCursors()
  end
  return layer("n", "<c-c>", _36_)
end
return mc.addKeymapLayer(_33_)
