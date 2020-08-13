" ============================================================================
" CLASS: UI
"
" NOTE: Code heavily influenced by NERDTree plugin. Thank you NERDTree!
" ============================================================================


let s:UI = {}
let g:SaloonUI = s:UI

" FUNCTION: s:UI.new(saloon) {{{1
function! s:UI.New(saloon)
    let newObj = copy(self)
    return newObj
endfunction

" FUNCTION: s:UI.restoreScreenState() {{{1
"
" Sets the screen state back to what it was when saloon#saveScreenState was last
" called.
"
" Assumes the cursor is in the Saloon window
function! s:UI.restoreScreenState()
    if !has_key(self, '_screenState')
        return
    endif
    call saloon#exec('silent vertical resize ' . self._screenState['oldWindowSize'], 1)

    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(self._screenState['oldTopLine'], 0)
    normal! zt
    call setpos('.', self._screenState['oldPos'])
    let &scrolloff=old_scrolloff
endfunction

" FUNCTION: s:UI.saveScreenState() {{{1
" Saves the current cursor position in the current buffer and the window
" scroll position
function! s:UI.saveScreenState()
    let win = winnr()
    let self._screenState = {}
    try
        call g:Saloon.CursorToSaloonWin()
        let self._screenState['oldPos'] = getpos('.')
        let self._screenState['oldTopLine'] = line('w0')
        let self._screenState['oldWindowSize']= winwidth('')
        call saloon#exec(win . 'wincmd w', 1)
    catch
    endtry
endfunction

" FUNCTION: s:UI.render() {{{1
function! s:UI.render()
    setlocal noreadonly modifiable

    " remember the top line of the buffer and the current line so we can
    " restore the view exactly how it was
    let curLine = line('.')
    let curCol = col('.')
    let topLine = line('w0')

    " delete all lines in the buffer (being careful not to clobber a register)
    silent 1,$delete _

    " draw the header line
    let header = "\" Saloon"
    call setline(line('.')+1, header)
    call cursor(line('.')+1, col('.'))

    " delete the blank line at the top of the buffer
    silent 1,1delete _

    " restore the view
    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(topLine, 1)
    normal! zt
    call cursor(curLine, curCol)
    let &scrolloff = old_scrolloff

    let text = "\" ======================\n\n"
    let text .= "Prospector settings:\n"

    let l:levels = saloon#prospector#getStrictnessLevels()
    let text .= "  Strictness Level:\n"
    let text .= "    " .. string(range(len(l:levels) + 1)) .. "\n\n"

    let text .= "  Linters:\n"
    let l:tools = saloon#prospector#getToolsAvailable()
    for tool in l:tools
        if index(g:prospector_option_value_tool, tool) < 0
            let l:is_enabled = "(off)"
        else
            let l:is_enabled = "(on) "
        endif
        let text .= "    " .. l:is_enabled .. " "
        let text .= toupper(tool[0]) .. tool[1:] .. "\n"
    endfor

    silent! put =text
    setlocal readonly nomodifiable
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
