(import-macros {: dot} :macros)

(fn get-cap []
  (dot (require :blink.cmp)
       (get_lsp_capabilities
         (vim.lsp.protocol.make_client_capabilities))))

[;; Langservers
 {1 "neovim/nvim-lspconfig"
  :config
  #(do (vim.lsp.config "racket_langserver"
         {:filetypes ["racket"]})
       (vim.lsp.config "denols"
         {:root_markers ["deno.json" "deno.jsonc"]})
       (vim.lsp.config "basedpyright"
         {:settings {:python {:analysis {:ignore "*"}}}})
       (vim.lsp.enable
         ["racket_langserver"
          "rust_analyzer"
          ;; use workspace_required in the future
          "denols"
          ;; ruff is no longer a hover provider
          "ruff"
          "jdtls"
          "basedpyright"
          ;; single file support is enabled by default
          "tinymist"
          "clangd"
          "ocamllsp"
          "hls"
          "nil_ls"
          "rescriptls"]))}
 {1 "pmizio/typescript-tools.nvim"
  :event "VeryLazy"
  :dependencies ["nvim-lua/plenary.nvim"
                 "neovim/nvim-lspconfig"]
  :opts #{:capabilities (get-cap)
          :root_dir (dot (require :lspconfig) util (root_pattern "package.json"))
          :single_file_support false
          :settings {:tsserver_max_memory 4096}}}
 "mfussenegger/nvim-jdtls"

 ;; Language plugins
 "wlangstroth/vim-racket"
 "LnL7/vim-nix"
 "bakpakin/fennel.vim"
 "kaarmu/typst.vim"
 {1 "Vigemus/iron.nvim"
  :cmd :IronRepl
  :main "iron.core"
  :opts #{:config
          {:repl_definition
           {:scheme {:command #(or vim.g.iron#cmd#scheme ["guile"])}
            :python {:command #(or vim.g.iron#cmd#python ["python"])
                     :format (dot (require :iron.fts.common) bracketed_paste)}
            :fennel {:command ["nvim" "-l" (.. (vim.fn.stdpath "data") "/lazy/nfnl/script/fennel.lua")]}}
           :repl_open_cmd (dot (require :iron.view) (split "25%"))}}}
 {1 "mickael-menu/zk-nvim"
  :main "zk"
  :opts {:picker "fzf_lua"}}
 {1 "MeanderingProgrammer/render-markdown.nvim"
  :cmd :RenderMarkdown
  :config true}

 ;; Formatter
 {1 "stevearc/conform.nvim"
  :opts (let [web-fts ["javascript" "javascriptreact"
                       "typescript" "typescriptreact"
                       "css" "html" "json" "jsonc"]
              ;; Not supported by biome yet
              web-extra-fts ["scss"]]
          {:formatters_by_ft
           (vim.tbl_extend "keep"
             (collect [_ ft (pairs web-fts)]
               ft ["biome" "prettier"])
             (collect [_ ft (pairs web-extra-fts)]
               ft ["prettier"])
             {:python ["ruff_format"]})})}]
