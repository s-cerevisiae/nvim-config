-- [nfnl] Compiled from fnl/config/options.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local augroup = _local_1_["augroup"]
local autocmd_21 = _local_1_["autocmd!"]
local function set_options(options)
  for opt, val in pairs(options) do
    vim.o[opt] = val
  end
  return nil
end
set_options({number = true, relativenumber = true, numberwidth = 3, signcolumn = "number", cursorline = true, tabstop = 4, shiftwidth = 4, expandtab = true, termguicolors = true, mouse = "a", undofile = true, ignorecase = true, smartcase = true, complete = "", updatetime = 300, list = true, listchars = "tab:>-,trail:\195\151,nbsp:+", showtabline = 0, pumheight = 10, splitright = true, splitbelow = true, grepprg = "rg --vimgrep --hidden", shellxquote = "", shellcmdflag = "-c", exrc = true, showmode = false})
local function set_scrolloff()
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  vim.wo.sidescrolloff = quotient(width, 10)
  vim.wo.scrolloff = quotient(height, 5)
  return nil
end
local tmp_9_auto = augroup("SetScrollOff")
autocmd_21(tmp_9_auto, {"BufEnter", "WinEnter", "VimResized"}, "*", set_scrolloff)
return tmp_9_auto
