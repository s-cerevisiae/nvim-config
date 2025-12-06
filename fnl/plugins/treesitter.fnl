(import-macros {: dot} :macros)

(local {: augroup : autocmd!} (require :utils))

[{1 "nvim-treesitter/nvim-treesitter"
  :branch "main"
  :build ":TSUpdate"
  :config
  #(let [ts (require :nvim-treesitter)
         always-install ["vimdoc" "markdown" "c" "lua"
                         "rust" "toml" "fennel" "python"]]
     (ts.install always-install)
     (let [installed (ts.get_installed)
           filetypes (-> (vim.iter installed)
                         (: :map vim.treesitter.language.get_filetypes)
                         (: :flatten)
                         (: :totable))]
       (if (not (vim.tbl_isempty filetypes))
         (autocmd! (augroup "NvimTreesitterCfg")
           "FileType" filetypes
           #(do (vim.treesitter.start)
                (set vim.wo.foldexpr "v:lua.vim.treesitter.foldexpr()"))))))}
 {1 "nvim-treesitter/nvim-treesitter-textobjects"
  :branch "main"
  :lazy true}]
