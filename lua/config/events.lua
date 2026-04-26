-- [nfnl] fnl/config/events.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd = _local_1_.autocmd
do
  local tmp_9_ = augroup("YankHighlight")
  local function _2_()
    return vim.highlight.on_yank()
  end
  autocmd(tmp_9_, "TextYankPost", "*", _2_)
end
do
  local tmp_9_ = augroup("DocumentHighlight")
  local function _3_()
    return vim.lsp.buf.clear_references()
  end
  autocmd(tmp_9_, {"CursorMoved", "InsertEnter"}, "*", _3_)
end
do
  local tmp_9_ = augroup("AutoQuickFix")
  local function _4_()
    return (vim.cmd("cwindow") and nil)
  end
  autocmd(tmp_9_, "QuickFixCmdPost", "grep", _4_)
end
local function _9_(_5_)
  local _arg_6_ = _5_.data
  local _arg_7_ = _arg_6_.params
  local _arg_8_ = _arg_7_.value
  local title = _arg_8_.title
  local message = _arg_8_.message
  local kind = _arg_8_.kind
  local percentage = _arg_8_.percentage
  local client_id = _arg_6_.client_id
  local _10_
  if (kind ~= "end") then
    _10_ = "running"
  else
    _10_ = "success"
  end
  vim.api.nvim_echo({{(message or "done")}}, false, {id = ("lsp." .. client_id .. "." .. title), kind = "progress", source = "vim.lsp", title = title, status = _10_, percent = percentage})
  return nil
end
autocmd(augroup("LspProg"), "LspProgress", "*", _9_)
local function _12_()
  local cmdtype = vim.v.event.cmdtype
  local abort = vim.v.event.abort
  local function _13_()
    if (((cmdtype == "/") or (cmdtype == "?")) and not abort) then
      local leap = require("leap")
      return leap.leap({pattern = vim.fn.getreg("/"), windows = require("leap.user").get_focusable_windows(), opts = {safe_labels = "", labels = leap.opts.safe_labels:gsub("[nN/?]", ""), vim_opts = {["wo.conceallevel"] = vim.wo.conceallevel}}})
    else
      return nil
    end
  end
  vim.schedule(_13_)
  return nil
end
return autocmd(augroup("JumpOnSearch"), "CmdlineLeave", "*", _12_)
