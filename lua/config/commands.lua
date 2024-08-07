-- [nfnl] Compiled from fnl/config/commands.fnl by https://github.com/Olical/nfnl, do not edit.
return vim.api.nvim_create_user_command("Vimrc", ("cd " .. vim.fn.stdpath("config")), {})
