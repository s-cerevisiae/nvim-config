(local {: autocmd : augroup} (require :utils))

(local hooks {:install {} :update {} :delete {}})

(fn run [{: name : kind : active : path}]
  (let [maybe-hook (. hooks kind name)]
    (if maybe-hook
        (do (when (not active)
              (vim.cmd.packadd name))
            (vim.notify (.. "Running " kind " hook for package " name)
                        vim.log.levels.INFO)
            (maybe-hook path)
            true)
        false)))

(fn create [kinds name hook]
  (each [_ kind (ipairs kinds)]
    (set (. hooks kind name) hook)))

(var pending-events [])

(doto (augroup "PackHook")
  (autocmd "VimEnter" "*"
    #(do (each [_ args (ipairs pending-events)]
           (run args))
         (set pending-events nil)))
  (autocmd
    "PackChanged" "*"
    (fn [{:data {:spec {: name} : kind : active : path}}]
      (local args {: name : kind : active : path})
      (if pending-events
          (table.insert pending-events args)
          (run args))
      nil)))

(set _G.PackHook
  {: run
   : create
   :get #hooks})

