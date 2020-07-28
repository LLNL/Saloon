" Script initialization {{{1
" Saloon autoload loaded {{{2
if exists('g:saloon_loaded_autoload')
    finish
endif
let g:saloon_loaded_autoload = 1
 
scriptencoding utf-8

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
