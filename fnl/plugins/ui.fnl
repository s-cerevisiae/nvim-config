(import-macros {: dot} :macros)

[(let [mode-short {1 "mode" :fmt #($:sub 1 1)}

       tabs {1 "tabs"
             :show_modified_status false}

       line-short {:lualine_a [mode-short]
                   :lualine_b [tabs]
                   :lualine_c [:diagnostics]
                   :lualine_z [:location]}

       line-full {:lualine_a [:mode]
                  :lualine_b [tabs]
                  :lualine_c [:branch :diff :diagnostics]
                  :lualine_x [:encoding :fileformat :filetype]
                  :lualine_y [:progress]
                  :lualine_z [:location]}

       sections (if (< vim.o.columns 60)
                    line-short
                    line-full)]

   {1 "nvim-lualine/lualine.nvim"
    :dependencies ["nvim-tree/nvim-web-devicons"]
    :opts
    {:options {:globalstatus true
               :theme "zenwritten"}
     : sections}})
 {1 "b0o/incline.nvim"
  :opts {:hide {:cursorline true}
         :window {:margin {:vertical {:top 0 :bottom 0}
                           :horizontal {:left 0 :right 0}}
                  :padding {:left 1 :right 1}}
                  ; :padding_char ""
         :render (fn [props]
                   (let [filename (-> props.buf
                                      (vim.api.nvim_buf_get_name)
                                      (vim.fn.fnamemodify ":~:."))
                         indicator (if (. vim.bo props.buf :modified) " ●"
                                       (. vim.bo props.buf :readonly) " 󰌾"
                                       "")]
                     [filename indicator]))}}

 {1 "folke/which-key.nvim"
  :event "VeryLazy"
  :version "3"
  :opts {:delay 200}}
 {1 "stevearc/dressing.nvim"
  :dependencies ["ibhagwan/fzf-lua"]}
 {1 "j-hui/fidget.nvim"
  :opts {:notification {:override_vim_notify true}}}
 "kevinhwang91/nvim-bqf"]
