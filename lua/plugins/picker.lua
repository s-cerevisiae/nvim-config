-- [nfnl] Compiled from fnl/plugins/picker.fnl by https://github.com/Olical/nfnl, do not edit.
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
return {{"ibhagwan/fzf-lua", opts = {fzf_colors = true, winopts = _1_}}}
