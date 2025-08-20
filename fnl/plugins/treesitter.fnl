(import-macros {: dot} :macros)

[{1 "nvim-treesitter/nvim-treesitter"
  :branch "master"
  :dependencies [{1 "nvim-treesitter/nvim-treesitter-textobjects"
                  :branch "master"}]
  :build ":TSUpdate"
  :main "nvim-treesitter.configs"
  :opts {:ensure_installed ["vimdoc"
                            "markdown"
                            "c"
                            "lua"
                            "rust"
                            "toml"
                            "fennel"
                            "python"
                            "haskell"]
         :highlight {:enable true}
         :textobjects {:select {:enable true
                                :keymaps {"af" "@function.outer"
                                          "if" "@function.inner"
                                          "ac" "@conditional.outer"
                                          "ic" "@conditional.inner"
                                          "aa" "@parameter.outer"
                                          "ia" "@parameter.inner"}}}}}]
