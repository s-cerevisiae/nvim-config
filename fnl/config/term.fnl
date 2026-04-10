(import-macros {: dot} :macros)
(local {: augroup : autocmd} (require :utils))

(dot (require :toggleterm)
     (setup {:size (fn [term]
                     (match term.direction
                       :horizontal (quotient vim.o.lines 4)
                       :vertical (quotient vim.o.columns 2)))
             ;; this interferes with my autocmds
             :start_in_insert false
             :persist_mode false}))

(fn cursor-line []
  (-> (vim.api.nvim_win_get_cursor 0) (. 1)))
(doto (augroup "TermModeTweaks")
  (autocmd "TermOpen" "term://*"
    #(do (vim.cmd.startinsert)
         (MiniClue.ensure_buf_triggers)
         nil))
  (autocmd "TermLeave" "term://*"
    #(set vim.b.cursor_line_on_norm (cursor-line)))
  (autocmd "BufLeave" "term://*"
    #(set vim.b.cursor_line_on_leave (cursor-line)))
  (autocmd "BufEnter" "term://*"
    (fn []
      ;; left term with cursor unmoved after leaving term mode: term
      ;; left term with cursor moved: normal
      ;; left term without leaving term mode: term
      (when (or (not vim.b.cursor_line_on_leave)
                (= vim.b.cursor_line_on_norm vim.b.cursor_line_on_leave))
        (vim.cmd.startinsert))
      (set vim.b.cursor_line_on_leave nil)
      (set vim.b.cursor_line_on_norm nil))))
