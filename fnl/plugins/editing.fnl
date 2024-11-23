[{1 "folke/flash.nvim"
  :opts {:modes {:search {:enabled true}
                 :char {:enabled false}}
         :prompt {:enabled true
                  :prefix [["r/" "FlashPromptIcon"]]}}}
 {1 "kylechui/nvim-surround"
  :opts {:keymaps {:normal "s"
                   :normal_cur "ss"
                   :normal_line "S"
                   :normal_cur_line "SS"
                   :visual "s"
                   :visual_line "S"}}}
 {1 "numToStr/Comment.nvim"
  :opts {:ignore "^$"}}
 {1 "hrsh7th/nvim-insx"
  :config
  #(let [insx (require :insx)
         esc insx.helper.regex.esc]
     (fn auto-pair! [l r]
       (insx.add l
         (insx.with
           ((require :insx.recipe.auto_pair)
            {:open l :close r})
           [(insx.with.in_string false)
            (insx.with.undopoint)])))
     (fn fast-break! [l r]
       (insx.add "<CR>"
         ((require :insx.recipe.fast_break)
          {:open_pat (esc l)
           :close_pat (esc r)})))
     (fn soft-delete [option]
       {:action #($.send "<Left>")
        :enabled #($.match (.. option.close_pat "\\%#"))})
     (fn delete-pair! [l r]
       (let [pats {:open_pat (esc l)
                   :close_pat (esc r)}]
         (insx.add "<BS>"
           ((require :insx.recipe.delete_pair) pats))
         (insx.add "<BS>"
           (soft-delete pats))))
     (each [_ [l r] (ipairs [["(" ")"]
                             ["[" "]"]
                             ["{" "}"]])]
       (auto-pair! l r)
       (fast-break! l r)
       (delete-pair! l r)))}
 "eraserhd/parinfer-rust"
 "tpope/vim-repeat"]
