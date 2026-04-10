(vim.api.nvim_create_user_command "PackUpdate"
  #(vim.pack.update)
  {:nargs 0})

(vim.api.nvim_create_user_command "PackSync"
  #(vim.pack.update nil {:target "lockfile"})
  {:nargs 0})

(vim.api.nvim_create_user_command "PackRevert"
  #(vim.pack.update nil {:target "lockfile" :offline true})
  {:nargs 0})

(vim.api.nvim_create_user_command "PackRunHook"
  (fn [{:fargs [kind name]}]
    (when (not (PackHook.run name kind))
      (vim.notify (.. "No " kind " hook available for plugin " name))))
  {:nargs "+"
   :complete (fn [_ cmdline _]
               (let [hooks (PackHook.get)]
                 (case (vim.split cmdline " " {:trimempty true})
                   [cmd kind] (-?> hooks (. kind) (vim.tbl_keys))
                   [cmd] (vim.tbl_keys hooks)
                   _ [])))})

(vim.api.nvim_create_user_command "PackClean"
  #(vim.pack.del
     (icollect [_ p (ipairs (vim.pack.get nil {:info false}))]
       (if (not p.active) p.spec.name)))
  {:nargs 0})
