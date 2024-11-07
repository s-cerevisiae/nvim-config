(import-macros {: require.} :macros)

(fn get-cap []
  (vim.tbl_deep_extend "force"
    (vim.lsp.protocol.make_client_capabilities)
    ((require. :cmp_nvim_lsp :default_capabilities))))

[;; Langservers
 {1 "neovim/nvim-lspconfig"
  :dependencies ["hrsh7th/cmp-nvim-lsp"]
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
     (setup-lsp "ruff_lsp"
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
  :dependencies ["nvim-lua/plenary.nvim"
                 "neovim/nvim-lspconfig"]
  :opts #{:capabilities (get-cap)
          :root_dir ((. (require :lspconfig) :util :root_pattern) "package.json")
          :single_file_support false
          :settings {:tsserver_max_memory 4096}}}
 "mrcjkb/rustaceanvim"
 {1 "j-hui/fidget.nvim"
  :tag "legacy"
  :config true}
 {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  :config
  #(do
     ((require. :lsp_lines :setup))
     (vim.diagnostic.config {:virtual_lines false}))}

 ;; Language plugins
 "wlangstroth/vim-racket"
 "LnL7/vim-nix"
 "bakpakin/fennel.vim"
 "kaarmu/typst.vim"
 {1 "Vigemus/iron.nvim"
  :cmd :IronRepl
  :config
  #((. (require :iron.core) :setup)
    {:config
     {:repl_definition
      {:scheme {:command #(or vim.g.iron#cmd#scheme ["guile"])}
       :python {:command #(or vim.g.iron#cmd#python ["python"])}}
      :repl_open_cmd ((. (require :iron.view) :split) "25%")}})}
 {1 "mickael-menu/zk-nvim"
  :config
  #((. (require :zk) :setup)
    {:picker "telescope"})}

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
