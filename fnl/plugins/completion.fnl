[{1 "saghen/blink.cmp"
  :version "*"
  :event ["InsertEnter" "CmdlineEnter"]
  :opts
  {:keymap {:preset "enter"
            "<Tab>" ["select_next" "fallback"]
            "<S-Tab>" ["select_prev" "fallback"]}
   :cmdline {:keymap {"<Tab>" ["show_and_insert" "select_next"]
                      "<S-Tab>" ["show_and_insert" "select_prev"]
                      "<Up>" ["select_prev" "fallback"]
                      "<Down>" ["select_next" "fallback"]
                      "<CR>" ["accept" "fallback"]}}
   :completion {:list {:selection {:preselect false}}}}}]
