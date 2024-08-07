-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("nvim-treesitter.configs")).setup({ensure_installed = {"vimdoc", "markdown", "c", "lua", "rust", "toml", "fennel", "python", "haskell"}, highlight = {enable = true}, textobjects = {select = {enable = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@conditional.outer", ic = "@conditional.inner", aa = "@parameter.outer", ia = "@parameter.inner"}}}})
end
return {{"nvim-treesitter/nvim-treesitter", dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"}, build = ":TSUpdate", config = _1_}}
