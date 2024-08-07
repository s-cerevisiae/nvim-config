(fn augroup [group clear]
  (vim.api.nvim_create_augroup group {: clear}))

(fn autocmd! [group event pattern cmd]
  (let [tbl {:pattern pattern
             :group group}]
    ;; callback could also be string but not supported here
    (if (= "string" (type cmd))
        (tset tbl :command cmd)
        (tset tbl :callback cmd))
    (vim.api.nvim_create_autocmd event tbl)))

{: augroup
 : autocmd!}
