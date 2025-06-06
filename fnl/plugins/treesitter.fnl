(import-macros {: dot} :macros)

[{1 "nvim-treesitter/nvim-treesitter"
  :event ["BufReadPost" "BufNewFile"]
  :dependencies ["nvim-treesitter/nvim-treesitter-textobjects"]
  :build ":TSUpdate"
  :config
  #((dot (require :nvim-treesitter.configs) setup)
    {:ensure_installed ["vimdoc"
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
                                      "ia" "@parameter.inner"}}}})}]
