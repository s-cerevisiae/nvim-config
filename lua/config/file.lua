-- [nfnl] fnl/config/file.fnl
require("neo-tree").setup({sources = {"filesystem", "document_symbols"}, filesystem = {follow_current_file = {enabled = true}, group_empty_dirs = true, hijack_netrw_behavior = "disabled"}})
return require("oil").setup({keymaps = {["<localleader>s"] = {"actions.select", opts = {horizontal = true}}, ["<localleader>v"] = {"actions.select", opts = {vertical = true}}, ["<localleader>t"] = {"actions.select", opts = {tab = true}}, ["<localleader>p"] = "actions.preview"}})
