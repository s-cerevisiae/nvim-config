(import-macros {: require.} :macros)
(local {: augroup : autocmd!} (require :utils))

(fn set-options [options]
  (each [opt val (pairs options)]
    (tset vim.o opt val)))

(set-options
 {;; Number column settings
  :number true
  :relativenumber true
  :numberwidth 3
  :signcolumn "number"

  :cursorline true

  ;; Consistent tabstop & indentation
  :tabstop 4
  :shiftwidth 4
  :expandtab true

  ;; True colors
  :termguicolors true

  :mouse "a"

  :undofile true

  ;; Use smartcase.
  ;; !!Also works for nvim-cmp!!
  :ignorecase true
  :smartcase true

  :complete ""

  :updatetime 300

  ;; Show other types of whitespaces
  :list true
  :listchars "tab:>-,trail:×,nbsp:+"

  ;; Disable tabline
  :showtabline 0

  ;; Disable "--INSERT--" and alike
  :showmode false

  ;; Limit pop-up menu (completion) height
  :pumheight 10
  :splitright true
  :splitbelow true

  ;; Enable ignores for ripgrep
  :grepprg "rg --vimgrep --hidden"

  ;; Compatible with nushell and powershell,
  ;; does not work with cmd.exe
  :shellxquote ""
  :shellcmdflag "-c"

  ;; Project local config files
  :exrc true})

(fn set-scrolloff []
  (let [width (vim.api.nvim_win_get_width 0)
        height (vim.api.nvim_win_get_height 0)]
    (set vim.wo.sidescrolloff (quotient width 10))
    (set vim.wo.scrolloff (quotient height 5))))

(doto (augroup "SetScrollOff")
  (autocmd! ["BufEnter" "WinEnter" "VimResized"] "*" set-scrolloff))
