(vim.pack.add ["https://github.com/s-cerevisiae/flatten.nvim"])

(let [flatten (require :flatten)]
  (flatten.setup
    {:window {:open "tab"}
     :block_for {:fish true
                 :jjdescription true}
     :hooks {:should_block (fn [argv]
                             (or (flatten.hooks.should_block argv)
                                 vim.env.FLATTEN_BLOCK
                                 false))}}))
