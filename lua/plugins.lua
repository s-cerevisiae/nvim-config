-- [nfnl] fnl/plugins.fnl
local hook_21 = PackHook.create
local function github(repo)
  return ("https://github.com/" .. repo)
end
local _1_
do
  vim.g.bones_compat = 1
  _1_ = github("mcchrish/zenbones.nvim")
end
local _2_
do
  vim.g.nvim_surround_no_mappings = true
  _2_ = github("kylechui/nvim-surround")
end
local _3_
do
  local function _4_(_241)
    local function _6_(_5_)
      local stdout = _5_.stdout
      local stderr = _5_.stderr
      print(stdout)
      return print(stderr)
    end
    return vim.system({"cargo", "build", "--release"}, {cwd = _241, text = true}, _6_)
  end
  hook_21({"install", "update"}, "parinfer-rust", _4_)
  _3_ = github("s-cerevisiae/parinfer-rust")
end
local _7_
do
  local function _8_()
    return vim.cmd.TSUpdate()
  end
  hook_21({"update"}, "nvim-treesitter", _8_)
  _7_ = github("nvim-treesitter/nvim-treesitter")
end
return vim.pack.add({_1_, github("Olical/nfnl"), github("nvim-lua/plenary.nvim"), github("nvim-tree/nvim-web-devicons"), github("MunifTanjim/nui.nvim"), github("nvim-mini/mini.nvim"), github("b0o/incline.nvim"), github("kevinhwang91/nvim-bqf"), github("ibhagwan/fzf-lua"), github("akinsho/toggleterm.nvim"), {src = github("nvim-neo-tree/neo-tree.nvim"), version = "v3.x"}, github("stevearc/oil.nvim"), {src = github("saghen/blink.cmp"), version = vim.version.range("^1")}, github("lewis6991/gitsigns.nvim"), github("sindrets/diffview.nvim"), github("NeogitOrg/neogit"), github("folke/flash.nvim"), _2_, github("jake-stewart/multicursor.nvim"), github("hrsh7th/nvim-insx"), _3_, github("tpope/vim-repeat"), github("neovim/nvim-lspconfig"), github("pmizio/typescript-tools.nvim"), github("mfussenegger/nvim-jdtls"), github("mrcjkb/rustaceanvim"), github("mickael-menu/zk-nvim"), github("wlangstroth/vim-racket"), github("LnL7/vim-nix"), github("bakpakin/fennel.vim"), github("kaarmu/typst.vim"), github("Vigemus/iron.nvim"), github("MeanderingProgrammer/render-markdown.nvim"), github("stevearc/conform.nvim"), _7_, github("nvim-treesitter/nvim-treesitter-textobjects"), github("mfussenegger/nvim-dap"), github("igorlfs/nvim-dap-view")})
