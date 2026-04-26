(import-macros {: dot} :macros)
(local {: augroup : autocmd} (require :utils))

(vim.cmd.colorscheme :zenupright)

(dot (require :mini.icons) (setup {}))
(MiniIcons.mock_nvim_web_devicons)

(dot (require :mini.indentscope) (setup {}))

(let [line (require :mini.statusline)]
  (fn content []
    (let [(mode mode_hl) (line.section_mode {:trunc_width 80})
          tabs (let [cur (vim.api.nvim_get_current_tabpage)
                     prev (vim.fn.tabpagenr "#")]
                 (icollect [n id (ipairs (vim.api.nvim_list_tabpages))]
                   (if (= cur id) "󰨐"
                       (= prev n) "󱓜"
                       "󰧟")))
          git (line.section_git {:trunc_width 40})
          diff vim.b.gitsigns_status
          diags (line.section_diagnostics {:trunc_width 40 :icon ""
                                           :signs {:ERROR "󰅘 " :WARN "󰀪 " :INFO "󰋽 " :HINT "󰌶 "}})
          search (line.section_searchcount {:trunc_width 40})
          record (let [reg (vim.fn.reg_recording)]
                   (if (~= reg "")
                       (.. "󰋱 " reg)))
          file (line.section_fileinfo {:trunc_width 80})
          loc "%02l│%02v"]
      (line.combine_groups [{:hl mode_hl :strings (vim.list_extend [mode] tabs)}
                            "%T"
                            {:hl "StatusLine" :strings [git]}
                            "%<"
                            {:hl "StatusLineNC" :strings [diff diags]}
                            "%="
                            {:strings [search record]}
                            {:hl "StatusLine" :strings [file]}
                            {:hl mode_hl :strings [loc]}])))
  (line.setup {:content {:active content}}))

(dot (require :incline)
     (setup {:hide {:cursorline true}
             :window {:margin {:vertical 0 :horizontal 0}}
             :render (fn [props]
                       (let [filename (-> props.buf
                                          (vim.api.nvim_buf_get_name)
                                          (vim.fn.fnamemodify ":~:."))
                             indicator (if (. vim.bo props.buf :modified) "󰏫 "
                                           (. vim.bo props.buf :readonly) "󰏯 "
                                           "")]
                         [indicator filename]))}))

(let [fzf (require :fzf-lua)
      opts {:fzf_colors true
            :winopts #(let [small (< vim.o.lines 30)]
                        {:fullscreen small
                         :preview {:wrap "wrap"
                                   :hidden (if small "hidden" "nohidden")}})}]
  (fzf.setup opts)
  (fzf.register_ui_select))
