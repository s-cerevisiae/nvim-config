-- [nfnl] Compiled from fnl/config/events.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local augroup = _local_1_["augroup"]
local autocmd_21 = _local_1_["autocmd!"]
do
  local _2_ = augroup("YankHighlight")
  local function _3_()
    return vim.highlight.on_yank()
  end
  autocmd_21(_2_, "TextYankPost", "*", _3_)
end
local _4_ = augroup("DocumentHighlight")
local function _5_()
  return vim.lsp.buf.clear_references()
end
autocmd_21(_4_, {"CursorMoved", "InsertEnter"}, "*", _5_)
return _4_
