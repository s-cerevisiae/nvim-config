-- [nfnl] fnl/config/git.fnl
require("gitsigns").setup({numhl = true, signcolumn = false})
require("diffview").setup({view = {merge_tool = {layout = "diff3_mixed"}}})
return require("neogit").setup()
