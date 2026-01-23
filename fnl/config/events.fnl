(local {: augroup : autocmd!} (require :utils))

;; highlight on yank
(doto (augroup "YankHighlight")
  (autocmd! "TextYankPost" "*" #(vim.highlight.on_yank)))

(doto (augroup "DocumentHighlight")
  ;; highlight is manually triggered
  (autocmd! ["CursorMoved" "InsertEnter"] "*" #(vim.lsp.buf.clear_references)))

(doto (augroup "AutoQuickFix")
  (autocmd! "QuickFixCmdPost" "grep" #(and (vim.cmd :cwindow) nil)))

(fn cursor-line []
  (-> (vim.api.nvim_win_get_cursor 0) (. 1)))
(doto (augroup "TermModeTweaks")
  (autocmd! "TermOpen" "term://*"
    #(do (vim.cmd.startinsert)
         (MiniClue.ensure_buf_triggers)
         nil))
  (autocmd! "TermLeave" "term://*"
    #(set vim.b.cursor_line_on_norm (cursor-line)))
  (autocmd! "BufLeave" "term://*"
    #(set vim.b.cursor_line_on_leave (cursor-line)))
  (autocmd! "BufEnter" "term://*"
    (fn []
      ;; left term with cursor unmoved after leaving term mode: term
      ;; left term with cursor moved: normal
      ;; left term without leaving term mode: term
      (when (or (not vim.b.cursor_line_on_leave)
                (= vim.b.cursor_line_on_norm vim.b.cursor_line_on_leave))
        (vim.cmd.startinsert))
      (set vim.b.cursor_line_on_leave nil)
      (set vim.b.cursor_line_on_norm nil))))
