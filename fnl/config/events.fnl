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
(doto (augroup "RememberTermMode")
  (autocmd! "TermOpen" "term://*"
    #(and (vim.cmd.startinsert) nil))
  (autocmd! "TermLeave" "term://*"
    #(set vim.b.cursor_line_on_norm (cursor-line)))
  (autocmd! "WinLeave" "term://*"
    #(set vim.b.cursor_line_on_leave (cursor-line)))
  (autocmd! "BufEnter" "term://*"
    #(when (and vim.b.cursor_line_on_leave
                (= vim.b.cursor_line_on_norm vim.b.cursor_line_on_leave))
       (vim.cmd.startinsert)
       nil)))
