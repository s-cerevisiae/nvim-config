-- [nfnl] fnl/config/filetypes.fnl
local _local_1_ = require("utils")
local augroup = _local_1_["augroup"]
local autocmd_21 = _local_1_["autocmd!"]
local tmp_9_ = augroup("FileTypeMisc")
local function _2_()
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
  return nil
end
autocmd_21(tmp_9_, "Filetype", {"javascript", "typescript", "lua", "ocaml", "prolog", "scheme"}, _2_)
return tmp_9_
