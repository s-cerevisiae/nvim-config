(local {: autocmd : augroup} (require :utils))

(local hooks {:install {} :update {} :delete {}})

(fn run [name kind]
  (let [[{: active : path}] (vim.pack.get [name] {:info false})
        maybe-hook (. hooks kind name)]
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
    #(do (each [_ {: name : kind} (ipairs pending-events)]
           (run name kind))
         (set pending-events nil)))
  (autocmd
    "PackChanged" "*"
    (fn [{:data {:spec {: name} : kind}}]
      (if pending-events
          (table.insert pending-events {: name : kind})
          (run name kind))
      nil)))

(set _G.PackHook
  {: run
   : create
   :get #hooks})

