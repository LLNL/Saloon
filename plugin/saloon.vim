if exists('g:saloon_loaded')
    finish
endif
let g:saloon_loaded = 1

command! -bar ProspectorOnly :call saloon#ProspectorOnly()
" Flags
command! -bar ToggleFlagDocWarnings :call saloon#prospector#ToggleFlagDocWarnings()
command! -bar ToggleFlagNoAutodetect :call saloon#prospector#ToggleFlagNoAutodetect()
command! -bar ToggleFlagNoBlending :call saloon#prospector#ToggleFlagNoBlending()
command! -bar ToggleFlagNoStyleWarnings :call saloon#prospector#ToggleFlagNoStyleWarnings()
command! -bar ToggleFlagTestWarnings :call saloon#prospector#ToggleFlagTestWarnings()
" Options
command! -bar MoreStrict :call saloon#prospector#IncreaseStrictness()
command! -bar LessStrict :call saloon#prospector#DecreaseStrictness()
command! -bar ToggleToolBandit :call saloon#prospector#ToggleToolBandit()
command! -bar ToggleToolDodgy :call saloon#prospector#ToggleToolDodgy()
command! -bar ToggleToolFrosted :call saloon#prospector#ToggleToolFrosted()
command! -bar ToggleToolMccabe :call saloon#prospector#ToggleToolMccabe()
command! -bar ToggleToolMyPy :call saloon#prospector#ToggleToolMyPy()
command! -bar ToggleToolPep257 :call saloon#prospector#ToggleToolPep257()
command! -bar ToggleToolPep8 :call saloon#prospector#ToggleToolPep8()
command! -bar ToggleToolProfileValidator :call saloon#prospector#ToggleToolProfileValidator()
command! -bar ToggleToolPyflakes :call saloon#prospector#ToggleToolPyflakes()
command! -bar ToggleToolPylint :call saloon#prospector#ToggleToolPylint()
command! -bar ToggleToolPyroma :call saloon#prospector#ToggleToolPyroma()
command! -bar ToggleToolVulture :call saloon#prospector#ToggleToolVulture()

nnoremap <silent> <Plug>(saloon_prospector_only) :ProspectorOnly<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_doc_warnings) :ToggleFlagDocWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_autodetect) :ToggleFlagNoAutodetect<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_blending) :ToggleFlagNoBlending<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_style_warnings) :ToggleFlagNoStyleWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_test_warnings) :ToggleFlagTestWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_more_strict) MoreStrict:<Return>
nnoremap <silent> <Plug>(saloon_prospector_less_strict) LessStrict:<Return>
" vim: set sw=4 sts=4 et fdm=marker:
