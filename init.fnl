(import-macros {: dot} :macros)

(vim.loader.enable)

(fn bootstrap [plugin]
  (let [[_ name] (vim.split plugin "/")
        plugin_path (.. (vim.fn.stdpath "data") "/lazy/" name)]
    (when (not (vim.loop.fs_stat plugin_path))
      (vim.notify (.. "Installing " plugin " to " plugin_path)
                  vim.log.levels.INFO)
      (vim.fn.system
        ["git" "clone" "--filter=blob:none" "--single-branch"
         (.. "https://github.com/" plugin)
         plugin_path]))
    (vim.opt.runtimepath:prepend plugin_path)))

(bootstrap "folke/lazy.nvim")

(set _G.quotient #(math.floor (/ $1 $2)))

(fn prequire [mod]
  (xpcall
    #(require mod)
    #(do (print "Failed to require module" mod)
         (print $1))))

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(dot (require :lazy) (setup "plugins"))

(prequire :config.options)
(prequire :config.events)
(prequire :config.commands)
(prequire :config.diagnostics)
(prequire :config.keymaps)

(pcall #(require :environmental))
