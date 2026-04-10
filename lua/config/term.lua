-- [nfnl] fnl/config/term.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd = _local_1_.autocmd
local function _2_(term)
  local case_3_ = term.direction
  if (case_3_ == "horizontal") then
    return quotient(vim.o.lines, 4)
  elseif (case_3_ == "vertical") then
    return quotient(vim.o.columns, 2)
  else
    return nil
  end
end
require("toggleterm").setup({size = _2_, persist_mode = false, start_in_insert = false})
local function cursor_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end
local tmp_9_ = augroup("TermModeTweaks")
local function _5_()
  vim.cmd.startinsert()
  MiniClue.ensure_buf_triggers()
  return nil
end
autocmd(tmp_9_, "TermOpen", "term://*", _5_)
local function _6_()
  vim.b.cursor_line_on_norm = cursor_line()
  return nil
end
autocmd(tmp_9_, "TermLeave", "term://*", _6_)
local function _7_()
  vim.b.cursor_line_on_leave = cursor_line()
  return nil
end
autocmd(tmp_9_, "BufLeave", "term://*", _7_)
local function _8_()
  if (not vim.b.cursor_line_on_leave or (vim.b.cursor_line_on_norm == vim.b.cursor_line_on_leave)) then
    vim.cmd.startinsert()
  else
  end
  vim.b.cursor_line_on_leave = nil
  vim.b.cursor_line_on_norm = nil
  return nil
end
autocmd(tmp_9_, "BufEnter", "term://*", _8_)
return tmp_9_
