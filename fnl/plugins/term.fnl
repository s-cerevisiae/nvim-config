[{1 "akinsho/toggleterm.nvim"
  :cmd "ToggleTerm"
  :opts
  {:size (fn [term]
           (match term.direction
             :horizontal (quotient vim.o.lines 4)
             :vertical (quotient vim.o.columns 2)))
   :float_opts {:border "curved"}
   :persist_mode false}}
 {1 "s-cerevisiae/flatten.nvim"
  :priority 1000
  :opts #(let [flatten (require :flatten)]
           {:window {:open "tab"}
            :block_for {:fish true
                        :jjdescription true}
            :hooks {:should_block (fn [argv]
                                    (or (flatten.hooks.should_block argv)
                                        vim.env.FLATTEN_BLOCK
                                        false))}})}]
