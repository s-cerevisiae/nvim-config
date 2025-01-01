(import-macros {: dot} :macros)

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
  {:remap true})
(vim.keymap.set ["n" "v"] "<leader>Y"
  "\"+Y"
  {:remap true})
(vim.keymap.set ["n" "v"] "<leader>p"
  "\"+p"
  {:remap true})
(vim.keymap.set ["n" "v"] "<leader>P"
  "\"+P"
  {:remap true})

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

(fn fzf [cmd]
  (local small (< vim.o.lines 30))
  ((-> (require :fzf-lua) (. cmd))
   {:fzf_colors true
    :winopts {:fullscreen small
              :preview {:wrap "wrap"
                        :hidden (if small "hidden" "nohidden")}}}))

(let [wk (require :which-key)
      file {:name "file"
            "f" [#(fzf :files) "Find file"]
            "t" ["<cmd>Neotree toggle reveal=true position=current<cr>" "Toggle NeoTree"]
            "b" ["<cmd>Oil<cr>" "Oil.nvim file browser"]}
      goto {:name "goto"
            "i" [vim.lsp.buf.implementation "Go to implementation"]
            "d" [vim.lsp.buf.definition "Go to definition"]
            "D" [vim.lsp.buf.declaration "Go to declaration"]
            "t" [vim.lsp.buf.type_definition "Go to type definition"]
            "r" [vim.lsp.buf.references "Go to references"]}
      lang {:name "lang"
            "a" [#(fzf :lsp_code_actions) "Code actions"]
            "d" [#(fzf :diagnostics_workspace) "Show diagnostics"]
            "f" [#(dot (require :conform)
                       (format {:lsp_fallback true
                                :stop_after_first true
                                :async true}))
                 "Format buffer"]
            "h" [#(vim.lsp.buf.document_highlight) "Document highlight"]
            "r" [vim.lsp.buf.rename  "Rename symbol"]
            "i" [#(vim.lsp.inlay_hint.enable
                    (not (vim.lsp.inlay_hint.is_enabled)))
                 "Toggle inlay hint"]
            "g" goto}
      term {:name "term"
            "l" ["<cmd>ToggleTerm direction=vertical<cr>" "Toggle → terminal"]
            "j" ["<cmd>ToggleTerm direction=horizontal<cr>" "Toggle ↓ terminal"]
            "t" ["<cmd>ToggleTerm direction=float<cr>" "Toggle floating terminal"]
            "s" ["<cmd>TermSelect<cr>" "Select term"]}
      repl (let [iron (autoload :iron.core)
                 toggle-repl "<cmd>IronRepl<cr>"
                 send-visual #(do (iron.mark_visual)
                                  (iron.send_mark))]
             {:name "repl"
              "r" [toggle-repl "Toggle REPL"]
              "v" [send-visual "Send visual selection"]
              "s" [#(iron.run_motion "send_motion") "Send motion"]
              "l" [#(iron.send_line) "Send current line"]
              "f" [#(iron.send_file) "Send the whole file"]
              "m" [#(iron.send_mark) "Send marked"]})
      toggle-diags #(let [{: virtual_text
                           : virtual_lines} (vim.diagnostic.config)]
                      (vim.diagnostic.config
                        {:virtual_text (not virtual_text)
                         :virtual_lines (not virtual_lines)}))]
  (wk.register
   {"<leader>" [#(fzf :commands) "Find command"]
    "b" [#(fzf :buffers) "buffers"]
    "d" [toggle-diags "Toggle linewise diagnostics"]
    "f" file
    "l" lang
    "g" ["<cmd>Neogit<cr>" "Neogit"]
    "t" term
    "r" repl
    "w" {1 "<c-w>" 2 "Window commands" :noremap false}}
   {:mode ["n" "v"]
    :prefix "<leader>"}))
