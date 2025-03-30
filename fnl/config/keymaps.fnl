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

(fn fzf [cmd opts] ((-> (require :fzf-lua) (. cmd)) opts))

(fn map [key val desc opts]
  (let [opts (or opts {})
        mode (or opts.mode "n")]
    (set opts.mode nil)
    (set opts.desc desc)
    (vim.keymap.set mode key val opts)))

(fn map-group [prefix desc & group]
  (map prefix "" desc)
  (each [_ m (ipairs group)]
    (set (. m 1) (.. prefix (. m 1)))
    (map (unpack m))))

(map-group "<leader>f" "file"
  ["f" #(fzf :files) "File Finder"]
  ["b" "<cmd>Oil<cr>" "File Browser"]
  ["t" "<cmd>Neotree toggle reveal=true position=current<cr>" "File Tree"])

(map-group "<leader>l" "lang"
  ["a" #(fzf :lsp_code_actions) "Code Actions" {:mode ["n" "v"]}]
  ["d" #(fzf :diagnostics_document {:sort true}) "Local Diagnostics"]
  ["D" #(fzf :diagnostics_workspace {:sort true}) "Workspace Diagnostics"]
  ["f" #(dot (require :conform)
             (format {:lsp_fallback true
                      :stop_after_first true
                      :async true}))
       "Format buffer"
       {:mode ["n" "v"]}]
  ["h" vim.lsp.buf.document_highlight "Document Highlight"]
  ["r" vim.lsp.buf.rename "Rename Symbol"]
  ["i" #(vim.lsp.inlay_hint.enable
          (not (vim.lsp.inlay_hint.is_enabled)))
       "Toggle inlay hint"])

(map-group "<leader>lg" "goto"
  ["i" vim.lsp.buf.implementation "Go to Implementation"]
  ["d" vim.lsp.buf.definition "Go to Definition"]
  ["D" vim.lsp.buf.declaration "Go to Declaration"]
  ["t" vim.lsp.buf.type_definition "Go to Type Definition"]
  ["r" vim.lsp.buf.references "Go to References"])

(map-group "<leader>t" "term"
  ["t" "<cmd>ToggleTerm direction=float<cr>" "Toggle Floating Terminal"]
  ["l" "<cmd>ToggleTerm direction=vertical<cr>" "Toggle → Terminal"]
  ["j" "<cmd>ToggleTerm direction=horizontal<cr>" "Toggle ↓ Terminal"]
  ["s" "<cmd>TermSelect<cr>" "Select Terminal"])

(let [iron (autoload :iron.core)
      send-visual #(do (iron.mark_visual)
                       (iron.send_mark))]
  (map-group "<leader>r" "repl"
    ["r" send-visual "Send visual selection" {:mode "v"}]
    ["r" #(iron.run_motion "send_motion") "Send motion" {:mode "n"}]
    ["t" "<cmd>IronRepl<cr>" "Toggle REPL"]
    ["l" #(iron.send_line) "Send current line"]
    ["f" #(iron.send_file) "Send the whole file"]
    ["m" #(iron.send_mark) "Send marked"]))

(let [toggle-diags #(let [{: virtual_text
                           : virtual_lines} (vim.diagnostic.config)]
                      (vim.diagnostic.config
                        {:virtual_text (not virtual_text)
                         :virtual_lines (not virtual_lines)}))
      mc (require :multicursor-nvim)]
  (map-group "<leader>" "leader"
    ["<leader>" #(fzf :commands) "Command Palette"]
    ["b" #(fzf :buffers) "Buffers"]
    ["d" toggle-diags "Toggle Diagnostics Style"]
    ["g" "<cmd>Neogit<cr>" "Neogit"]
    ["w" "<c-w>" "window" {:remap true}]
    ["W" #(dot (require :which-key) (show {:keys "<c-w>" :loop true})) "window persist"]
    ["c" mc.toggleCursor "Multiple Cursors"]
    ["c/" mc.matchCursors "Match Cursors" {:mode "v"}])

  (mc.addKeymapLayer
   (fn [layer]
     (layer "n" "<esc>" #(if (not (mc.cursorsEnabled))
                             (mc.enableCursors)
                             (mc.clearCursors))))))
