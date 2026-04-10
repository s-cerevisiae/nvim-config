(local {: autocmd : augroup} (require :utils))

(fn github [repo]
  (.. "https://github.com/" repo))

(local hooks {:install {} :update {} :delete {}})

(fn hook! [kinds name hook]
  (each [_ kind (ipairs kinds)]
    (set (. hooks kind name) hook)))

(autocmd (augroup "PackHook")
  "PackChanged" "*"
  (fn [ev]
    (let [{:spec {: name} : active : kind : path} ev.data
          maybe-hook (. hooks kind name)]
      (when maybe-hook
        (when (not active)
          (vim.cmd.packadd name))
        (vim.notify (.. "Running " kind " hook for package " name)
                    vim.log.levels.INFO)
        (maybe-hook path)))
    nil))

(set _G.Pack
  {:run_hook (fn [name kind]
               (let [[{: active : path}] (vim.pack.get [name] {:info false})
                     maybe-hook (. hooks kind name)]
                 (if maybe-hook
                     (do (when (not active)
                           (vim.cmd.packadd name))
                         (maybe-hook path))
                     (vim.notify (.. "No " kind " hook available for plugin " name)))))
   :get_hooks #hooks})

(vim.pack.add
  [;; Colorscheme
   (do (set vim.g.bones_compat 1)
     (github "mcchrish/zenbones.nvim"))
   ;; Fennel compiler
   (github "Olical/nfnl")

   ;; Common dependencies
   (github "nvim-lua/plenary.nvim")
   (github "nvim-tree/nvim-web-devicons")
   (github "MunifTanjim/nui.nvim")

   ;; Mini.nvim
   (github "nvim-mini/mini.nvim")

   ;; UI
   (github "b0o/incline.nvim")
   (github "kevinhwang91/nvim-bqf")

   ;; Picker
   (github "ibhagwan/fzf-lua")

   ;; Terminal
   (github "akinsho/toggleterm.nvim")

   ;; File
   {:src (github "nvim-neo-tree/neo-tree.nvim")
    :version "v3.x"}
   (github "stevearc/oil.nvim")

   ;; Completion
   {:src (github "saghen/blink.cmp")
    :version (vim.version.range "^1")}

   ;; Git
   (github "lewis6991/gitsigns.nvim")
   (github "sindrets/diffview.nvim")
   (github "NeogitOrg/neogit")

   ;; Editing
   (github "folke/flash.nvim")
   (do (set vim.g.nvim_surround_no_mappings true)
     (github "kylechui/nvim-surround"))
   (github "jake-stewart/multicursor.nvim")
   (github "hrsh7th/nvim-insx")
   (do (hook! [:install :update] "parinfer-rust"
         #(vim.system ["cargo" "build" "--release"]
                      {:cwd $ :text true}
                      (fn [{: stdout : stderr}]
                        (print stdout)
                        (print stderr))))
     (github "s-cerevisiae/parinfer-rust"))
   (github "tpope/vim-repeat")

   ;; Language
   ;;; LSP
   (github "neovim/nvim-lspconfig")
   (github "pmizio/typescript-tools.nvim")
   (github "mfussenegger/nvim-jdtls")
   (github "mrcjkb/rustaceanvim")
   (github "mickael-menu/zk-nvim")
   ;;; Syntax
   (github "wlangstroth/vim-racket")
   (github "LnL7/vim-nix")
   (github "bakpakin/fennel.vim")
   (github "kaarmu/typst.vim")
   ;;; REPL
   (github "Vigemus/iron.nvim")
   ;;; Render
   (github "MeanderingProgrammer/render-markdown.nvim")
   ;;; Formatter
   (github "stevearc/conform.nvim")

   ;; Tree-sitter
   (do (hook! [:update] "nvim-treesitter"
         #(vim.cmd.TSUpdate))
     (github "nvim-treesitter/nvim-treesitter"))
   (github "nvim-treesitter/nvim-treesitter-textobjects")

   ;; Debugger
   (github "mfussenegger/nvim-dap")
   (github "igorlfs/nvim-dap-view")])
