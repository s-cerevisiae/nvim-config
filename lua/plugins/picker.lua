-- [nfnl] fnl/plugins/picker.fnl
local function _1_()
  local small = (vim.o.lines < 30)
  local _2_
  if small then
    _2_ = "hidden"
  else
    _2_ = "nohidden"
  end
  return {fullscreen = small, preview = {wrap = "wrap", hidden = _2_}}
end
local function _4_(_, opts)
  local fzf = require("fzf-lua")
  fzf.setup(opts)
  return fzf.register_ui_select()
end
return {{"ibhagwan/fzf-lua", opts = {fzf_colors = true, winopts = _1_}, config = _4_}}
