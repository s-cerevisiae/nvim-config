(fn gen-sign [f]
  (let [sign-names ["Error" "Warn" "Info" "Hint"]]
    (collect [_ name (ipairs sign-names)]
      (values (. vim.diagnostic.severity (string.upper name))
              (f name)))))

(fn define-linehl [severity]
  (let [{: bg} (vim.api.nvim_get_hl 0
                 {:name (.. "DiagnosticVirtualText" severity)
                  :link false})
        hl-name (.. "DiagnosticLine" severity)]
    (vim.api.nvim_set_hl 0 hl-name {: bg})
    hl-name))

(local signs
  (let [linehl (gen-sign define-linehl)
        cancel (gen-sign #"")]
    {:text cancel :numhl cancel : linehl}))

(vim.diagnostic.config {:severity_sort true :virtual_text true : signs})
