-- [nfnl] fnl/config/ui.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd = _local_1_.autocmd
vim.cmd.colorscheme("zenupright")
do
  local line = require("mini.statusline")
  local function content()
    local mode, mode_hl = line.section_mode({trunc_width = 80})
    local tabs
    do
      local cur = vim.api.nvim_get_current_tabpage()
      local prev = vim.fn.tabpagenr("#")
      local tbl_26_ = {}
      local i_27_ = 0
      for n, id in ipairs(vim.api.nvim_list_tabpages()) do
        local val_28_
        if (cur == id) then
          val_28_ = "\243\176\168\144"
        elseif (prev == n) then
          val_28_ = "\243\177\147\156"
        else
          val_28_ = "\243\176\167\159"
        end
        if (nil ~= val_28_) then
          i_27_ = (i_27_ + 1)
          tbl_26_[i_27_] = val_28_
        else
        end
      end
      tabs = tbl_26_
    end
    local git = line.section_git({trunc_width = 40})
    local diff = line.section_diff({trunc_width = 40})
    local diags = line.section_diagnostics({trunc_width = 40, icon = "", signs = {ERROR = "\243\176\133\152 ", WARN = "\243\176\128\170 ", INFO = "\243\176\139\189 ", HINT = "\243\176\140\182 "}})
    local file = line.section_fileinfo({trunc_width = 80})
    local loc = "%02l\226\148\130%02v"
    return line.combine_groups({{hl = mode_hl, strings = vim.list_extend({mode}, tabs)}, "%T", {hl = "StatusLine", strings = {git}}, {hl = "StatusLineNC", strings = {vim.b.gitsigns_status, diags}}, "%<%=", {hl = "StatusLine", strings = {file}}, {hl = mode_hl, strings = {loc}}})
  end
  line.setup({content = {active = content}})
end
local function _4_(props)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")
  local indicator
  if vim.bo[props.buf].modified then
    indicator = "\243\176\143\171 "
  elseif vim.bo[props.buf].readonly then
    indicator = "\243\176\143\175 "
  else
    indicator = ""
  end
  return {indicator, filename}
end
require("incline").setup({hide = {cursorline = true}, window = {margin = {vertical = 0, horizontal = 0}}, render = _4_})
local fzf = require("fzf-lua")
local opts
local function _6_()
  local small = (vim.o.lines < 30)
  local _7_
  if small then
    _7_ = "hidden"
  else
    _7_ = "nohidden"
  end
  return {fullscreen = small, preview = {wrap = "wrap", hidden = _7_}}
end
opts = {fzf_colors = true, winopts = _6_}
fzf.setup(opts)
return fzf.register_ui_select()
