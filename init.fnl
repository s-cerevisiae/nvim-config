(import-macros {: dot} :macros)

(vim.loader.enable)

(dot (require :vim._core.ui2)
     (enable {:enable true
              :msg {:targets "msg"
                    :msg {:timeout 1500}}}))

(set _G.quotient #(math.floor (/ $1 $2)))

(fn prequire [mod]
  (xpcall
    #(require mod)
    #(do (print "Failed to require module" mod)
         (print $1))))

(prequire :plugins.hook)
(prequire :config.flatten)

(prequire :plugins)
(prequire :config.options)
(prequire :config.ui)
(prequire :config.file)
(prequire :config.editing)
(prequire :config.completion)
(prequire :config.language)
(prequire :config.term)
(prequire :config.git)
(prequire :config.events)
(prequire :config.commands)
(prequire :config.diagnostics)
(prequire :config.keymaps)

(pcall #(require :environmental))
