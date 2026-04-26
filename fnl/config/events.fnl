(import-macros {: dot} :macros)
(local {: augroup : autocmd} (require :utils))

;; highlight on yank
(doto (augroup "YankHighlight")
  (autocmd "TextYankPost" "*" #(vim.highlight.on_yank)))

(doto (augroup "DocumentHighlight")
  ;; highlight is manually triggered
  (autocmd ["CursorMoved" "InsertEnter"] "*" #(vim.lsp.buf.clear_references)))

(doto (augroup "AutoQuickFix")
  (autocmd "QuickFixCmdPost" "grep" #(and (vim.cmd :cwindow) nil)))

(autocmd (augroup "LspProg")
  "LspProgress" "*"
  (fn [{:data {:params {:value {: title
                                : message
                                : kind
                                : percentage}}
               : client_id}}]
    (vim.api.nvim_echo
      [[(or message "done")]]
      false
      {:id (.. "lsp." client_id "." title)
       :kind "progress"
       :source "vim.lsp"
       : title
       :status (if (~= kind "end") "running" "success")
       :percent percentage})
    nil))

(autocmd (augroup "JumpOnSearch")
         "CmdlineLeave" "*"
  #(let [{: cmdtype : abort} vim.v.event]
     (vim.schedule
       #(when (and (or (= cmdtype "/")
                       (= cmdtype "?"))
                   (not abort))
          (let [leap (require :leap)]
            (leap.leap {:pattern (vim.fn.getreg "/")
                        :windows (dot (require :leap.user) (get_focusable_windows))
                        :opts {:safe_labels ""
                               :labels (leap.opts.safe_labels:gsub "[nN/?]" "")
                               :vim_opts {:wo.conceallevel vim.wo.conceallevel}}}))))
     nil))
