" ============================================================================
" CLASS: Saloon
"
" NOTE: Code heavily influenced by NERDTree plugin. Thank you NERDTree!
"======================================================================
let s:Saloon = {}
let g:Saloon = s:Saloon

"FUNCTION: s:Saloon.Close() {{{1
"Closes the saloon window for this tab
function! s:Saloon.Close()
    if !s:Saloon.IsOpen()
        return
    endif

    if winnr('$') !=# 1
        " Use the window ID to identify the currently active window or fall
        " back on the buffer ID if win_getid/win_gotoid are not available, in
        " which case we'll focus an arbitrary window showing the buffer.
        let l:useWinId = exists('*win_getid') && exists('*win_gotoid')

        if winnr() ==# s:Saloon.GetWinNum()
            call saloon#exec('wincmd p', 1)
            let l:activeBufOrWin = l:useWinId ? win_getid() : bufnr('')
            call saloon#exec('wincmd p', 1)
        else
            let l:activeBufOrWin = l:useWinId ? win_getid() : bufnr('')
        endif

        call saloon#exec(s:Saloon.GetWinNum() . ' wincmd w', 1)
        call saloon#exec('close', 0)
        if l:useWinId
            call saloon#exec('call win_gotoid(' . l:activeBufOrWin . ')', 0)
        else
            call saloon#exec(bufwinnr(l:activeBufOrWin) . ' wincmd w', 0)
        endif
    else
        close
    endif
endfunction

"FUNCTION: s:Saloon.CursorToSaloonWin(){{{1
"Places the cursor in the Saloon window
function! s:Saloon.CursorToSaloonWin(...)
    call g:Saloon.MustBeOpen()
    call saloon#exec(g:Saloon.GetWinNum() . 'wincmd w', a:0 >0 ? a:1 : 1)
endfunction

" Function: s:Saloon.ExistsForTab()   {{{1
" Returns 1 if a Saloon root exists in the current tab
function! s:Saloon.ExistsForTab()
    if !exists('t:SaloonBufName')
        return
    end

    "check b:Saloon is still there and hasn't been e.g. :bdeleted
    return !empty(getbufvar(bufnr(t:SaloonBufName), 'Saloon'))
endfunction

"FUNCTION: s:Saloon.GetWinNum() {{{1
"gets the Saloon window number for this tab
function! s:Saloon.GetWinNum()
    if exists('t:SaloonBufName')
        return bufwinnr(t:SaloonBufName)
    endif

    " If WindowSaloon, there is no t:SaloonBufName variable. Search all windows.
    for w in range(1,winnr('$'))
        if bufname(winbufnr(w)) =~# '^' . g:SaloonCreator.BufNamePrefix() . '\d\+$'
            return w
        endif
    endfor

    return -1
endfunction

"FUNCTION: s:Saloon.IsOpen() {{{1
function! s:Saloon.IsOpen()
    return s:Saloon.GetWinNum() !=# -1
endfunction

"FUNCTION: s:Saloon.isTabSaloon() {{{1
function! s:Saloon.isTabSaloon()
    return self._type ==# 'tab'
endfunction

"FUNCTION: s:Saloon.isWinSaloon() {{{1
function! s:Saloon.isWinSaloon()
    return self._type ==# 'window'
endfunction

"FUNCTION: s:Saloon.MustBeOpen() {{{1
function! s:Saloon.MustBeOpen()
    if !s:Saloon.IsOpen()
        throw 'Saloon.SaloonNotOpen'
    endif
endfunction

"FUNCTION: s:Saloon.New() {{{1
function! s:Saloon.New(type)
    let newObj = copy(self)
    let newObj.ui = g:SaloonUI.New(newObj)
    let newObj._type = a:type
    return newObj
endfunction

"FUNCTION: s:Saloon.render() {{{1
"A convenience function - since this is called often
function! s:Saloon.render()
    call self.ui.render()
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
