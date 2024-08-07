(vim.api.nvim_create_user_command
  "Vimrc"
  (.. "cd " (vim.fn.stdpath "config"))
  {})
