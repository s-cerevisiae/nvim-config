[{1 "akinsho/toggleterm.nvim"
  :cmd "ToggleTerm"
  :opts
  {:size (fn [term]
           (match term.direction
             :horizontal (quotient vim.o.lines 4)
             :vertical (quotient vim.o.columns 2)))
   :float_opts {:border "curved"}
   :persist_mode false}}]
