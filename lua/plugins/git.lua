-- [nfnl] fnl/plugins/git.fnl
return {{"lewis6991/gitsigns.nvim", opts = {numhl = true, signcolumn = false}}, {"sindrets/diffview.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {view = {merge_tool = {layout = "diff3_mixed"}}}}, {"NeogitOrg/neogit", dependencies = {"nvim-lua/plenary.nvim"}, cmd = "Neogit", config = true}}
