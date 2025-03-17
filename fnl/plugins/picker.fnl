[{1 "ibhagwan/fzf-lua"
  :opts {:fzf_colors true
         :winopts #(let [small (< vim.o.lines 30)]
                     {:fullscreen small
                      :preview {:wrap "wrap"
                                :hidden (if small "hidden" "nohidden")}})}}]
