(import-macros {: dot} :macros)

(local {: augroup : autocmd} (require :utils))

(vim.lsp.config "racket_langserver"
  {:filetypes ["racket"]})
(vim.lsp.config "denols"
  {:root_markers ["deno.json" "deno.jsonc"]})
(vim.lsp.config "basedpyright"
  {:settings {:python {:analysis {:ignore "*"}}}})
(vim.lsp.enable
  ["racket_langserver"
   ;; use workspace_required in the future
   "denols"
   "biome"
   ;; ruff is no longer a hover provider
   "ruff"
   "pyrefly"
   "jdtls"
   ;; single file support is enabled by default
   "tinymist"
   "clangd"
   "ocamllsp"
   "hls"
   "nil_ls"
   "rescriptls"])

(dot (require :typescript-tools)
     (setup {:single_file_support false
             :settings {:tsserver_max_memory 4096}}))

(dot (require :iron.core)
     (setup {:config
             {:repl_definition
              {:scheme {:command #(or vim.g.iron#cmd#scheme ["guile"])}
               :python {:command #(or vim.g.iron#cmd#python ["python"])
                        :format (dot (require :iron.fts.common) bracketed_paste)}
               :fennel {:command ["nvim" "-l" (.. (vim.fn.stdpath "data") "/lazy/nfnl/script/fennel.lua")]}}
              :repl_open_cmd (dot (require :iron.view) (split "25%"))}}))

(dot (require :zk)
     (setup {:picker "fzf_lua"}))

(let [web-fts ["javascript" "javascriptreact"
               "typescript" "typescriptreact"
               "css" "html" "json" "jsonc"]
      ;; Not supported by biome yet
      web-extra-fts ["scss"]]
  (dot (require :conform)
       (setup {:formatters_by_ft
               (vim.tbl_extend "keep"
                 (collect [_ ft (pairs web-fts)]
                   ft ["biome" "prettier"])
                 (collect [_ ft (pairs web-extra-fts)]
                   ft ["prettier"])
                 {:python ["ruff_format"]})})))

(let [ts (require :nvim-treesitter)
      always-install ["vimdoc" "markdown" "c" "lua"
                      "rust" "toml" "fennel" "python"]]
  (ts.install always-install))

(autocmd (augroup "NvimTreesitterCfg")
  "FileType" "*"
  #(if (pcall vim.treesitter.start)
       (set vim.wo.foldexpr "v:lua.vim.treesitter.foldexpr()")))

;; Aggregated ftplugin configs
(doto (augroup "FileTypeMisc")
  (autocmd "Filetype"
            ["javascript" "typescript" "css"
             "javascriptreact" "typescriptreact"
             "ocaml" "prolog" "scheme" "lua"]
    #(do (set vim.bo.tabstop 2)
         (set vim.bo.shiftwidth 2)))
  (autocmd "Filetype" "rust"
    #(do (vim.keymap.set "n" "K"
           #(vim.cmd.RustLsp "hover" "actions")
           {:silent true :buffer 0})
         nil)))

;; Evaluate "*.data.clj" and write the output to file
(fn write-data-clj [buf]
  (let [script-file (vim.api.nvim_buf_get_name buf)
        data-file (string.sub script-file 1 -10)]
    (vim.system ["bb" "-f" script-file] {}
      (fn [{: stdout}]
        (doto (io.open data-file "w")
              (: :write stdout)
              (: :close))))))

(doto (augroup "DataClj")
  (autocmd "BufWritePost" "*.data.clj"
    (fn [{: buf}]
      (write-data-clj buf)
      nil)))
