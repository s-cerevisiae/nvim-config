-- [nfnl] fnl/config/filetypes.fnl
local _local_1_ = require("utils")
local augroup = _local_1_["augroup"]
local autocmd_21 = _local_1_["autocmd!"]
do
  local tmp_9_ = augroup("FileTypeMisc")
  local function _2_()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    return nil
  end
  autocmd_21(tmp_9_, "Filetype", {"javascript", "typescript", "css", "javascriptreact", "typescriptreact", "ocaml", "prolog", "scheme", "lua"}, _2_)
end
local function write_data_clj(buf)
  local script_file = vim.api.nvim_buf_get_name(buf)
  local data_file = string.sub(script_file, 1, -10)
  local function _4_(_3_)
    local stdout = _3_["stdout"]
    local tmp_9_ = io.open(data_file, "w")
    tmp_9_:write(stdout)
    tmp_9_:close()
    return tmp_9_
  end
  return vim.system({"bb", "-f", script_file}, {}, _4_)
end
local tmp_9_ = augroup("DataClj")
local function _6_(_5_)
  local buf = _5_["buf"]
  write_data_clj(buf)
  return nil
end
autocmd_21(tmp_9_, "BufWritePost", "*.data.clj", _6_)
return tmp_9_
