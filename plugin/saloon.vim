if exists('g:saloon_loaded')
    finish
endif
let g:saloon_loaded = 1

"SECTION: Load class files{{{2
call saloon#loadClassFiles()

"SECTION: Load class files{{{2
call saloon#setupCommands()

" Saloon UI mappings
nnoremap <silent> <Plug>(saloon_open) :Saloon<Return>
nnoremap <silent> <Plug>(saloon_close) :SaloonClose<Return>
nnoremap <silent> <Plug>(saloon_toggle) :SaloonToggle<Return>

" Prospector mappings
nnoremap <silent> <Plug>(saloon_prospector_only) :ProspectorOnly<Return>
" Prospector strictness profile mappings
nnoremap <silent> <Plug>(saloon_prospector_less_strict) :ProspectorLessStrict<Return>
nnoremap <silent> <Plug>(saloon_prospector_more_strict) :ProspectorMoreStrict<Return>
" Flag mappings
nnoremap <silent> <Plug>(saloon_prospector_toggle_doc_warnings) :ProspectorToggleDocWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_autodetect) :ProspectorToggleNoAutodetect<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_blending) :ProspectorToggleNoBlending<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_no_style_warnings) :ProspectorToggleNoStyleWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_test_warnings) :ProspectorToggleTestWarnings<Return>
" Tool/Linter mappings
nnoremap <silent> <Plug>(saloon_prospector_toggle_bandit) :ProspectorToggleBandit<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_dodgy) :ProspectorToggleDodgy<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_frosted) :ProspectorToggleFrosted<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_mccabe) :ProspectorToggleMccabe<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_mypy) :ProspectorToggleMyPy<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_pep257) :ProspectorTogglePep257<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_pep8) :ProspectorTogglePep8<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_profile_validator) :ProspectorToggleProfileValidator<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_pyflakes) :ProspectorTogglePyflakes<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_pylint) :ProspectorTogglePylint<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_pyroma) :ProspectorTogglePyroma<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_vulture) :ProspectorToggleVulture<Return>


" TODO: put this somewhere more appropriate
let g:SaloonAutoLint = 1
" TODO: modifying strictness event keys not working
let g:SaloonEventIncreaseStrictness = 'i'
let g:SaloonEventDecreaseStrictness = 'd'
let g:SaloonEventToggle = '<CR>'
let g:SaloonEventQuit = 'q'
let g:SaloonWinPos = 'right'
let g:SaloonWinWidth = 31


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
