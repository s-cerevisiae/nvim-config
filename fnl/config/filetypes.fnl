(local {: augroup : autocmd!} (require :utils))

;; Aggregated ftplugin configs
(doto (augroup "FileTypeMisc")
  (autocmd! "Filetype"
            ["javascript" "typescript" "css"
             "javascriptreact" "typescriptreact"
             "ocaml" "prolog" "scheme" "lua"]
    #(do (set vim.bo.tabstop 2)
         (set vim.bo.shiftwidth 2)))
  (autocmd! "Filetype" "rust"
    #(do (vim.keymap.set "n" "K"
           #(vim.cmd.RustLsp "hover" "actions")
           {:silent true :buffer 0})
         nil)))

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
