(import-macros {: dot} :macros)

(fn get-cap []
  (dot (require :blink.cmp)
       (get_lsp_capabilities
         (vim.lsp.protocol.make_client_capabilities))))

[;; Langservers
 {1 "neovim/nvim-lspconfig"
  :event ["BufReadPost" "BufNewFile"]
  :config
  #(let [lspconfig (require :lspconfig)
         capabilities (get-cap)]
     (fn setup-lsp [name tbl]
       ((. lspconfig name :setup) tbl))
     (setup-lsp "racket_langserver"
      {: capabilities
       :filetypes ["racket"]})
     (setup-lsp "denols"
      {: capabilities
       :root_dir (lspconfig.util.root_pattern "deno.json" "deno.jsonc")
       :single_file_support false})
     (setup-lsp "ruff"
      {:on_attach (fn [client bufnr]
                    (set client.server_capabilities.hoverProvider false))})
     (setup-lsp "pyright"
      {:settings {:python {:analysis {:ignore "*"}}}})
     (setup-lsp "tinymist"
      {: capabilities
       :single_file_support true})
     (each [_ srv (ipairs ["clangd" "ocamllsp" "hls" "pyright" "nil_ls" "rescriptls"])]
       (setup-lsp srv {: capabilities})))}
 {1 "pmizio/typescript-tools.nvim"
  :event ["BufReadPost" "BufNewFile"]
  :dependencies ["nvim-lua/plenary.nvim"
                 "neovim/nvim-lspconfig"]
  :opts #{:capabilities (get-cap)
          :root_dir (dot (require :lspconfig) util (root_pattern "package.json"))
          :single_file_support false
          :settings {:tsserver_max_memory 4096}}}
 "mrcjkb/rustaceanvim"
 {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  :config
  #(do
     (dot (require :lsp_lines) (setup))
     (vim.diagnostic.config {:virtual_lines false}))}
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
                :format (dot (require :iron.fts.common) bracketed_paste)}}
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
