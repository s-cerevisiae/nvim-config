-- [nfnl] fnl/config/options.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd = _local_1_.autocmd
local function set_options(options)
  for opt, val in pairs(options) do
    vim.o[opt] = val
  end
  return nil
end
set_options({number = true, relativenumber = true, numberwidth = 3, signcolumn = "number", cmdheight = 0, cursorline = true, tabstop = 4, shiftwidth = 4, expandtab = true, foldlevel = 99, termguicolors = true, mouse = "a", undofile = true, ignorecase = true, smartcase = true, updatetime = 300, list = true, listchars = "tab:>-,trail:\195\151,nbsp:+", showtabline = 0, laststatus = 3, pumheight = 10, splitright = true, splitbelow = true, grepprg = "rg --vimgrep --hidden", shellxquote = "", shellcmdflag = "-c", exrc = true, showmode = false})
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local function set_scrolloff(info)
  if not vim.startswith(info.file, "term://") then
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    vim.wo.sidescrolloff = quotient(width, 10)
    vim.wo.scrolloff = quotient(height, 5)
    return nil
  else
    return nil
  end
end
local tmp_9_ = augroup("SetScrollOff")
autocmd(tmp_9_, {"BufEnter", "WinEnter", "VimResized"}, "*", set_scrolloff)
return tmp_9_
