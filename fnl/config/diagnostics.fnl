(let [signs ["Error" "Warn" "Info" "Hint"]]
  (vim.diagnostic.config {:severity_sort true})
  (each [_ name (ipairs signs)]
    (local hl
      (vim.api.nvim_get_hl 0
        {:name (.. "DiagnosticVirtualText" name)
         :link false}))
    (local hl-name (.. "DiagnosticLine" name))
    (vim.api.nvim_set_hl 0 hl-name {:bg hl.bg})
    (vim.fn.sign_define (.. "DiagnosticSign" name) {:linehl hl-name})))
