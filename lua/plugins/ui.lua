-- [nfnl] Compiled from fnl/plugins/ui.fnl by https://github.com/Olical/nfnl, do not edit.
local _1_
do
  local mode_short
  local function _2_(_241)
    return _241:sub(1, 1)
  end
  mode_short = {"mode", fmt = _2_}
  local tabs = {"tabs", show_modified_status = false}
  local line_short = {lualine_a = {mode_short}, lualine_b = {tabs}, lualine_c = {"diagnostics"}, lualine_z = {"location"}}
  local line_full = {lualine_a = {"mode"}, lualine_b = {tabs}, lualine_c = {"branch", "diff", "diagnostics"}, lualine_x = {"encoding", "fileformat", "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}
  local sections
  if (vim.o.columns < 60) then
    sections = line_short
  else
    sections = line_full
  end
  _1_ = {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, config = {options = {globalstatus = true, theme = "zenwritten"}, sections = sections}}
end
local function _4_(props)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")
  local indicator
  if vim.bo[props.buf].modified then
    indicator = " \226\151\143"
  elseif vim.bo[props.buf].readonly then
    indicator = " \243\176\140\190"
  else
    indicator = ""
  end
  return {filename, indicator}
end
local function _6_()
  return (require("dressing")).setup({select = {telescope = {layout_config = (require("telescope.config")).values.layout_config}}})
end
return {_1_, {"b0o/incline.nvim", config = {hide = {cursorline = true}, window = {margin = {vertical = {top = 0, bottom = 0}, horizontal = {left = 0, right = 0}}, padding = {left = 1, right = 1}}, render = _4_}}, {"stevearc/dressing.nvim", dependencies = {"nvim-telescope/telescope.nvim"}, config = _6_}, "kevinhwang91/nvim-bqf"}
