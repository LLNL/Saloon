" Saloon autoload loaded {{{1
if exists('g:saloon_loaded_autoload')
    finish
endif
let g:saloon_loaded_autoload = 1

scriptencoding utf-8

" FUNCTION: saloon#exec(cmd, ignoreAll) {{{2
" Same as :exec cmd but, if ignoreAll is TRUE, set eventignore=all for the duration
" Borrowed from NERDTree plugin.
function! saloon#exec(cmd, ignoreAll) abort
    let old_ei = &eventignore
    if a:ignoreAll
        set eventignore=all
    endif
    try
        exec a:cmd
    finally
        let &eventignore = old_ei
    endtry
endfunction

" FUNCTION: saloon#loadClassFiles() {{{1
" Borrowed from NERDTree plugin.
function! saloon#loadClassFiles() abort
    runtime lib/saloon/opener.vim
    runtime lib/saloon/saloon.vim
    runtime lib/saloon/creator.vim
    runtime lib/saloon/ui.vim
    runtime lib/saloon/key_map.vim
endfunction

" FUNCTION: saloon#setupCommands() {{{1
" Borrowed from NERDTree plugin.
function! saloon#setupCommands() abort
    " UI
    command! -n=0 -bar Saloon :call g:SaloonCreator.CreateTabSaloon()
    command! -n=0 -bar SaloonToggle :call g:SaloonCreator.ToggleTabSaloon()
    command! -n=0 -bar SaloonClose :call g:Saloon.Close()
    command! -n=0 -bar SaloonEnableProspector :call saloon#EnableProspector()

    " Flags
    " Disable Flags
    command! -n=0 -bar ProspectorDisableAllFlags :call saloon#prospector#DisableAllFlags()
    command! -n=0 -bar ProspectorDisableDocWarnings :call saloon#prospector#DisableFlagDocWarnings()
    command! -n=0 -bar ProspectorDisableFullPep8 :call saloon#prospector#DisableFlagFullPep8()
    command! -n=0 -bar ProspectorDisableNoAutodetect :call saloon#prospector#DisableFlagNoAutodetect()
    command! -n=0 -bar ProspectorDisableNoBlending :call saloon#prospector#DisableFlagNoBlending()
    command! -n=0 -bar ProspectorDisableNoStyleWarnings :call saloon#prospector#DisableFlagNoStyleWarnings()
    command! -n=0 -bar ProspectorDisableTestWarnings :call saloon#prospector#DisableFlagTestWarnings()
    " Enable Flags
    command! -n=0 -bar ProspectorEnableAllFlags :call saloon#prospector#EnableAllFlags()
    command! -n=0 -bar ProspectorEnableDocWarnings :call saloon#prospector#EnableFlagDocWarnings()
    command! -n=0 -bar ProspectorEnableFullPep8 :call saloon#prospector#EnableFlagFullPep8()
    command! -n=0 -bar ProspectorEnableNoAutodetect :call saloon#prospector#EnableFlagNoAutodetect()
    command! -n=0 -bar ProspectorEnableNoBlending :call saloon#prospector#EnableFlagNoBlending()
    command! -n=0 -bar ProspectorEnableNoStyleWarnings :call saloon#prospector#EnableFlagNoStyleWarnings()
    command! -n=0 -bar ProspectorEnableTestWarnings :call saloon#prospector#EnableFlagTestWarnings()
    " Toggle Flags
    command! -n=0 -bar ProspectorToggleDocWarnings :call saloon#prospector#ToggleFlagDocWarnings()
    command! -n=0 -bar ProspectorToggleFullPep8 :call saloon#prospector#ToggleFlagFullPep8()
    command! -n=0 -bar ProspectorToggleNoAutodetect :call saloon#prospector#ToggleFlagNoAutodetect()
    command! -n=0 -bar ProspectorToggleNoBlending :call saloon#prospector#ToggleFlagNoBlending()
    command! -n=0 -bar ProspectorToggleNoStyleWarnings :call saloon#prospector#ToggleFlagNoStyleWarnings()
    command! -n=0 -bar ProspectorToggleTestWarnings :call saloon#prospector#ToggleFlagTestWarnings()
    " Options
    command! -n=0 -bar ProspectorMoreStrict :call saloon#prospector#IncreaseStrictness()
    command! -n=0 -bar ProspectorLessStrict :call saloon#prospector#DecreaseStrictness()
    command! -n=0 -bar ProspectorToggleBandit :call saloon#prospector#ToggleToolBandit()
    command! -n=0 -bar ProspectorToggleDodgy :call saloon#prospector#ToggleToolDodgy()
    command! -n=0 -bar ProspectorToggleFrosted :call saloon#prospector#ToggleToolFrosted()
    command! -n=0 -bar ProspectorToggleMccabe :call saloon#prospector#ToggleToolMccabe()
    command! -n=0 -bar ProspectorToggleMyPy :call saloon#prospector#ToggleToolMyPy()
    command! -n=0 -bar ProspectorTogglePep257 :call saloon#prospector#ToggleToolPep257()
    command! -n=0 -bar ProspectorTogglePep8 :call saloon#prospector#ToggleToolPep8()
    command! -n=0 -bar ProspectorToggleProfileValidator :call saloon#prospector#ToggleToolProfileValidator()
    command! -n=0 -bar ProspectorTogglePyflakes :call saloon#prospector#ToggleToolPyflakes()
    command! -n=0 -bar ProspectorTogglePylint :call saloon#prospector#ToggleToolPylint()
    command! -n=0 -bar ProspectorTogglePyroma :call saloon#prospector#ToggleToolPyroma()
    command! -n=0 -bar ProspectorToggleVulture :call saloon#prospector#ToggleToolVulture()

endfunction
" Public API {{{1
"Function: saloon#EnableProspector() function {{{2
function! saloon#EnableProspector() abort
    " Only run linters named in ale_linters settings. Empty by default.
    let g:ale_linters_explicit = 1
    let g:saloon_prospector_enabled = 1

    " TODO: leave enabled linters enabled not covered by prospector
    let g:ale_linters = {'python': ['prospector']}

    call saloon#prospector#Init()
endfunction
" vim: set sw=4 sts=4 et fdm=marker:
