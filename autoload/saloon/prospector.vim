" Script initialization {{{1
" Saloon Prospector autoload loaded {{{2
if exists('g:saloon_prospector_loaded_autoload')
    finish
endif
let g:saloon_prospector_loaded_autoload = 1

scriptencoding utf-8

" Script variable settings {{{2
" Prospector flags {{{3
let g:prospector_flag_name_doc_warnings = '--doc-warnings'
let g:prospector_flag_name_full_pep8 = '--full-pep8'
let g:prospector_flag_name_no_autodetect = '--no-autodetect'
let g:prospector_flag_name_no_blending = '--no-blending'
let g:prospector_flag_name_no_style_warnings = '--no-style-warnings'
let g:prospector_flag_name_test_warnings = '--test-warnings'
" Flags used to enable /disable prospector flags
let g:prospector_flag_enabled_doc_warnings = 0
let g:prospector_flag_enabled_full_pep8 = 0
let g:prospector_flag_enabled_no_autodetect = 0
let g:prospector_flag_enabled_no_blending = 0
let g:prospector_flag_enabled_no_style_warnings = 0
let g:prospector_flag_enabled_test_warnings = 0
"function! s:GetFlag(flag_name)
function! s:GetFlag(flag_name)
    return get(g:, "prospector_flag_enabled_" . a:flag_name, -1)
endfunction
let g:prospector_flags = {
        \ g:prospector_flag_name_doc_warnings:      function("s:GetFlag", ["doc_warnings"]),
        \ g:prospector_flag_name_full_pep8:         function("s:GetFlag", ["full_pep8"]),
        \ g:prospector_flag_name_no_autodetect:     function("s:GetFlag", ["no_autodetect"]),
        \ g:prospector_flag_name_no_blending:       function("s:GetFlag", ["no_blending"]),
        \ g:prospector_flag_name_no_style_warnings: function("s:GetFlag", ["no_style_warnings"]),
        \ g:prospector_flag_name_test_warnings:     function("s:GetFlag", ["test_warnings"]),}

" Prospector options {{{3
let g:prospector_option_name_profile = '--profile'
let g:prospector_option_name_profile_path = '--profile-path'
let g:prospector_option_name_strictness = '--strictness'
let g:prospector_option_name_tool = '--tool'
let g:prospector_option_name_without_tool = '--without-tool'
" Options considered disabled if empty() returns true
let g:prospector_option_value_profile = []
let g:prospector_option_value_profile_path = []
let g:prospector_option_value_strictness = ''
let g:prospector_option_value_tool = []
let g:prospector_option_value_without_tool = []
"function! s:GetOption(option_name)
function! s:GetOption(option_name)
    let l:return_value = get(g:, "prospector_option_value_" . a:option_name, [])
    if type(l:return_value) is v:t_list
        return join(l:return_value)
    endif
    return l:return_value
endfunction
let g:prospector_options = {
     \ g:prospector_option_name_profile:      function("s:GetOption", ["profile"]),
     \ g:prospector_option_name_profile_path: function("s:GetOption", ["profile_path"]),
     \ g:prospector_option_name_strictness:   function("s:GetOption", ["strictness"]),
     \ g:prospector_option_name_tool:         function("s:GetOption", ["tool"]),
     \ g:prospector_option_name_without_tool: function("s:GetOption", ["without_tool"]),}

function! s:getStrictnessLevels()
    return ['verylow', 'low', 'medium', 'high', 'veryhigh']
endfunction

function! s:getToolsAvailable() abort
    return ['bandit', 'dodgy', 'frosted', 'mccabe', 'mypy', 'pep257', 'pep8',
          \ 'profile-validator', 'pyflakes', 'pylint', 'pyroma', 'vulture']
endfunction

" Script functions {{{1
"Function: saloon#prospector#Init() function {{{2
function! saloon#prospector#Init() abort
    if !exists("g:ale_python_prospector_options")
        echom "Saloon started before ALE"
    endif
    let g:ale_python_prospector_options = get(g:, 'ale_python_prospector_options', "")
    let g:prospector_option_value_strictness = s:getStrictnessLevels()[-1]
    call s:updateProspectorCommand()
endfunction

"Function: s:updateProspectorCommand() function {{{2
function! s:updateProspectorCommand() abort
    let l:command = []
    for [flag_name, Is_flag_enabled] in items(g:prospector_flags)
        if Is_flag_enabled()
            call add(l:command, flag_name)
        endif
    endfor

    for [option_name, Option_values] in items(g:prospector_options)
        if !empty(Option_values())
            call add(l:command, option_name)
            call add(l:command, Option_values())
        endif
    endfor

    let g:ale_python_prospector_options = join(l:command)
endfunction
"}}}
" Public API {{{1
" Toggle flags {{{2
"Function: saloon#prospector#ToggleFlagDocWarnings() function {{{3
function! saloon#prospector#ToggleFlagDocWarnings() abort
    let g:prospector_flag_enabled_doc_warnings =
                \ (g:prospector_flag_enabled_doc_warnings + 1) % 2
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleFlagFullPep8() function {{{3
function! saloon#prospector#ToggleFlagFullPep8() abort
    let g:prospector_flag_enabled_full_pep8 =
                \ (g:prospector_flag_enabled_full_pep8 + 1) % 2
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleFlagNoAutodetect() function {{{3
function! saloon#prospector#ToggleFlagNoAutodetect() abort
    let g:prospector_flag_enabled_no_autodetect =
                \ (g:prospector_flag_enabled_no_autodetect + 1) % 2
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleFlagNoBlending() function {{{3
function! saloon#prospector#ToggleFlagNoBlending() abort
    let g:prospector_flag_enabled_no_blending =
                \ (g:prospector_flag_enabled_no_blending + 1) % 2
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleFlagNoStyleWarnings() function {{{3
function! saloon#prospector#ToggleFlagNoStyleWarnings() abort
    let g:prospector_flag_enabled_no_style_warnings =
                \ (g:prospector_flag_enabled_no_style_warnings + 1) % 2
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleFlagTestWarnings() function {{{3
function! saloon#prospector#ToggleFlagTestWarnings() abort
    let g:prospector_flag_enabled_test_warnings =
                \ (g:prospector_flag_enabled_test_warnings + 1) % 2
    call s:updateProspectorCommand()
endfunction

" Toggle parts of options {{{2
"Function: saloon#prospector#DecreaseStrictness() function {{{3
function! saloon#prospector#DecreaseStrictness() abort
    let l:strictness_levels = s:getStrictnessLevels()
    let l:new_level = index(l:strictness_levels,
                          \ g:prospector_option_value_strictness) - 1
"    if l:new_level >= 0
    if l:new_level < 0
        let g:prospector_option_value_strictness = ''
    else
        let g:prospector_option_value_strictness = l:strictness_levels[l:new_level]
    endif
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#IncreaseStrictness() function {{{3
function! saloon#prospector#IncreaseStrictness() abort
    let l:strictness_levels = s:getStrictnessLevels()
    let l:new_level = index(l:strictness_levels,
                          \ g:prospector_option_value_strictness) + 1
    if l:new_level < len(l:strictness_levels)
        let g:prospector_option_value_strictness = l:strictness_levels[l:new_level]
    endif
    call s:updateProspectorCommand()
endfunction

"Function: s:ToggleTool() function {{{3
function! s:ToggleTool(tool) abort
    if index(s:getToolsAvailable(), a:tool) < 0
        return
    endif

    let l:index = index(g:prospector_option_value_tool, a:tool)
    if l:index < 0
        call add(g:prospector_option_value_tool, a:tool)
    else
        call remove(g:prospector_option_value_tool, l:index)
    endif
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleToolBandit() function {{{3
function! saloon#prospector#ToggleToolBandit() abort
    call s:ToggleTool("bandit")
endfunction

"Function: saloon#prospector#ToggleToolDodgy() function {{{3
function! saloon#prospector#ToggleToolDodgy() abort
    call s:ToggleTool("dodgy")
endfunction

"Function: saloon#prospector#ToggleToolFrosted() function {{{3
function! saloon#prospector#ToggleToolFrosted() abort
    call s:ToggleTool("frosted")
endfunction

"Function: saloon#prospector#ToggleToolMccabe() function {{{3
function! saloon#prospector#ToggleToolMccabe() abort
    call s:ToggleTool("mccabe")
endfunction

"Function: saloon#prospector#ToggleToolMyPy() function {{{3
function! saloon#prospector#ToggleToolMyPy() abort
    call s:ToggleTool("mypy")
endfunction

"Function: saloon#prospector#ToggleToolPep257() function {{{3
function! saloon#prospector#ToggleToolPep257() abort
    call s:ToggleTool("pep257")
endfunction

"Function: saloon#prospector#ToggleToolPep8() function {{{3
function! saloon#prospector#ToggleToolPep8() abort
    call s:ToggleTool("pep8")
endfunction

"Function: saloon#prospector#ToggleToolProfileValidator() function {{{3
function! saloon#prospector#ToggleToolProfileValidator() abort
    call s:ToggleTool("profile-validator")
endfunction

"Function: saloon#prospector#ToggleToolPyflakes() function {{{3
function! saloon#prospector#ToggleToolPyflakes() abort
    call s:ToggleTool("pyflakes")
endfunction

"Function: saloon#prospector#ToggleToolPylint() function {{{3
function! saloon#prospector#ToggleToolPylint() abort
    call s:ToggleTool("pylint")
endfunction

"Function: saloon#prospector#ToggleToolPyroma() function {{{3
function! saloon#prospector#ToggleToolPyroma() abort
    call s:ToggleTool("pyroma")
endfunction

"Function: saloon#prospector#ToggleToolVulture() function {{{3
function! saloon#prospector#ToggleToolVulture() abort
    call s:ToggleTool("vulture")
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
