-- [nfnl] fnl/plugins.fnl
local _local_1_ = require("utils")
local autocmd = _local_1_.autocmd
local augroup = _local_1_.augroup
local function github(repo)
  return ("https://github.com/" .. repo)
end
local hooks = {install = {}, update = {}, delete = {}}
local function hook_21(kinds, name, hook)
  for _, kind in ipairs(kinds) do
    hooks[kind][name] = hook
  end
  return nil
end
local function _2_(ev)
  do
    local _let_3_ = ev.data.spec
    local name = _let_3_.name
    local active = ev.data.active
    local kind = ev.data.kind
    local path = ev.data.path
    local maybe_hook = hooks[kind][name]
    if maybe_hook then
      if not active then
        vim.cmd.packadd(name)
      else
      end
      vim.notify(("Running " .. kind .. " hook for package " .. name), vim.log.levels.INFO)
      maybe_hook(path)
    else
    end
  end
  return nil
end
autocmd(augroup("PackHook"), "PackChanged", "*", _2_)
local function _6_(name, kind)
  local _let_7_ = vim.pack.get({name}, {info = false})
  local _let_8_ = _let_7_[1]
  local active = _let_8_.active
  local path = _let_8_.path
  local maybe_hook = hooks[kind][name]
  if maybe_hook then
    if not active then
      vim.cmd.packadd(name)
    else
    end
    return maybe_hook(path)
  else
    return vim.notify(("No " .. kind .. " hook available for plugin " .. name))
  end
end
local function _11_()
  return hooks
end
_G.Pack = {run_hook = _6_, get_hooks = _11_}
local _12_
do
  vim.g.bones_compat = 1
  _12_ = github("mcchrish/zenbones.nvim")
end
local _13_
do
  vim.g.nvim_surround_no_mappings = true
  _13_ = github("kylechui/nvim-surround")
end
local _14_
do
  local function _15_(_241)
    local function _17_(_16_)
      local stdout = _16_.stdout
      local stderr = _16_.stderr
      print(stdout)
      return print(stderr)
    end
    return vim.system({"cargo", "build", "--release"}, {cwd = _241, text = true}, _17_)
  end
  hook_21({"install", "update"}, "parinfer-rust", _15_)
  _14_ = github("s-cerevisiae/parinfer-rust")
end
local _18_
do
  local function _19_()
    return vim.cmd.TSUpdate()
  end
  hook_21({"update"}, "nvim-treesitter", _19_)
  _18_ = github("nvim-treesitter/nvim-treesitter")
end
return vim.pack.add({_12_, github("Olical/nfnl"), github("nvim-lua/plenary.nvim"), github("nvim-tree/nvim-web-devicons"), github("MunifTanjim/nui.nvim"), github("nvim-mini/mini.nvim"), github("b0o/incline.nvim"), github("kevinhwang91/nvim-bqf"), github("ibhagwan/fzf-lua"), github("akinsho/toggleterm.nvim"), {src = github("nvim-neo-tree/neo-tree.nvim"), version = "v3.x"}, github("stevearc/oil.nvim"), {src = github("saghen/blink.cmp"), version = vim.version.range("^1")}, github("lewis6991/gitsigns.nvim"), github("sindrets/diffview.nvim"), github("NeogitOrg/neogit"), github("folke/flash.nvim"), _13_, github("jake-stewart/multicursor.nvim"), github("hrsh7th/nvim-insx"), _14_, github("tpope/vim-repeat"), github("neovim/nvim-lspconfig"), github("pmizio/typescript-tools.nvim"), github("mfussenegger/nvim-jdtls"), github("mrcjkb/rustaceanvim"), github("mickael-menu/zk-nvim"), github("wlangstroth/vim-racket"), github("LnL7/vim-nix"), github("bakpakin/fennel.vim"), github("kaarmu/typst.vim"), github("Vigemus/iron.nvim"), github("MeanderingProgrammer/render-markdown.nvim"), github("stevearc/conform.nvim"), _18_, github("nvim-treesitter/nvim-treesitter-textobjects"), github("mfussenegger/nvim-dap"), github("igorlfs/nvim-dap-view")})
