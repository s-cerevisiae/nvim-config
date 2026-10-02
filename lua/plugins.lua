-- [nfnl] fnl/plugins.fnl
local hook_21 = PackHook.create
local function github(repo)
  return ("https://github.com/" .. repo)
end
local function codeberg(repo)
  return ("https://codeberg.org/" .. repo)
end
vim.cmd.packadd("nvim.difftool")
local _1_
do
  vim.g.nvim_surround_no_mappings = true
  _1_ = github("kylechui/nvim-surround")
end
local _2_
do
  local function _3_(_241)
    local function _5_(_4_)
      local stdout = _4_.stdout
      local stderr = _4_.stderr
      print(stdout)
      return print(stderr)
    end
    return vim.system({"cargo", "build", "--release"}, {cwd = _241, text = true}, _5_)
  end
  hook_21({"install", "update"}, "parinfer-rust", _3_)
  _2_ = github("eraserhd/parinfer-rust")
end
local _6_
do
  local function _7_()
    return vim.cmd.TSUpdate()
  end
  hook_21({"update"}, "nvim-treesitter", _7_)
  _6_ = github("nvim-treesitter/nvim-treesitter")
end
return vim.pack.add({github("rktjmp/lush.nvim"), {src = github("s-cerevisiae/zenbones.nvim"), version = "cache"}, github("Olical/nfnl"), github("nvim-lua/plenary.nvim"), github("MunifTanjim/nui.nvim"), github("nvim-mini/mini.nvim"), github("b0o/incline.nvim"), github("kevinhwang91/nvim-bqf"), github("ibhagwan/fzf-lua"), github("akinsho/toggleterm.nvim"), {src = github("nvim-neo-tree/neo-tree.nvim"), version = "v3.x"}, github("stevearc/oil.nvim"), {src = github("saghen/blink.cmp"), version = vim.version.range("^1")}, github("lewis6991/gitsigns.nvim"), github("sindrets/diffview.nvim"), github("NeogitOrg/neogit"), codeberg("andyg/leap.nvim"), _1_, github("jake-stewart/multicursor.nvim"), github("hrsh7th/nvim-insx"), _2_, github("tpope/vim-repeat"), github("neovim/nvim-lspconfig"), github("pmizio/typescript-tools.nvim"), github("mfussenegger/nvim-jdtls"), github("mrcjkb/rustaceanvim"), github("mickael-menu/zk-nvim"), github("wlangstroth/vim-racket"), github("LnL7/vim-nix"), github("bakpakin/fennel.vim"), github("kaarmu/typst.vim"), {src = codeberg("spore/nxd.vim"), version = "dev"}, github("Vigemus/iron.nvim"), github("MeanderingProgrammer/render-markdown.nvim"), github("stevearc/conform.nvim"), _6_, github("nvim-treesitter/nvim-treesitter-textobjects"), github("mfussenegger/nvim-dap"), github("igorlfs/nvim-dap-view")})
