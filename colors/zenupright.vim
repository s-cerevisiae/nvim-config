runtime colors/zenwritten.vim

highlight Boolean gui=NONE cterm=NONE
highlight Comment gui=NONE cterm=NONE
highlight Constant gui=NONE cterm=NONE
highlight String gui=NONE cterm=NONE
highlight Number gui=NONE cterm=NONE
highlight SpecialKey gui=NONE cterm=NONE
highlight diffNewFile gui=NONE cterm=NONE
highlight diffOldFile gui=NONE cterm=NONE

" blink.cmp
highlight link BlinkCmpKind NONE
highlight link BlinkCmpLabelMatch Special

" mini.clue
highlight link MiniClueNextKey Constant
highlight link MiniClueNextKeyWithPostKeys Keyword
highlight link MiniClueDescGroup Special
highlight link MiniClueSeparator WinSeparator

" mini.icons
highlight link MiniIconsAzure DiagnosticInfo
highlight link MiniIconsCyan FzfLuaTabTitle
highlight link MiniIconsPurple DiagnosticHint
highlight link MiniIconsBlue DiagnosticInfo
highlight link MiniIconsGreen DiagnosticOk
highlight link MiniIconsGrey Type
highlight link MiniIconsOrange DiagnosticWarn
highlight link MiniIconsRed DiagnosticError
highlight link MiniIconsYellow DiagnosticWarn

let g:colors_name='zenupright'
