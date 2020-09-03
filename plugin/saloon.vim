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
nnoremap <silent> <Plug>(saloon_enable_prospector) :SaloonEnableProspector<Return>

" Prospector strictness profile mappings
nnoremap <silent> <Plug>(saloon_prospector_less_strict) :ProspectorLessStrict<Return>
nnoremap <silent> <Plug>(saloon_prospector_more_strict) :ProspectorMoreStrict<Return>
" Flag mappings
" Enable Flag mappings
nnoremap <silent> <Plug>(saloon_prospector_enable_all_flags) :ProspectorEnableAllFlags<Return>
nnoremap <silent> <Plug>(saloon_prospector_enable_doc_warnings) :ProspectorEnableDocWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_enable_full_pep8) :ProspectorEnableFullPep8<Return>
nnoremap <silent> <Plug>(saloon_prospector_enable_no_autodetect) :ProspectorEnableNoAutodetect<Return>
nnoremap <silent> <Plug>(saloon_prospector_enable_no_blending) :ProspectorEnableNoBlending<Return>
nnoremap <silent> <Plug>(saloon_prospector_enable_no_style_warnings) :ProspectorEnableNoStyleWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_enable_test_warnings) :ProspectorEnableTestWarnings<Return>
" Disable Flag mappings
nnoremap <silent> <Plug>(saloon_prospector_disable_all_flags) :ProspectorDisableAllFlags<Return>
nnoremap <silent> <Plug>(saloon_prospector_disable_doc_warnings) :ProspectorDisableDocWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_disable_full_pep8) :ProspectorsDisableFullPep8<Return>
nnoremap <silent> <Plug>(saloon_prospector_disable_no_autodetect) :ProspectorDisableNoAutodetect<Return>
nnoremap <silent> <Plug>(saloon_prospector_disable_no_blending) :ProspectorDisableNoBlending<Return>
nnoremap <silent> <Plug>(saloon_prospector_disable_no_style_warnings) :ProspectorDisableNoStyleWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_disable_test_warnings) :ProspectorDisableTestWarnings<Return>
" Toggle Flag mappings
nnoremap <silent> <Plug>(saloon_prospector_toggle_doc_warnings) :ProspectorToggleDocWarnings<Return>
nnoremap <silent> <Plug>(saloon_prospector_toggle_full_pep8) :ProspectorsToggleFullPep8<Return>
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

call saloon#EnableProspector()

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
