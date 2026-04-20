(import-macros {: dot} :macros)
(local {: augroup : autocmd} (require :utils))

(fn set-options [options]
  (each [opt val (pairs options)]
    (tset vim.o opt val)))

(set-options
 {;; Number column settings
  :number true
  :relativenumber true
  :numberwidth 3
  :signcolumn "number"

  :cmdheight 0

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
  :ignorecase true
  :smartcase true

  :updatetime 300

  ;; Show other types of whitespaces
  :list true
  :listchars "tab:>-,trail:×,nbsp:+"

  ;; Disable tabline
  :showtabline 0
  ;; Global statusline
  :laststatus 3

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

(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")

(fn set-scrolloff [info]
  (when (not (vim.startswith info.file "term://"))
    (let [width (vim.api.nvim_win_get_width 0)
          height (vim.api.nvim_win_get_height 0)]
      (set vim.wo.sidescrolloff (quotient width 10))
      (set vim.wo.scrolloff (quotient height 5)))))

(doto (augroup "SetScrollOff")
  (autocmd ["BufEnter" "WinEnter" "VimResized"] "*" set-scrolloff))
