-- [nfnl] Compiled from fnl/plugins/language.fnl by https://github.com/Olical/nfnl, do not edit.
local function get_cap()
  return require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
end
local function _1_()
  local lspconfig = require("lspconfig")
  local capabilities = get_cap()
  local function setup_lsp(name, tbl)
    return lspconfig[name].setup(tbl)
  end
  setup_lsp("racket_langserver", {capabilities = capabilities, filetypes = {"racket"}})
  setup_lsp("denols", {capabilities = capabilities, root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"), single_file_support = false})
  local function _2_(client, bufnr)
    client.server_capabilities.hoverProvider = false
    return nil
  end
  setup_lsp("ruff", {on_attach = _2_})
  setup_lsp("pyright", {settings = {python = {analysis = {ignore = "*"}}}})
  setup_lsp("tinymist", {capabilities = capabilities, single_file_support = true})
  for _, srv in ipairs({"clangd", "ocamllsp", "hls", "pyright", "nil_ls", "rescriptls"}) do
    setup_lsp(srv, {capabilities = capabilities})
  end
  return nil
end
local function _3_()
  return {capabilities = get_cap(), root_dir = require("lspconfig").util.root_pattern("package.json"), settings = {tsserver_max_memory = 4096}, single_file_support = false}
end
local function _4_()
  local function _5_()
    return (vim.g["iron#cmd#scheme"] or {"guile"})
  end
  local function _6_()
    return (vim.g["iron#cmd#python"] or {"python"})
  end
  return require("iron.core").setup({config = {repl_definition = {scheme = {command = _5_}, python = {command = _6_, format = require("iron.fts.common").bracketed_paste}}, repl_open_cmd = require("iron.view").split("25%")}})
end
local function _7_()
  return require("zk").setup({picker = "fzf_lua"})
end
local _8_
do
  local web_fts = {"javascript", "javascriptreact", "typescript", "typescriptreact", "json"}
  local web_extra_fts = {"css", "scss", "html", "jsonc"}
  local _9_
  do
    local tbl_16_auto = {}
    for _, ft in pairs(web_fts) do
      local k_17_auto, v_18_auto = ft, {"biome", "prettier"}
      if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
        tbl_16_auto[k_17_auto] = v_18_auto
      else
      end
    end
    _9_ = tbl_16_auto
  end
  local _11_
  do
    local tbl_16_auto = {}
    for _, ft in pairs(web_extra_fts) do
      local k_17_auto, v_18_auto = ft, {"prettier"}
      if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
        tbl_16_auto[k_17_auto] = v_18_auto
      else
      end
    end
    _11_ = tbl_16_auto
  end
  _8_ = {formatters_by_ft = vim.tbl_extend("keep", _9_, _11_, {python = {"ruff_format"}})}
end
return {{"neovim/nvim-lspconfig", event = {"BufReadPost", "BufNewFile"}, config = _1_}, {"pmizio/typescript-tools.nvim", event = {"BufReadPost", "BufNewFile"}, dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}, opts = _3_}, "mrcjkb/rustaceanvim", "mfussenegger/nvim-jdtls", "wlangstroth/vim-racket", "LnL7/vim-nix", "bakpakin/fennel.vim", "kaarmu/typst.vim", {"Vigemus/iron.nvim", cmd = "IronRepl", config = _4_}, {"mickael-menu/zk-nvim", config = _7_}, {"stevearc/conform.nvim", opts = _8_}}
