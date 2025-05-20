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
       (vim.lsp.config "pyright"
         {:settings {:python {:analysis {:ignore "*"}}}})
       (vim.lsp.enable
         ["racket_langserver"
          ;; use workspace_required in the future
          "denols"
          ;; ruff is no longer a hover provider
          "ruff"
          "pyright"
          ;; single file support is enabled by default
          "tinymist"
          "clangd"
          "ocamllsp"
          "hls"
          "nil_ls"
          "rescriptls"]))}
 {1 "pmizio/typescript-tools.nvim"
  :event ["BufReadPost" "BufNewFile"]
  :dependencies ["nvim-lua/plenary.nvim"
                 "neovim/nvim-lspconfig"]
  :opts #{:capabilities (get-cap)
          :root_dir (dot (require :lspconfig) util (root_pattern "package.json"))
          :single_file_support false
          :settings {:tsserver_max_memory 4096}}}
 "mrcjkb/rustaceanvim"
 "mfussenegger/nvim-jdtls"

 ;; Language plugins
 "wlangstroth/vim-racket"
 "LnL7/vim-nix"
 "bakpakin/fennel.vim"
 "kaarmu/typst.vim"
 {1 "Vigemus/iron.nvim"
  :cmd :IronRepl
  :config
  #((dot (require :iron.core) setup)
    {:config
     {:repl_definition
      {:scheme {:command #(or vim.g.iron#cmd#scheme ["guile"])}
       :python {:command #(or vim.g.iron#cmd#python ["python"])
                :format (dot (require :iron.fts.common) bracketed_paste_python)}}
      :repl_open_cmd (dot (require :iron.view) (split "25%"))}})}
 {1 "mickael-menu/zk-nvim"
  :config
  #(dot (require :zk)
        (setup {:picker "fzf_lua"}))}

 ;; Formatter
 {1 "stevearc/conform.nvim"
  :opts (let [web-fts ["javascript" "javascriptreact"
                       "typescript" "typescriptreact"
                       "json"]
              ;; Not supported by biome yet
              web-extra-fts ["css" "scss" "html" "jsonc"]]
          {:formatters_by_ft
           (vim.tbl_extend "keep"
             (collect [_ ft (pairs web-fts)]
               ft ["biome" "prettier"])
             (collect [_ ft (pairs web-extra-fts)]
               ft ["prettier"])
             {:python ["ruff_format"]})})}]
