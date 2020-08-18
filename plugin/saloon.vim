if exists('g:saloon_loaded')
    finish
endif
let g:saloon_loaded = 1

"SECTION: Load class files{{{2
call saloon#loadClassFiles()

"SECTION: Load class files{{{2
call saloon#setupCommands()

nnoremap <silent> <Plug>(saloon_prospector_only) :ProspectorOnly<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_doc_warnings) :ToggleFlagDocWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_autodetect) :ToggleFlagNoAutodetect<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_blending) :ToggleFlagNoBlending<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_style_warnings) :ToggleFlagNoStyleWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_test_warnings) :ToggleFlagTestWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_more_strict) MoreStrict:<Return>
nnoremap <silent> <Plug>(saloon_prospector_less_strict) LessStrict:<Return>



" TODO: put this somewhere more appropriate
let g:SaloonAutoLint = 1
let g:SaloonMapQuit = 'q'
" TODO: better way to start with prospector enabled
let g:SaloonEnableProspector = 1
if g:SaloonEnableProspector
    call saloon#ProspectorOnly()
endif

" SECTION: Auto commands {{{1
"============================================================
augroup Saloon
    "disallow insert mode in Saloon
    exec 'autocmd BufEnter,WinEnter '. g:SaloonCreator.BufNamePrefix() .'* stopinsert'
augroup END

" SECTION: Public API {{{1
"============================================================
function! SaloonAddKeyMap(options)
    call g:SaloonKeyMap.Create(a:options)
endfunction

call saloon#ui_interface#createDefaultBindings()
" vim: set sw=4 sts=4 et fdm=marker:
