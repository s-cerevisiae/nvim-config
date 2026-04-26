-- [nfnl] fnl/config/language.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd = _local_1_.autocmd
vim.lsp.config("racket_langserver", {filetypes = {"racket"}})
vim.lsp.config("denols", {root_markers = {"deno.json", "deno.jsonc"}})
vim.lsp.config("basedpyright", {settings = {python = {analysis = {ignore = "*"}}}})
vim.lsp.enable({"racket_langserver", "denols", "biome", "ruff", "pyrefly", "jdtls", "tinymist", "clangd", "ocamllsp", "hls", "nil_ls", "rescriptls"})
require("typescript-tools").setup({settings = {tsserver_max_memory = 4096}, single_file_support = false})
local function _2_()
  return (vim.g["iron#cmd#scheme"] or {"guile"})
end
local function _3_()
  return (vim.g["iron#cmd#python"] or {"python"})
end
require("iron.core").setup({config = {repl_definition = {scheme = {command = _2_}, python = {command = _3_, format = require("iron.fts.common").bracketed_paste}, fennel = {command = {"nvim", "-l", (vim.fn.stdpath("data") .. "/lazy/nfnl/script/fennel.lua")}}}, repl_open_cmd = require("iron.view").split("25%")}})
require("zk").setup({picker = "fzf_lua"})
do
  local web_fts = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css", "html", "json", "jsonc"}
  local web_extra_fts = {"scss"}
  local _4_
  do
    local tbl_21_ = {}
    for _, ft in pairs(web_fts) do
      local k_22_, v_23_ = ft, {"biome", "prettier"}
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    _4_ = tbl_21_
  end
  local _6_
  do
    local tbl_21_ = {}
    for _, ft in pairs(web_extra_fts) do
      local k_22_, v_23_ = ft, {"prettier"}
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    _6_ = tbl_21_
  end
  require("conform").setup({formatters_by_ft = vim.tbl_extend("keep", _4_, _6_, {python = {"ruff_format"}})})
end
do
  local ts = require("nvim-treesitter")
  local always_install = {"vimdoc", "markdown", "c", "lua", "rust", "toml", "fennel", "python"}
  ts.install(always_install)
end
local function _8_()
  if pcall(vim.treesitter.start) then
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    return nil
  else
    return nil
  end
end
autocmd(augroup("NvimTreesitterCfg"), "FileType", "*", _8_)
local function _12_(_10_)
  local _arg_11_ = _10_.data
  local client_id = _arg_11_.client_id
  if vim.lsp.get_client_by_id(client_id):supports_method("textDocument/foldingRange") then
    vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
    vim.wo.foldmethod = "expr"
    return nil
  else
    return nil
  end
end
autocmd(augroup("LspFold"), "LspAttach", "*", _12_)
do
  local tmp_9_ = augroup("FileTypeMisc")
  local function _14_()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    return nil
  end
  autocmd(tmp_9_, "Filetype", {"javascript", "typescript", "css", "javascriptreact", "typescriptreact", "ocaml", "prolog", "scheme", "lua"}, _14_)
  local function _15_()
    local function _16_()
      return vim.cmd.RustLsp("hover", "actions")
    end
    vim.keymap.set("n", "K", _16_, {silent = true, buffer = 0})
    return nil
  end
  autocmd(tmp_9_, "Filetype", "rust", _15_)
end
local function write_data_clj(buf)
  local script_file = vim.api.nvim_buf_get_name(buf)
  local data_file = string.sub(script_file, 1, -10)
  local function _18_(_17_)
    local stdout = _17_.stdout
    local tmp_9_ = io.open(data_file, "w")
    tmp_9_:write(stdout)
    tmp_9_:close()
    return tmp_9_
  end
  return vim.system({"bb", "-f", script_file}, {}, _18_)
end
local tmp_9_ = augroup("DataClj")
local function _20_(_19_)
  local buf = _19_.buf
  write_data_clj(buf)
  return nil
end
autocmd(tmp_9_, "BufWritePost", "*.data.clj", _20_)
return tmp_9_
