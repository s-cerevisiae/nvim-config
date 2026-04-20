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
vim.keymap.set({"n", "x"}, "<leader>y", "\"+y", {remap = true, desc = "y to clip"})
vim.keymap.set({"n", "x"}, "<leader>Y", "\"+Y", {remap = true, desc = "Y to clip"})
vim.keymap.set({"n", "x"}, "<leader>p", "\"+p", {remap = true, desc = "p from clip"})
vim.keymap.set({"n", "x"}, "<leader>P", "\"+P", {remap = true, desc = "P from clip"})
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
  return require("leap.remote").action()
end
vim.keymap.set({"o"}, "r", _8_)
do
  local function map_surround(mode, key, value)
    return vim.keymap.set(mode, key, ("<Plug>(nvim-surround-" .. value .. ")"))
  end
  do
    map_surround("n", "s", "normal")
    map_surround("n", "ss", "normal-cur")
    map_surround("n", "S", "normal-line")
    map_surround("n", "SS", "normal-cur-line")
    map_surround("n", "ds", "delete")
    map_surround("n", "cs", "change")
    map_surround("n", "cS", "change-line")
  end
  map_surround("x", "s", "visual")
  map_surround("x", "S", "visual-line")
end
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
local key_groups = {}
local function map_group(prefix, desc, ...)
  local group = {...}
  table.insert(key_groups, {mode = "n", keys = prefix, desc = desc})
  for _, m in ipairs(group) do
    m[1] = (prefix .. m[1])
    map(unpack(m))
  end
  return nil
end
local function _10_()
  return fzf("files")
end
local function _11_()
  return fzf("live_grep")
end
map_group("<leader>f", "file", {"f", _10_, "File Finder"}, {"b", "<cmd>Oil<cr>", "File Browser"}, {"g", _11_, "File Grep"}, {"t", "<cmd>Neotree toggle reveal=true position=current<cr>", "File Tree"})
local function _12_()
  return fzf("lsp_code_actions")
end
local function _13_()
  return fzf("diagnostics_document", {sort = true})
end
local function _14_()
  return fzf("diagnostics_workspace", {sort = true})
end
local function _15_()
  return require("conform").format({lsp_fallback = true, stop_after_first = true, async = true})
end
local function _16_()
  return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
map_group("<leader>l", "lang", {"a", _12_, "Code Actions", {mode = {"n", "x"}}}, {"c", vim.lsp.codelens.run, "Codelens"}, {"d", _13_, "Local Diagnostics"}, {"D", _14_, "Workspace Diagnostics"}, {"f", _15_, "Format Buffer", {mode = {"n", "x"}}}, {"h", vim.lsp.buf.document_highlight, "Document Highlight"}, {"r", vim.lsp.buf.rename, "Rename Symbol"}, {"i", _16_, "Toggle Inlay Hint"})
map_group("<leader>lg", "goto", {"i", vim.lsp.buf.implementation, "Go to Implementation"}, {"d", vim.lsp.buf.definition, "Go to Definition"}, {"D", vim.lsp.buf.declaration, "Go to Declaration"}, {"t", vim.lsp.buf.type_definition, "Go to Type Definition"}, {"r", vim.lsp.buf.references, "Go to References"})
do
  local toggle_term
  local function _17_(direction)
    local function _18_()
      local count = vim.v.count
      local function _19_()
        if (count > 1) then
          return tostring(count)
        else
          return nil
        end
      end
      return require("toggleterm").toggle(count, nil, nil, direction, _19_())
    end
    return _18_
  end
  toggle_term = _17_
  map_group("<leader>t", "term", {"t", toggle_term("float"), "Toggle Floating Terminal"}, {"l", toggle_term("vertical"), "Toggle \226\134\146 Terminal"}, {"j", toggle_term("horizontal"), "Toggle \226\134\147 Terminal"}, {"s", "<cmd>TermSelect<cr>", "Select Terminal"})
end
do
  local iron = autoload("iron.core")
  local send_visual
  local function _20_()
    iron.mark_visual()
    return iron.send_mark()
  end
  send_visual = _20_
  local function _21_()
    return iron.run_motion("send_motion")
  end
  local function _22_()
    return iron.send_line()
  end
  local function _23_()
    return iron.send_file()
  end
  local function _24_()
    return iron.send_mark()
  end
  map_group("<leader>r", "repl", {"r", send_visual, "Send visual selection", {mode = "x"}}, {"r", _21_, "Send motion", {mode = "n"}}, {"t", "<cmd>IronRepl<cr>", "Toggle REPL"}, {"l", _22_, "Send current line"}, {"f", _23_, "Send the whole file"}, {"m", _24_, "Send marked"})
end
do
  local dap = autoload("dap")
  local function _25_()
    return dap.continue()
  end
  local function _26_()
    return dap.toggle_breakpoint()
  end
  local function _27_()
    return dap.step_over()
  end
  local function _28_()
    return dap.step_into()
  end
  local function _29_()
    return dap.step_out()
  end
  local function _30_()
    return dap.step_back()
  end
  local function _31_()
    return dap.terminate()
  end
  map_group("<leader>d", "debug", {"d", _25_, "Run / Continue"}, {"b", _26_, "Toggle Breakpoint"}, {"j", _27_, "Step Over"}, {"h", _28_, "Step Into"}, {"l", _29_, "Step Out"}, {"k", _30_, "Step Back"}, {"q", _31_, "Quit Session"}, {"w", "<cmd>DapViewWatch<cr>", "Watch Variable"}, {"v", "<cmd>DapViewToggle<cr>", "Toggle Debug View"})
end
do
  local toggle_diags
  local function _32_()
    local _let_33_ = vim.diagnostic.config()
    local virtual_text = _let_33_.virtual_text
    local virtual_lines = _let_33_.virtual_lines
    return vim.diagnostic.config({virtual_text = not virtual_text, virtual_lines = not virtual_lines})
  end
  toggle_diags = _32_
  local open_file
  local function _34_()
    return vim.ui.open(vim.fn.findfile(vim.fn.expand("<cfile>")))
  end
  open_file = _34_
  local open_file_visual
  local function _35_()
    return vim.ui.open(vim.fn.findfile(vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), {type = vim.fn.mode()})[1]))
  end
  open_file_visual = _35_
  local mc = require("multicursor-nvim")
  local function _36_()
    return fzf("commands")
  end
  local function _37_()
    return fzf("buffers")
  end
  local function _38_()
    return fzf("undotree")
  end
  map_group("<leader>", "menu", {"<leader>", _36_, "Command Palette"}, {"b", _37_, "Buffers"}, {"o", open_file, "Open file in system"}, {"o", open_file_visual, "Open file in system", {mode = "x"}}, {"u", _38_, "Undo Tree"}, {"D", toggle_diags, "Toggle Diagnostics Style"}, {"g", "<cmd>Neogit<cr>", "Neogit"}, {"w", "<c-w>", "window", {remap = true}}, {"s", "<Plug>(leap-anywhere)", "Leap"}, {"c", mc.toggleCursor, "Multiple Cursors"}, {"c", mc.matchCursors, "Match Cursors", {mode = "x"}})
  local function _39_(layer)
    local function _40_()
      if not mc.cursorsEnabled() then
        return mc.enableCursors()
      else
        return nil
      end
    end
    layer("n", "<cr>", _40_)
    local function _42_()
      return mc.clearCursors()
    end
    return layer("n", "<c-c>", _42_)
  end
  mc.addKeymapLayer(_39_)
end
local _let_43_ = require("mini.clue")
local setup = _let_43_.setup
local gen_clues = _let_43_.gen_clues
return setup({triggers = {{mode = "n", keys = "<c-w>"}, {mode = "n", keys = "]"}, {mode = "n", keys = "["}, {mode = "i", keys = "<c-r>"}, {mode = "c", keys = "<c-r>"}, {keys = "<leader>", mode = "n"}, {keys = "g", mode = "n"}, {keys = "`", mode = "n"}, {keys = "'", mode = "n"}, {keys = "\"", mode = "n"}, {keys = "z", mode = "n"}, {keys = "<leader>", mode = "x"}, {keys = "g", mode = "x"}, {keys = "`", mode = "x"}, {keys = "'", mode = "x"}, {keys = "\"", mode = "x"}, {keys = "z", mode = "x"}}, clues = {gen_clues.g(), gen_clues.z(), gen_clues.marks(), gen_clues.registers(), gen_clues.windows({submode_resize = true}), gen_clues.square_brackets(), {{keys = "<leader>dh", mode = "n", postkeys = "<leader>d"}, {keys = "<leader>dj", mode = "n", postkeys = "<leader>d"}, {keys = "<leader>dk", mode = "n", postkeys = "<leader>d"}, {keys = "<leader>dl", mode = "n", postkeys = "<leader>d"}}, key_groups}, window = {config = {width = "auto", border = "none"}}})
