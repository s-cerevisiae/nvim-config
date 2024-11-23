[{1 "saghen/blink.cmp"
  :build "RUSTC_BOOTSTRAP=1 cargo build --release"
  :opts
  {:keymap {:preset "enter"
            "<Tab>" ["select_next" "fallback"]
            "<S-Tab>" ["select_prev" "fallback"]}
   :windows {:autocomplete {:selection "auto_insert"}}
   :fuzzy {:prebuilt_binaries {:download false}}}}]
