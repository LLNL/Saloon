" Saloon autoload loaded {{{1
if exists('g:saloon_loaded_autoload')
    finish
endif
let g:saloon_loaded_autoload = 1

scriptencoding utf-8

" TODO: make configurable to the user
let g:SaloonWinPos = 'right'
let g:SaloonWinWidth = 31


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
    command! -n=0 -bar ProspectorOnly :call saloon#ProspectorOnly()

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

endfunction
" Public API {{{1
"Function: saloon#ProspectorOnly() function {{{2
function! saloon#ProspectorOnly() abort
    " Only run linters named in ale_linters settings. Empty by default.
    let g:ale_linters_explicit = 1

    " TODO: leave enabled linters enabled not covered by prospector
    let g:ale_linters = {'python': ['prospector']}

    call saloon#prospector#Init()
endfunction
" vim: set sw=4 sts=4 et fdm=marker:
