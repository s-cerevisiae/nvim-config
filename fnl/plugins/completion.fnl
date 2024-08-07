[{1 "hrsh7th/nvim-cmp"
  :dependencies ["hrsh7th/cmp-buffer"
                 "hrsh7th/cmp-nvim-lsp"
                 "hrsh7th/cmp-cmdline"
                 "hrsh7th/cmp-path"]
  :event ["InsertEnter" "CmdlineEnter"]
  :config
  #(let [cmp (require :cmp)]
     (cmp.setup
      {:preselect cmp.PreselectMode.None
       :snippet
       {:expand #(vim.snippet.expand $.body)}
       :mapping
       {"<c-d>" (cmp.mapping.scroll_docs -4)
        "<c-f>" (cmp.mapping.scroll_docs 4)
        "<c-space>" (cmp.mapping.complete)
        "<c-e>" (cmp.mapping.close)
        "<cr>" (cmp.mapping.confirm
                 {:behavior cmp.ConfirmBehavior.Replace
                  :select false})
        "<tab>" (cmp.mapping
                  (fn [fallback]
                    (if (cmp.visible)
                        (cmp.select_next_item)
                        (fallback)))
                  ["i" "s"])
        "<s-tab>" (cmp.mapping
                    (fn [fallback]
                      (if (cmp.visible)
                          (cmp.select_prev_item)
                          (fallback)))
                    ["i" "s"])}
       :sources (cmp.config.sources
                  [{:name "nvim_lsp"}
                   {:name "luasnip"}
                   {:name "buffer"}])
       :sorting {:comparators
                 (let [c (require :cmp.config.compare)]
                   [c.sort_text
                    c.offset
                    c.exact
                    c.score
                    c.recently_used
                    c.kind
                    c.length
                    c.order])}})
     (cmp.setup.cmdline ":"
      {:mapping (cmp.mapping.preset.cmdline)
       :sources (cmp.config.sources
                  [{:name "path"}]
                  [{:name "cmdline"}])}))}]
