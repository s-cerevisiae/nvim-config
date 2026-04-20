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
(vim.keymap.set ["n" "x"] "<leader>y"
  "\"+y"
  {:remap true
   :desc "y to clip"})
(vim.keymap.set ["n" "x"] "<leader>Y"
  "\"+Y"
  {:remap true
   :desc "Y to clip"})
(vim.keymap.set ["n" "x"] "<leader>p"
  "\"+p"
  {:remap true
   :desc "p from clip"})
(vim.keymap.set ["n" "x"] "<leader>P"
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
  #(dot (require :leap.remote) (action)))

;; nvim-surround
(do
  (fn map-surround [mode key value]
    (vim.keymap.set mode key (.. "<Plug>(nvim-surround-" value ")")))
  (doto "n"
    (map-surround "s" "normal")
    (map-surround "ss" "normal-cur")
    (map-surround "S" "normal-line")
    (map-surround "SS" "normal-cur-line")
    (map-surround "ds" "delete")
    (map-surround "cs" "change")
    (map-surround "cS" "change-line"))

  (doto "x"
    (map-surround "s" "visual")
    (map-surround "S" "visual-line")))

;; tree-sitter text objects
(let [select (autoload :nvim-treesitter-textobjects.select)
      mode ["x" "o"]]
  (fn map-ts [key sel]
    (vim.keymap.set mode key
      #(select.select_textobject sel "textobjects")
      {:desc sel}))
  (map-ts "af" "@function.outer")
  (map-ts "if" "@function.inner")
  (map-ts "ac" "@conditional.outer")
  (map-ts "ic" "@conditional.inner")
  (map-ts "aa" "@parameter.outer")
  (map-ts "ia" "@parameter.inner"))

(fn fzf [cmd opts] ((dot (require :fzf-lua) [cmd]) opts))

(fn map [key val desc opts]
  (let [opts (or opts {})
        mode (or opts.mode "n")]
    (set opts.mode nil)
    (set opts.desc desc)
    (vim.keymap.set mode key val opts)))

(local key-groups [])

(fn map-group [prefix desc & group]
  (table.insert key-groups {:mode "n" :keys prefix : desc})
  (each [_ m (ipairs group)]
    (set (. m 1) (.. prefix (. m 1)))
    (map (unpack m))))

(map-group "<leader>f" "file"
  ["f" #(fzf :files) "File Finder"]
  ["b" "<cmd>Oil<cr>" "File Browser"]
  ["g" #(fzf :live_grep) "File Grep"]
  ["t" "<cmd>Neotree toggle reveal=true position=current<cr>" "File Tree"])

(map-group "<leader>l" "lang"
  ["a" #(fzf :lsp_code_actions) "Code Actions" {:mode ["n" "x"]}]
  ["c" vim.lsp.codelens.run "Codelens"]
  ["d" #(fzf :diagnostics_document {:sort true}) "Local Diagnostics"]
  ["D" #(fzf :diagnostics_workspace {:sort true}) "Workspace Diagnostics"]
  ["f" #(dot (require :conform)
             (format {:lsp_fallback true
                      :stop_after_first true
                      :async true}))
       "Format Buffer"
       {:mode ["n" "x"]}]
  ["h" vim.lsp.buf.document_highlight "Document Highlight"]
  ["r" vim.lsp.buf.rename "Rename Symbol"]
  ["i" #(vim.lsp.inlay_hint.enable
          (not (vim.lsp.inlay_hint.is_enabled)))
       "Toggle Inlay Hint"])

(map-group "<leader>lg" "goto"
  ["i" vim.lsp.buf.implementation "Go to Implementation"]
  ["d" vim.lsp.buf.definition "Go to Definition"]
  ["D" vim.lsp.buf.declaration "Go to Declaration"]
  ["t" vim.lsp.buf.type_definition "Go to Type Definition"]
  ["r" vim.lsp.buf.references "Go to References"])

(let [toggle-term (fn [direction]
                    #(let [count vim.v.count]
                       (dot (require :toggleterm)
                            (toggle count nil nil direction
                                    (if (> count 1) (tostring count))))))]
  (map-group "<leader>t" "term"
    ["t" (toggle-term "float") "Toggle Floating Terminal"]
    ["l" (toggle-term "vertical") "Toggle → Terminal"]
    ["j" (toggle-term "horizontal") "Toggle ↓ Terminal"]
    ["s" "<cmd>TermSelect<cr>" "Select Terminal"]))

(let [iron (autoload :iron.core)
      send-visual #(do (iron.mark_visual)
                       (iron.send_mark))]
  (map-group "<leader>r" "repl"
    ["r" send-visual "Send visual selection" {:mode "x"}]
    ["r" #(iron.run_motion "send_motion") "Send motion" {:mode "n"}]
    ["t" "<cmd>IronRepl<cr>" "Toggle REPL"]
    ["l" #(iron.send_line) "Send current line"]
    ["f" #(iron.send_file) "Send the whole file"]
    ["m" #(iron.send_mark) "Send marked"]))

(let [dap (autoload :dap)]
  (map-group "<leader>d" "debug"
    ["d" #(dap.continue) "Run / Continue"]
    ["b" #(dap.toggle_breakpoint) "Toggle Breakpoint"]
    ["j" #(dap.step_over) "Step Over"]
    ["h" #(dap.step_into) "Step Into"]
    ["l" #(dap.step_out) "Step Out"]
    ["k" #(dap.step_back) "Step Back"]
    ["q" #(dap.terminate) "Quit Session"]
    ["w" "<cmd>DapViewWatch<cr>" "Watch Variable"]
    ["v" "<cmd>DapViewToggle<cr>" "Toggle Debug View"]))

(let [toggle-diags #(let [{: virtual_text
                           : virtual_lines} (vim.diagnostic.config)]
                      (vim.diagnostic.config
                        {:virtual_text (not virtual_text)
                         :virtual_lines (not virtual_lines)}))
      open-file #(-> (vim.fn.expand "<cfile>")
                     (vim.fn.findfile)
                     (vim.ui.open))
      open-file-visual #(-> (vim.fn.getregion (vim.fn.getpos "v")
                                              (vim.fn.getpos ".")
                                              {:type (vim.fn.mode)})
                            (. 1)
                            (vim.fn.findfile)
                            (vim.ui.open))
      mc (require :multicursor-nvim)]
  (map-group "<leader>" "menu"
    ["<leader>" #(fzf :commands) "Command Palette"]
    ["b" #(fzf :buffers) "Buffers"]
    ["o" open-file "Open file in system"]
    ["o" open-file-visual "Open file in system" {:mode "x"}]
    ["u" #(fzf :undotree) "Undo Tree"]
    ["D" toggle-diags "Toggle Diagnostics Style"]
    ["g" "<cmd>Neogit<cr>" "Neogit"]
    ["w" "<c-w>" "window" {:remap true}]
    ["s" "<Plug>(leap-anywhere)" "Leap"]
    ["c" mc.toggleCursor "Multiple Cursors"]
    ["c" mc.matchCursors "Match Cursors" {:mode "x"}])

  (mc.addKeymapLayer
   (fn [layer]
     (layer "n" "<cr>" #(when (not (mc.cursorsEnabled))
                          (mc.enableCursors)))
     (layer "n" "<c-c>" #(mc.clearCursors)))))

(macro triggers [modes keys & rest]
  (each [_ m (ipairs modes)]
    (each [_ k (ipairs keys)]
      (table.insert rest {:mode m :keys k})))
  rest)

(macro submode [modes prefix keys]
  (local clues [])
  (each [_ m (ipairs modes)]
    (each [_ k (ipairs keys)]
      (table.insert clues {:mode m :keys (.. prefix k) :postkeys prefix})))
  clues)

(let [{: setup : gen_clues} (require :mini.clue)]
  (setup {:triggers (triggers ["n" "x"]
                      ["<leader>" "g" "`" "'" "\"" "z"]
                      {:mode "n" :keys "<c-w>"}
                      {:mode "n" :keys "]"}
                      {:mode "n" :keys "["}
                      {:mode "i" :keys "<c-r>"}
                      {:mode "c" :keys "<c-r>"})
          :clues [(gen_clues.g)
                  (gen_clues.z)
                  (gen_clues.marks)
                  (gen_clues.registers)
                  (gen_clues.windows {:submode_resize true})
                  (gen_clues.square_brackets)
                  (submode ["n"] "<leader>d"
                    ["h" "j" "k" "l"])
                  key-groups]
          :window {:config {:width "auto"
                            :border "none"}}}))
