(import-macros {: dot} :macros)

(dot (require :gitsigns)
     (setup {:signcolumn false
             :numhl true}))

(dot (require :diffview)
     (setup {:view {:merge_tool {:layout "diff3_mixed"}}}))

(dot (require :neogit) (setup))
