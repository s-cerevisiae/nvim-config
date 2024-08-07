(import-macros {: require.} :macros)
(local {: augroup : autocmd!} (require :utils))

;; highlight on yank
(doto (augroup "YankHighlight")
  (autocmd! "TextYankPost" "*" #(vim.highlight.on_yank)))

(doto (augroup "DocumentHighlight")
  ;; highlight is manually triggered
  (autocmd! ["CursorMoved" "InsertEnter"] "*" #(vim.lsp.buf.clear_references)))
