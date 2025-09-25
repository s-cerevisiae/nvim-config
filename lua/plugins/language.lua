-- [nfnl] fnl/plugins/language.fnl
local function get_cap()
  return require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
end
local function _1_()
  vim.lsp.config("racket_langserver", {filetypes = {"racket"}})
  vim.lsp.config("denols", {root_markers = {"deno.json", "deno.jsonc"}})
  vim.lsp.config("basedpyright", {settings = {python = {analysis = {ignore = "*"}}}})
  return vim.lsp.enable({"racket_langserver", "denols", "ruff", "basedpyright", "tinymist", "clangd", "ocamllsp", "hls", "nil_ls", "rescriptls"})
end
local function _2_()
  return {capabilities = get_cap(), root_dir = require("lspconfig").util.root_pattern("package.json"), settings = {tsserver_max_memory = 4096}, single_file_support = false}
end
local function _3_()
  local function _4_()
    return (vim.g["iron#cmd#scheme"] or {"guile"})
  end
  local function _5_()
    return (vim.g["iron#cmd#python"] or {"python"})
  end
  return {config = {repl_definition = {scheme = {command = _4_}, python = {command = _5_, format = require("iron.fts.common").bracketed_paste}, fennel = {command = {"nvim", "-l", (vim.fn.stdpath("data") .. "/lazy/nfnl/script/fennel.lua")}}}, repl_open_cmd = require("iron.view").split("25%")}}
end
local _6_
do
  local web_fts = {"javascript", "javascriptreact", "typescript", "typescriptreact", "json"}
  local web_extra_fts = {"css", "scss", "html", "jsonc"}
  local _7_
  do
    local tbl_16_ = {}
    for _, ft in pairs(web_fts) do
      local k_17_, v_18_ = ft, {"biome", "prettier"}
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    _7_ = tbl_16_
  end
  local _9_
  do
    local tbl_16_ = {}
    for _, ft in pairs(web_extra_fts) do
      local k_17_, v_18_ = ft, {"prettier"}
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    _9_ = tbl_16_
  end
  _6_ = {formatters_by_ft = vim.tbl_extend("keep", _7_, _9_, {python = {"ruff_format"}})}
end
return {{"neovim/nvim-lspconfig", config = _1_}, {"pmizio/typescript-tools.nvim", event = {"BufReadPost", "BufNewFile"}, dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}, opts = _2_}, "mrcjkb/rustaceanvim", "mfussenegger/nvim-jdtls", "wlangstroth/vim-racket", "LnL7/vim-nix", "bakpakin/fennel.vim", "kaarmu/typst.vim", {"Vigemus/iron.nvim", cmd = "IronRepl", main = "iron.core", opts = _3_}, {"mickael-menu/zk-nvim", main = "zk", opts = {picker = "fzf_lua"}}, {"stevearc/conform.nvim", opts = _6_}}
