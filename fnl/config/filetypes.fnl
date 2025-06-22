(local {: augroup : autocmd!} (require :utils))

;; Aggregated trivial ftplugin configs

(doto (augroup "FileTypeMisc")
  (autocmd! "Filetype"
            ["javascript" "typescript" "lua"
             "ocaml" "prolog" "scheme"]
     #(do (set vim.bo.tabstop 2)
          (set vim.bo.shiftwidth 2))))
