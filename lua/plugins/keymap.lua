-- [nfnl] fnl/plugins/keymap.fnl
local function _1_()
  local _let_2_ = require("mini.clue")
  local gen_clues = _let_2_.gen_clues
  return {triggers = {{mode = "n", keys = "<c-w>"}, {mode = "i", keys = "<c-r>"}, {mode = "c", keys = "<c-r>"}, {keys = "<leader>", mode = "n"}, {keys = "g", mode = "n"}, {keys = "`", mode = "n"}, {keys = "'", mode = "n"}, {keys = "\"", mode = "n"}, {keys = "z", mode = "n"}, {keys = "<leader>", mode = "x"}, {keys = "g", mode = "x"}, {keys = "`", mode = "x"}, {keys = "'", mode = "x"}, {keys = "\"", mode = "x"}, {keys = "z", mode = "x"}}, clues = {gen_clues.g(), gen_clues.z(), gen_clues.marks(), gen_clues.registers(), gen_clues.windows({submode_resize = true}), {{keys = "<leader>dh", mode = "n", postkeys = "<leader>d"}, {keys = "<leader>dj", mode = "n", postkeys = "<leader>d"}, {keys = "<leader>dk", mode = "n", postkeys = "<leader>d"}, {keys = "<leader>dl", mode = "n", postkeys = "<leader>d"}}, {{desc = "file", keys = "<leader>f", mode = "n"}, {desc = "lang", keys = "<leader>l", mode = "n"}, {desc = "goto", keys = "<leader>lg", mode = "n"}, {desc = "debug", keys = "<leader>d", mode = "n"}, {desc = "term", keys = "<leader>t", mode = "n"}, {desc = "repl", keys = "<leader>r", mode = "n"}}}, window = {config = {width = "auto", border = "none"}}}
end
return {"nvim-mini/mini.clue", opts = _1_}
