if exists('g:loaded_saloon_ui_interace_autoload')
    finish
endif
let g:loaded_saloon_ui_interace_autoload = 1

" FUNCTION: saloon#ui_interface#createDefaultBindings() {{{1
function! saloon#ui_interface#createDefaultBindings() abort
    let s = '<SNR>' . s:SID() . '_'

    call SaloonAddKeyMap({ 'key': g:SaloonMapQuit, 'scope': 'all', 'callback': s.'closeSaloonWindow' })
    call SaloonAddKeyMap({ 'key': '<CR>', 'scope': 'all', 'callback': s.'prospectorToggleTool' })
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

" FUNCTION: s:prospectorToggleTool() {{{1
" toggle prospector tool under cursor line
function! s:prospectorToggleTool() abort
    execute 'normal! Y'
    let l:cur_line = split(trim(@"))
    call saloon#prospector#ToggleTool(tolower(l:cur_line[-1]))
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
