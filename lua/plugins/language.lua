-- [nfnl] Compiled from fnl/plugins/language.fnl by https://github.com/Olical/nfnl, do not edit.
local function get_cap()
  return vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), (require("cmp_nvim_lsp")).default_capabilities())
end
local function _1_()
  local lspconfig = require("lspconfig")
  local capabilities = get_cap()
  local function setup_lsp(name, tbl)
    return lspconfig[name].setup(tbl)
  end
  setup_lsp("racket_langserver", {capabilities = capabilities, filetypes = {"racket"}})
  setup_lsp("tsserver", {capabilities = capabilities, root_dir = lspconfig.util.root_pattern("package.json"), single_file_support = false})
  setup_lsp("denols", {capabilities = capabilities, root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"), single_file_support = false})
  local function _2_(client, bufnr)
    client.server_capabilities.hoverProvider = false
    return nil
  end
  setup_lsp("ruff_lsp", {on_attach = _2_})
  setup_lsp("pyright", {settings = {python = {analysis = {ignore = "*"}}}})
  setup_lsp("tinymist", {capabilities = capabilities, single_file_support = true})
  for _, srv in ipairs({"clangd", "ocamllsp", "hls", "pyright", "nil_ls", "rescriptls"}) do
    setup_lsp(srv, {capabilities = capabilities})
  end
  return nil
end
local function _3_()
  do end (require("lsp_lines")).setup()
  return vim.diagnostic.config({virtual_lines = false})
end
local function _4_()
  local function _5_()
    return (vim.g["iron#cmd#scheme"] or {"guile"})
  end
  local function _6_()
    return (vim.g["iron#cmd#python"] or {"python"})
  end
  return (require("iron.core")).setup({config = {repl_definition = {scheme = {command = _5_}, python = {command = _6_}}, repl_open_cmd = (require("iron.view")).split("25%")}})
end
local function _7_()
  return (require("zk")).setup({picker = "telescope"})
end
local _8_
do
  local web_fts = {"javascript", "javascriptreact", "typescript", "typescriptreact", "json"}
  local web_extra_fts = {"css", "scss", "html", "jsonc"}
  local _9_
  do
    local tbl_14_auto = {}
    for _, ft in pairs(web_fts) do
      local k_15_auto, v_16_auto = ft, {{"biome", "prettier"}}
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    _9_ = tbl_14_auto
  end
  local _11_
  do
    local tbl_14_auto = {}
    for _, ft in pairs(web_extra_fts) do
      local k_15_auto, v_16_auto = ft, {"prettier"}
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    _11_ = tbl_14_auto
  end
  _8_ = {formatters_by_ft = vim.tbl_extend("keep", _9_, _11_, {python = {"ruff_format"}})}
end
return {{"neovim/nvim-lspconfig", dependencies = {"hrsh7th/cmp-nvim-lsp"}, config = _1_}, "mrcjkb/rustaceanvim", {"j-hui/fidget.nvim", tag = "legacy", config = true}, {"https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = _3_}, "wlangstroth/vim-racket", "LnL7/vim-nix", "bakpakin/fennel.vim", "kaarmu/typst.vim", {"Vigemus/iron.nvim", cmd = "IronRepl", config = _4_}, {"mickael-menu/zk-nvim", config = _7_}, {"stevearc/conform.nvim", opts = _8_}}
