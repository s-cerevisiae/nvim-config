-- [nfnl] Compiled from fnl/plugins/completion.fnl by https://github.com/Olical/nfnl, do not edit.
return {{"saghen/blink.cmp", version = "*", opts = {keymap = {preset = "enter", ["<Tab>"] = {"select_next", "fallback"}, ["<S-Tab>"] = {"select_prev", "fallback"}}, completion = {list = {selection = "auto_insert"}}}}}
