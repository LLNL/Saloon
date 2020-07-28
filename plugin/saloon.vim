if exists('g:saloon_loaded')
    finish
endif
let g:saloon_loaded = 1

command! -bar ProspectorOnly :call saloon#ProspectorOnly()
" Flags
command! -bar ToggleDocWarnings :call saloon#prospector#ToggleDocWarnings()
command! -bar ToggleNoAutodetect :call saloon#prospector#ToggleNoAutodetect()
command! -bar ToggleNoBlending :call saloon#prospector#ToggleNoBlending()
command! -bar ToggleNoStyleWarnings :call saloon#prospector#ToggleNoStyleWarnings()
command! -bar ToggleTestWarnings :call saloon#prospector#ToggleTestWarnings()
" Options
command! -bar MoreStrict :call saloon#prospector#IncreaseStrictness()
command! -bar LessStrict :call saloon#prospector#DecreaseStrictness()
command! -bar ToggleBandit :call saloon#prospector#ToggleToolBandit()
command! -bar ToggleDodgy :call saloon#prospector#ToggleToolDodgy()
command! -bar ToggleFrosted :call saloon#prospector#ToggleToolFrosted()
command! -bar ToggleMccabe :call saloon#prospector#ToggleToolMccabe()
command! -bar ToggleMyPy :call saloon#prospector#ToggleToolMyPy()
command! -bar TogglePep257 :call saloon#prospector#ToggleToolPep257()
command! -bar TogglePep8 :call saloon#prospector#ToggleToolPep8()
command! -bar ToggleProfileValidator :call saloon#prospector#ToggleToolProfileValidator()
command! -bar TogglePyflakes :call saloon#prospector#ToggleToolPyflakes()
command! -bar TogglePylint :call saloon#prospector#ToggleToolPylint()
command! -bar TogglePyroma :call saloon#prospector#ToggleToolPyroma()
command! -bar ToggleVulture :call saloon#prospector#ToggleToolVulture()

" vim: set sw=4 sts=4 et fdm=marker:
