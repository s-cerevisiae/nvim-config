-- [nfnl] Compiled from fnl/plugins/completion.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local cmp = require("cmp")
  local function _2_(_2410)
    return vim.snippet.expand(_2410.body)
  end
  local function _3_(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    else
      return fallback()
    end
  end
  local function _5_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    else
      return fallback()
    end
  end
  local _7_
  do
    local c = require("cmp.config.compare")
    _7_ = {c.sort_text, c.offset, c.exact, c.score, c.recently_used, c.kind, c.length, c.order}
  end
  cmp.setup({preselect = cmp.PreselectMode.None, snippet = {expand = _2_}, mapping = {["<c-d>"] = cmp.mapping.scroll_docs(-4), ["<c-f>"] = cmp.mapping.scroll_docs(4), ["<c-space>"] = cmp.mapping.complete(), ["<c-e>"] = cmp.mapping.close(), ["<cr>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}), ["<tab>"] = cmp.mapping(_3_, {"i", "s"}), ["<s-tab>"] = cmp.mapping(_5_, {"i", "s"})}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}}), sorting = {comparators = _7_}})
  return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})
end
return {{"hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-path"}, event = {"InsertEnter", "CmdlineEnter"}, config = _1_}}
