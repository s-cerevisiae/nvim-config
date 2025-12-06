-- [nfnl] fnl/plugins/treesitter.fnl
local _local_1_ = require("utils")
local augroup = _local_1_.augroup
local autocmd_21 = _local_1_["autocmd!"]
local function _2_()
  local ts = require("nvim-treesitter")
  local always_install = {"vimdoc", "markdown", "c", "lua", "rust", "toml", "fennel", "python"}
  ts.install(always_install)
  local installed = ts.get_installed()
  local filetypes = vim.iter(installed):map(vim.treesitter.language.get_filetypes):flatten():totable()
  if not vim.tbl_isempty(filetypes) then
    local function _3_()
      vim.treesitter.start()
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      return nil
    end
    return autocmd_21(augroup("NvimTreesitterCfg"), "FileType", filetypes, _3_)
  else
    return nil
  end
end
return {{"nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate", config = _2_}, {"nvim-treesitter/nvim-treesitter-textobjects", branch = "main", lazy = true}}
