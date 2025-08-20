(local {: augroup : autocmd!} (require :utils))

;; Aggregated trivial ftplugin configs

(doto (augroup "FileTypeMisc")
  (autocmd! "Filetype"
            ["javascript" "typescript" "css"
             "javascriptreact" "typescriptreact"
             "ocaml" "prolog" "scheme" "lua"]
     #(do (set vim.bo.tabstop 2)
          (set vim.bo.shiftwidth 2))))

;; Evaluate "*.data.clj" and write the output to file

(fn write-data-clj [buf]
  (let [script-file (vim.api.nvim_buf_get_name buf)
        data-file (string.sub script-file 1 -10)]
    (vim.system ["bb" "-f" script-file] {}
      (fn [{: stdout}]
        (doto (io.open data-file "w")
              (: :write stdout)
              (: :close))))))

(doto (augroup "DataClj")
  (autocmd! "BufWritePost" "*.data.clj"
    (fn [{: buf}]
      (write-data-clj buf)
      nil)))
