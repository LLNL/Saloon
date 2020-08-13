" ============================================================================
" CLASS: Creator
"
" This class is responsible for creating Saloon instances.  The new Saloon
" may be a tab saloon or a window saloon. In the process of creating a Saloon,
" Creator sets up all of the window and buffer options.
"
" NOTE: Code heavily influenced by NERDTree plugin. Thank you NERDTree!
" ============================================================================


let s:Creator = {}
let g:SaloonCreator = s:Creator

" FUNCTION: s:Creator._bindMappings() {{{1
function! s:Creator._bindMappings()
    call g:SaloonKeyMap.BindAll()
endfunction

" FUNCTION: s:Creator.BufNamePrefix() {{{1
function! s:Creator.BufNamePrefix()
    return 'Saloon_'
endfunction

" FUNCTION: s:Creator.CreateTabSaloon() {{{1
function! s:Creator.CreateTabSaloon()
    let creator = s:Creator.New()
    call creator.createTabSaloon()
endfunction

" FUNCTION: s:Creator.createTabSaloon() {{{1
function! s:Creator.createTabSaloon()
    if g:Saloon.ExistsForTab()
        call g:Saloon.Close()
        call self._removeSaloonBufForTab()
    endif

    call self._createSaloonWin()
    call self._createSaloon('tab')
    call b:Saloon.render()
endfunction

" FUNCTION: s:Creator._createSaloon() {{{1
function! s:Creator._createSaloon(type)
    let b:Saloon = g:Saloon.New(a:type)
endfunction

" FUNCTION: s:Creator._createSaloonWin() {{{1
" Initialize the Saloon window.  Open the window, size it properly, set all
" local options, etc.
function! s:Creator._createSaloonWin()
    let l:splitLocation = g:SaloonWinPos ==# 'right' ? 'botright ' : 'topleft '
    let l:splitSize = g:SaloonWinWidth

    if !g:Saloon.ExistsForTab()
        let t:SaloonBufName = self._nextBufferName()
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' new'
        silent! execute 'edit ' . t:SaloonBufName
        silent! execute 'vertical resize '. l:splitSize
    else
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' split'
        silent! execute 'buffer ' . t:SaloonBufName
    endif

    setlocal winfixwidth

    call self._setCommonBufOptions()
endfunction

" FUNCTION: s:Creator._isBufHidden(nr) {{{1
function! s:Creator._isBufHidden(nr)
    redir => bufs
    silent ls!
    redir END

    return bufs =~ a:nr . '..h'
endfunction

" FUNCTION: s:Creator.New() {{{1
function! s:Creator.New()
    let newCreator = copy(self)
    return newCreator
endfunction

" FUNCTION: s:Creator._nextBufferName() {{{1
" returns the buffer name for the next saloon
function! s:Creator._nextBufferName()
    let name = s:Creator.BufNamePrefix() . self._nextBufferNumber()
    return name
endfunction

" FUNCTION: s:Creator._nextBufferNumber() {{{1
" the number to add to the saloon buffer name to make the buf name unique
function! s:Creator._nextBufferNumber()
    if !exists('s:Creator._NextBufNum')
        let s:Creator._NextBufNum = 1
    else
        let s:Creator._NextBufNum += 1
    endif

    return s:Creator._NextBufNum
endfunction

" Function: s:Creator._removeSaloonBufForTab()   {{{1
function! s:Creator._removeSaloonBufForTab()
    let buf = bufnr(t:SaloonBufName)

    "if &hidden is not set then it will already be gone
    if buf != -1

        "saloon buf may be displayed elsewhere
        if self._isBufHidden(buf)
            exec 'bwipeout ' . buf
        endif

    endif

    unlet t:SaloonBufName
endfunction

" FUNCTION: s:Creator._setCommonBufOptions() {{{1
function! s:Creator._setCommonBufOptions()

    " Options for a non-file/control buffer.
    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal noswapfile

    " Options for controlling buffer/window appearance.
    setlocal foldcolumn=0
    setlocal foldmethod=manual
    setlocal nobuflisted
    setlocal nofoldenable
    setlocal nolist
    setlocal nospell
    setlocal nowrap
    setlocal nonumber
    setlocal norelativenumber
    setlocal cursorline

    iabc <buffer>

    call self._bindMappings()

    setlocal filetype=saloon
endfunction

" FUNCTION: s:Creator.ToggleTabSaloon() {{{1
function! s:Creator.ToggleTabSaloon()
    let creator = s:Creator.New()
    call creator.toggleTabSaloon()
endfunction

" FUNCTION: s:Creator.toggleTabSaloon() {{{1
" Toggles the saloon. I.e if the saloon is open, it is closed. If it is
" closed, it is restored or initialized. If dir is not empty, it will be set
" as the new root.
function! s:Creator.toggleTabSaloon()
    if g:Saloon.ExistsForTab()
        if !g:Saloon.IsOpen()
            call self._createSaloonWin()
            if !&hidden
                call b:Saloon.render()
            endif
            call b:Saloon.ui.restoreScreenState()
        else
            call g:Saloon.Close()
        endif
    else
        call self.createTabSaloon()
    endif
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
