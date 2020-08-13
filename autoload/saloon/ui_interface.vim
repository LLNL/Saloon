if exists('g:loaded_saloon_ui_interace_autoload')
    finish
endif
let g:loaded_saloon_ui_interace_autoload = 1

" FUNCTION: saloon#ui_interface#createDefaultBindings() {{{1
function! saloon#ui_interface#createDefaultBindings() abort
    let s = '<SNR>' . s:SID() . '_'

    call SaloonAddKeyMap({ 'key': g:SaloonMapQuit, 'scope': 'all', 'callback': s.'closeSaloonWindow' })
endfunction


"SECTION: Interface bindings {{{1
"============================================================

" FUNCTION: s:closeSaloonWindow() {{{1
" close the saloon window
function! s:closeSaloonWindow() abort
    if b:Saloon.isWinSaloon() && b:Saloon.previousBuf() !=# -1
        exec 'buffer ' . b:Saloon.previousBuf()
    else
        if winnr('$') > 1
            call g:Saloon.Close()
        endif
    endif
endfunction

" FUNCTION: saloon#ui_interface#invokeKeyMap(key) {{{1
"this is needed since I cant figure out how to invoke dict functions from a
"key map
function! saloon#ui_interface#invokeKeyMap(key) abort
    call g:SaloonKeyMap.Invoke(a:key)
endfunction

" Function: s:SID()   {{{1
function! s:SID() abort
    if !exists('s:sid')
        let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
    endif
    return s:sid
endfun
