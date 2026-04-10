(import-macros {: dot} :macros)

(dot (require :flash)
     (setup {:modes {:search {:enabled true}
                     :char {:enabled false}}
             :prompt {:enabled true
                      :prefix [["r/" "FlashPromptIcon"]]}}))

(dot (require :multicursor-nvim) (setup))

(dot (require :mini.align) (setup))

(dot (require :mini.comment)
     (setup {:options {:ignore_blank_line true}}))

(let [insx (require :insx)
      esc insx.helper.regex.esc]
  (fn auto-pair! [l r]
    (insx.add l
      (insx.with
        ((require :insx.recipe.auto_pair)
         {:open l :close r})
        [(insx.with.undopoint)])))
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
        (insx.with
          (soft-delete pats)
          [(insx.with.in_string false)]))))
  (each [_ [l r] (ipairs [["(" ")"]
                          ["[" "]"]
                          ["{" "}"]])]
    (auto-pair! l r)
    (fast-break! l r)
    (delete-pair! l r)))
