-- [nfnl] fnl/config/events.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd_21 = _local_1_["autocmd!"]
do
  local tmp_9_ = augroup("YankHighlight")
  local function _2_()
    return vim.highlight.on_yank()
  end
  autocmd_21(tmp_9_, "TextYankPost", "*", _2_)
end
do
  local tmp_9_ = augroup("DocumentHighlight")
  local function _3_()
    return vim.lsp.buf.clear_references()
  end
  autocmd_21(tmp_9_, {"CursorMoved", "InsertEnter"}, "*", _3_)
end
do
  local tmp_9_ = augroup("AutoQuickFix")
  local function _4_()
    return (vim.cmd("cwindow") and nil)
  end
  autocmd_21(tmp_9_, "QuickFixCmdPost", "grep", _4_)
end
local function cursor_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end
local tmp_9_ = augroup("TermModeTweaks")
local function _5_()
  vim.cmd.startinsert()
  MiniClue.ensure_buf_triggers()
  return nil
end
autocmd_21(tmp_9_, "TermOpen", "term://*", _5_)
local function _6_()
  vim.b.cursor_line_on_norm = cursor_line()
  return nil
end
autocmd_21(tmp_9_, "TermLeave", "term://*", _6_)
local function _7_()
  vim.b.cursor_line_on_leave = cursor_line()
  return nil
end
autocmd_21(tmp_9_, "BufLeave", "term://*", _7_)
local function _8_()
  if (not vim.b.cursor_line_on_leave or (vim.b.cursor_line_on_norm == vim.b.cursor_line_on_leave)) then
    vim.cmd.startinsert()
  else
  end
  vim.b.cursor_line_on_leave = nil
  vim.b.cursor_line_on_norm = nil
  return nil
end
autocmd_21(tmp_9_, "BufEnter", "term://*", _8_)
return tmp_9_
