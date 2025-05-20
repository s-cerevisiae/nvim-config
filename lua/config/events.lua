-- [nfnl] fnl/config/events.fnl
local _local_1_ = require("utils")
local augroup = _local_1_["augroup"]
local autocmd_21 = _local_1_["autocmd!"]
do
  local tmp_9_ = augroup("YankHighlight")
  local function _2_()
    return vim.highlight.on_yank()
  end
  autocmd_21(tmp_9_, "TextYankPost", "*", _2_)
end
local tmp_9_ = augroup("DocumentHighlight")
local function _3_()
  return vim.lsp.buf.clear_references()
end
autocmd_21(tmp_9_, {"CursorMoved", "InsertEnter"}, "*", _3_)
return tmp_9_
