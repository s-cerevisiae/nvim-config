(macro triggers [modes keys & rest]
  (each [_ m (ipairs modes)]
    (each [_ k (ipairs keys)]
      (table.insert rest {:mode m :keys k})))
  rest)

(macro submode [modes prefix keys]
  (local clues [])
  (each [_ m (ipairs modes)]
    (each [_ k (ipairs keys)]
      (table.insert clues {:mode m :keys (.. prefix k) :postkeys prefix})))
  clues)

(macro keygroups [groups]
  (icollect [k v (pairs groups)]
    {:mode "n" :keys (.. "<leader>" k) :desc v}))

{1 "nvim-mini/mini.clue"
 :opts
 #(let [{: gen_clues} (require :mini.clue)]
    {:triggers (triggers ["n" "x"]
                 ["<leader>" "g" "`" "'" "\"" "z"]
                 {:mode "n" :keys "<c-w>"}
                 {:mode "n" :keys "]"}
                 {:mode "n" :keys "["}
                 {:mode "i" :keys "<c-r>"}
                 {:mode "c" :keys "<c-r>"})
     :clues [(gen_clues.g)
             (gen_clues.z)
             (gen_clues.marks)
             (gen_clues.registers)
             (gen_clues.windows {:submode_resize true})
             (gen_clues.square_brackets)
             (submode ["n"] "<leader>d"
               ["h" "j" "k" "l"])
             (keygroups {:f "file"
                         :l "lang"
                         :lg "goto"
                         :d "debug"
                         :t "term"
                         :r "repl"})]
     :window {:config {:width "auto"
                       :border "none"}}})}
