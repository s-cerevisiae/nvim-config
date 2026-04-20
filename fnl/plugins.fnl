(local hook! PackHook.create)

(fn github [repo]
  (.. "https://github.com/" repo))

(fn codeberg [repo]
  (.. "https://codeberg.org/" repo))

(vim.cmd.packadd :nvim.difftool)

(vim.pack.add
  [;; Colorscheme
   (do (set vim.g.bones_compat 1)
     (github "mcchrish/zenbones.nvim"))
   ;; Fennel compiler
   (github "Olical/nfnl")

   ;; Common dependencies
   (github "nvim-lua/plenary.nvim")
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
   (codeberg "andyg/leap.nvim")
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
