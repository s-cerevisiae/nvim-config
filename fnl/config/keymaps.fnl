(import-macros {: dot : |} :macros)

(local {: autoload} (require :nfnl.module))

;; Better movement across wrapped lines
(vim.keymap.set "n" "k"
  #(if (= 0 vim.v.count) "gk" "k")
  {:expr true :silent true})
(vim.keymap.set "n" "j"
  #(if (= 0 vim.v.count) "gj" "j")
  {:expr true :silent true})

;; System clipboard shortcuts
(vim.keymap.set ["n" "v"] "<leader>y"
  "\"+y"
  {:remap true
   :desc "y to clip"})
(vim.keymap.set ["n" "v"] "<leader>Y"
  "\"+Y"
  {:remap true
   :desc "Y to clip"})
(vim.keymap.set ["n" "v"] "<leader>p"
  "\"+p"
  {:remap true
   :desc "p from clip"})
(vim.keymap.set ["n" "v"] "<leader>P"
  "\"+P"
  {:remap true
   :desc "P from clip"})

;; Terminal mode escape
(vim.keymap.set "t" "<Esc>" "<C-\\><C-n>")

;; snippet jumps
(vim.keymap.set ["i" "s"] "<c-l>"
  #(vim.snippet.jump 1)
  {:expr true :silent true})
(vim.keymap.set ["i" "s"] "<c-h>"
  #(vim.snippet.jump -1)
  {:expr true :silent true})

;; Flash "remote" actions
(vim.keymap.set ["o"] "r"
  #(dot (require :flash) (remote)))

(fn fzf [cmd] ((-> (require :fzf-lua) (. cmd))))

(let [wk (require :which-key)
      file [(| "<leader>f" {:group "file"})
            (| "<leader>ff" #(fzf :files) {:desc "File Finder"})
            (| "<leader>fb" "<cmd>Oil<cr>" {:desc "File Browser"})
            (| "<leader>ft" "<cmd>Neotree toggle reveal=true position=current<cr>" {:desc "File Tree"})]
      lang [(| "<leader>l" {:group "lang"})
            (| "<leader>la" #(fzf :lsp_code_actions) {:desc "Code actions" :mode ["n" "v"]})
            (| "<leader>ld" #(fzf :diagnostics_document) {:desc "Current file diagnostics"})
            (| "<leader>lD" #(fzf :diagnostics_workspace) {:desc "Workspace diagnostics"})
            (| "<leader>lf" #(dot (require :conform)
                                  (format {:lsp_fallback true
                                           :stop_after_first true
                                           :async true}))
                            {:desc "Format buffer" :mode ["n" "v"]})
            (| "<leader>lh" #(vim.lsp.buf.document_highlight) {:desc "Document highlight"})
            (| "<leader>lr" vim.lsp.buf.rename {:desc "Rename symbol"})
            (| "<leader>li" #(vim.lsp.inlay_hint.enable
                               (not (vim.lsp.inlay_hint.is_enabled)))
                            {:desc "Toggle inlay hint"})]
      goto [(| "<leader>lg" {:group "goto"})
            (| "<leader>lgi" vim.lsp.buf.implementation {:desc "Go to implementation"})
            (| "<leader>lgd" vim.lsp.buf.definition {:desc "Go to definition"})
            (| "<leader>lgD" vim.lsp.buf.declaration {:desc "Go to declaration"})
            (| "<leader>lgt" vim.lsp.buf.type_definition {:desc "Go to type definition"})
            (| "<leader>lgr" vim.lsp.buf.references {:desc "Go to references"})]
      term [(| "<leader>t" {:desc "term"})
            (| "<leader>tl" "<cmd>ToggleTerm direction=vertical<cr>" {:desc "Toggle → terminal"})
            (| "<leader>tj" "<cmd>ToggleTerm direction=horizontal<cr>" {:desc "Toggle ↓ terminal"})
            (| "<leader>tt" "<cmd>ToggleTerm direction=float<cr>" {:desc "Toggle floating terminal"})
            (| "<leader>ts" "<cmd>TermSelect<cr>" {:desc "Select term"})]
      repl (let [iron (autoload :iron.core)
                 toggle-repl "<cmd>IronRepl<cr>"
                 send-visual #(do (iron.mark_visual)
                                  (iron.send_mark))]
             [(| "<leader>r" {:desc "repl"})
              (| "<leader>rr" send-visual {:desc "Send visual selection" :mode "v"})
              (| "<leader>rr" #(iron.run_motion "send_motion") {:desc "Send motion" :mode "n"})
              (| "<leader>rt" toggle-repl {:desc "Toggle REPL"})
              (| "<leader>rl" #(iron.send_line) {:desc "Send current line"})
              (| "<leader>rf" #(iron.send_file) {:desc "Send the whole file"})
              (| "<leader>rm" #(iron.send_mark) {:desc "Send marked"})])
      toggle-diags #(let [{: virtual_text
                           : virtual_lines} (vim.diagnostic.config)]
                      (vim.diagnostic.config
                        {:virtual_text (not virtual_text)
                         :virtual_lines (not virtual_lines)}))]
  (wk.add
   [[file lang goto term repl]
    (| "<leader><leader>" #(fzf :commands) {:desc "Command Palette"})
    (| "<leader>b" #(fzf :buffers) {:desc "buffers"})
    (| "<leader>d" toggle-diags {:desc "Draw Diagnostics"})
    (| "<leader>g" "<cmd>Neogit<cr>" {:desc "Neogit"})
    (| "<leader>w" "<c-w>" {:desc "window" :remap true})
    (| "<leader>W" #(wk.show {:keys "<c-w>" :loop true}) {:desc "window persist"})]))
