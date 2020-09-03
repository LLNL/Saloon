" Script initialization {{{1
" Saloon Prospector autoload loaded {{{2
if exists('g:saloon_prospector_loaded_autoload')
    finish
endif
let g:saloon_prospector_loaded_autoload = 1

scriptencoding utf-8

" Script variable settings {{{2
"Function! s:disableFlag(flag)
function! s:disableFlag(flag) dict
    if get(self, a:flag, v:none)->type() == v:t_number
        let self[a:flag] = 0
    endif
endfunction
"Function! s:disableAllFlags()
function! s:disableAllFlags() dict
    for flag in keys(self)
        call self.disable(flag)
    endfor
endfunction
"Function! s:enableFlag(flag)
function! s:enableFlag(flag) dict
    if get(self, a:flag, v:none)->type() == v:t_number
        let self[a:flag] = 1
    endif
endfunction
"Function! s:enableAllFlags()
function! s:enableAllFlags() dict
    for flag in keys(self)
        call self.enable(flag)
    endfor
endfunction
"Function! s:toggleFlag(flag)
function! s:toggleFlag(flag) dict
    if get(self, a:flag, v:none)->type() == v:t_number
        let self[a:flag] = (self[a:flag] + 1) % 2
    endif
endfunction
"Function! s:getName(flag)
function! s:getName(flag) dict
    if get(self, a:flag, v:none)->type() == v:t_number
        return tr(a:flag, '-', '_')[2:]
    endif
endfunction
"Function! s:getAllFlags()
function! s:getAllFlags() dict
    return extend(self.get_enabled_flags(), self.get_disabled_flags(), "error")
endfunction
"Function! s:getDisabledFlags()
function! s:getDisabledFlags() dict
    return copy(self)->filter({_, val -> val == 0})
endfunction
"Function! s:getEnabledFlags()
function! s:getEnabledFlags() dict
    return copy(self)->filter({_, val -> val == 1})
endfunction
let s:flag_handler = {
            \ 'enable': function("s:enableFlag"),
            \ 'enable_all': function("s:enableAllFlags"),
            \ 'disable': function("s:disableFlag"),
            \ 'disable_all': function("s:disableAllFlags"),
            \ 'get_all_flags': function("s:getAllFlags"),
            \ 'get_enabled_flags': function("s:getEnabledFlags"),
            \ 'get_disabled_flags': function("s:getDisabledFlags"),
            \ 'get_name': function("s:getName"),
            \ 'toggle': function("s:toggleFlag"),}

let g:prospector_flag_doc_warnings = 'doc-warnings'
let g:prospector_flag_full_pep8 = 'full-pep8'
let g:prospector_flag_no_autodetect = 'no-autodetect'
let g:prospector_flag_no_blending = 'no-blending'
let g:prospector_flag_no_style_warnings = 'no-style-warnings'
let g:prospector_flag_test_warnings = 'test-warnings'
let s:prospector_flags = extend(copy(s:flag_handler),
            \ {g:prospector_flag_doc_warnings: 0,
            \  g:prospector_flag_full_pep8: 0,
            \  g:prospector_flag_no_autodetect: 0,
            \  g:prospector_flag_no_blending: 0,
            \  g:prospector_flag_no_style_warnings: 0,
            \  g:prospector_flag_test_warnings: 0,})

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
"Function! s:getOption(option_name)
function! s:getOption(option_name)
    let l:return_value = get(g:, "prospector_option_value_" . a:option_name, [])
    if type(l:return_value) is v:t_list
        return join(l:return_value)
    endif
    return l:return_value
endfunction
let g:prospector_options = {
     \ g:prospector_option_name_profile:      function("s:getOption", ["profile"]),
     \ g:prospector_option_name_profile_path: function("s:getOption", ["profile_path"]),
     \ g:prospector_option_name_strictness:   function("s:getOption", ["strictness"]),
     \ g:prospector_option_name_tool:         function("s:getOption", ["tool"]),
     \ g:prospector_option_name_without_tool: function("s:getOption", ["without_tool"]),}

function! saloon#prospector#GetStrictnessLevels()
    return ['verylow', 'low', 'medium', 'high', 'veryhigh']
endfunction

function! saloon#prospector#GetToolsAvailable() abort
    return ['bandit', 'dodgy', 'frosted', 'mccabe', 'mypy', 'pep257', 'pep8',
          \ 'profile-validator', 'pyflakes', 'pylint', 'pyroma', 'vulture']
endfunction

function! saloon#prospector#DisableAllFlags() abort
    call s:prospector_flags.disable_all()
    call s:updateProspectorCommand()
endfunction

function! saloon#prospector#GetDisabledFlags() abort
    return s:prospector_flags.get_disabled_flags()
endfunction

function! saloon#prospector#EnableAllFlags() abort
    call s:prospector_flags.enable_all()
    call s:updateProspectorCommand()
endfunction

function! saloon#prospector#GetEnabledFlags() abort
    return s:prospector_flags.get_enabled_flags()
endfunction

function! saloon#prospector#GetFlags() abort
    return s:prospector_flags.get_all_flags()
endfunction

" Script functions {{{1
"Function: saloon#prospector#Init() function {{{2
function! saloon#prospector#Init() abort
    let g:ale_python_prospector_options = get(g:, 'ale_python_prospector_options', "")
    let g:prospector_option_value_strictness = saloon#prospector#GetStrictnessLevels()[-1]
    call s:prospector_flags.disable_all()
    call s:updateProspectorCommand()
endfunction

"Function: s:updateProspectorCommand() function {{{2
function! s:updateProspectorCommand() abort
    " Prepend '--' before flag name as expected on command line
    let l:command = saloon#prospector#GetEnabledFlags()
                  \ ->keys()->sort()->map('"--" .. v:val')

    for [option_name, Option_values] in items(g:prospector_options)
        if !empty(Option_values())
            call add(l:command, option_name)
            call add(l:command, Option_values())
        endif
    endfor

    let g:ale_python_prospector_options = join(l:command)
    if g:SaloonAutoLint && get(g:, 'loaded_ale', 0)
        if winnr() !=# g:Saloon.GetWinNum()
            execute "ALELint"
        else
            call saloon#exec('wincmd p', 1)
            execute "ALELint"
            call saloon#exec('wincmd p', 1)
        endif
    endif
    if g:Saloon.IsOpen()
        call g:Saloon.refreshSaloon()
    endif
endfunction
"}}}
" Public API {{{1
"Flag Toggle Functions {{{2
"Function: saloon#prospector#ToggleFlag() function {{{3
function! saloon#prospector#ToggleFlag(flag) abort
    call s:prospector_flags.toggle(a:flag)
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleFlagDocWarnings() function {{{3
function! saloon#prospector#ToggleFlagDocWarnings() abort
    call saloon#prospector#ToggleFlag(g:prospector_flag_doc_warnings)
endfunction

"Function: saloon#prospector#ToggleFlagFullPep8() function {{{3
function! saloon#prospector#ToggleFlagFullPep8() abort
    call saloon#prospector#ToggleFlag(g:prospector_flag_full_pep8)
endfunction

"Function: saloon#prospector#ToggleFlagNoAutodetect() function {{{3
function! saloon#prospector#ToggleFlagNoAutodetect() abort
    call saloon#prospector#ToggleFlag(g:prospector_flag_no_autodetect)
endfunction

"Function: saloon#prospector#ToggleFlagNoBlending() function {{{3
function! saloon#prospector#ToggleFlagNoBlending() abort
    call saloon#prospector#ToggleFlag(g:prospector_flag_no_blending)
endfunction

"Function: saloon#prospector#ToggleFlagNoStyleWarnings() function {{{3
function! saloon#prospector#ToggleFlagNoStyleWarnings() abort
    call saloon#prospector#ToggleFlag(g:prospector_flag_no_style_warnings)
endfunction

"Function: saloon#prospector#ToggleFlagTestWarnings() function {{{3
function! saloon#prospector#ToggleFlagTestWarnings() abort
    call saloon#prospector#ToggleFlag(g:prospector_flag_test_warnings)
endfunction
"Flag Disable Functions {{{2
"Function: saloon#prospector#DisableFlag() function {{{3
function! saloon#prospector#DisableFlag(flag) abort
    call s:prospector_flags.disable(a:flag)
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#DisableFlagDocWarnings() function {{{3
function! saloon#prospector#DisableFlagDocWarnings() abort
    call saloon#prospector#DisableFlag(g:prospector_flag_doc_warnings)
endfunction

"Function: saloon#prospector#DisableFlagFullPep8() function {{{3
function! saloon#prospector#DisableFlagFullPep8() abort
    call saloon#prospector#DisableFlag(g:prospector_flag_full_pep8)
endfunction

"Function: saloon#prospector#DisableFlagNoAutodetect() function {{{3
function! saloon#prospector#DisableFlagNoAutodetect() abort
    call saloon#prospector#DisableFlag(g:prospector_flag_no_autodetect)
endfunction

"Function: saloon#prospector#DisableFlagNoBlending() function {{{3
function! saloon#prospector#DisableFlagNoBlending() abort
    call saloon#prospector#DisableFlag(g:prospector_flag_no_blending)
endfunction

"Function: saloon#prospector#DisableFlagNoStyleWarnings() function {{{3
function! saloon#prospector#DisableFlagNoStyleWarnings() abort
    call saloon#prospector#DisableFlag(g:prospector_flag_no_style_warnings)
endfunction

"Function: saloon#prospector#DisableFlagTestWarnings() function {{{3
function! saloon#prospector#DisableFlagTestWarnings() abort
    call saloon#prospector#DisableFlag(g:prospector_flag_test_warnings)
endfunction
"Flag Enable Functions {{{2
"Function: saloon#prospector#EnableFlag() function {{{3
function! saloon#prospector#EnableFlag(flag) abort
    call s:prospector_flags.enable(a:flag)
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#EnableFlagDocWarnings() function {{{3
function! saloon#prospector#EnableFlagDocWarnings() abort
    call saloon#prospector#EnableFlag(g:prospector_flag_doc_warnings)
endfunction

"Function: saloon#prospector#EnableFlagFullPep8() function {{{3
function! saloon#prospector#EnableFlagFullPep8() abort
    call saloon#prospector#EnableFlag(g:prospector_flag_full_pep8)
endfunction

"Function: saloon#prospector#EnableFlagNoAutodetect() function {{{3
function! saloon#prospector#EnableFlagNoAutodetect() abort
    call saloon#prospector#EnableFlag(g:prospector_flag_no_autodetect)
endfunction

"Function: saloon#prospector#EnableFlagNoBlending() function {{{3
function! saloon#prospector#EnableFlagNoBlending() abort
    call saloon#prospector#EnableFlag(g:prospector_flag_no_blending)
endfunction

"Function: saloon#prospector#EnableFlagNoStyleWarnings() function {{{3
function! saloon#prospector#EnableFlagNoStyleWarnings() abort
    call saloon#prospector#EnableFlag(g:prospector_flag_no_style_warnings)
endfunction

"Function: saloon#prospector#EnableFlagTestWarnings() function {{{3
function! saloon#prospector#EnableFlagTestWarnings() abort
    call saloon#prospector#EnableFlag(g:prospector_flag_test_warnings)
endfunction


" Toggle parts of options {{{2
"Function: saloon#prospector#DecreaseStrictness() function {{{3
function! saloon#prospector#DecreaseStrictness() abort
    let l:strictness_levels = saloon#prospector#GetStrictnessLevels()
    let l:new_level = index(l:strictness_levels,
                          \ g:prospector_option_value_strictness) - 1
    if l:new_level < 0
        let g:prospector_option_value_strictness = ''
    else
        let g:prospector_option_value_strictness = l:strictness_levels[l:new_level]
    endif
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#IncreaseStrictness() function {{{3
function! saloon#prospector#IncreaseStrictness() abort
    let l:strictness_levels = saloon#prospector#GetStrictnessLevels()
    let l:new_level = index(l:strictness_levels,
                          \ g:prospector_option_value_strictness) + 1
    if l:new_level < len(l:strictness_levels)
        let g:prospector_option_value_strictness = l:strictness_levels[l:new_level]
    endif
    call s:updateProspectorCommand()
endfunction

"Function: saloon#prospector#ToggleTool() function {{{3
function! saloon#prospector#ToggleTool(tool) abort
    if index(saloon#prospector#GetToolsAvailable(), a:tool) < 0
        return -1
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
    call saloon#prospector#ToggleTool("bandit")
endfunction

"Function: saloon#prospector#ToggleToolDodgy() function {{{3
function! saloon#prospector#ToggleToolDodgy() abort
    call saloon#prospector#ToggleTool("dodgy")
endfunction

"Function: saloon#prospector#ToggleToolFrosted() function {{{3
function! saloon#prospector#ToggleToolFrosted() abort
    call saloon#prospector#ToggleTool("frosted")
endfunction

"Function: saloon#prospector#ToggleToolMccabe() function {{{3
function! saloon#prospector#ToggleToolMccabe() abort
    call saloon#prospector#ToggleTool("mccabe")
endfunction

"Function: saloon#prospector#ToggleToolMyPy() function {{{3
function! saloon#prospector#ToggleToolMyPy() abort
    call saloon#prospector#ToggleTool("mypy")
endfunction

"Function: saloon#prospector#ToggleToolPep257() function {{{3
function! saloon#prospector#ToggleToolPep257() abort
    call saloon#prospector#ToggleTool("pep257")
endfunction

"Function: saloon#prospector#ToggleToolPep8() function {{{3
function! saloon#prospector#ToggleToolPep8() abort
    call saloon#prospector#ToggleTool("pep8")
endfunction

"Function: saloon#prospector#ToggleToolProfileValidator() function {{{3
function! saloon#prospector#ToggleToolProfileValidator() abort
    call saloon#prospector#ToggleTool("profile-validator")
endfunction

"Function: saloon#prospector#ToggleToolPyflakes() function {{{3
function! saloon#prospector#ToggleToolPyflakes() abort
    call saloon#prospector#ToggleTool("pyflakes")
endfunction

"Function: saloon#prospector#ToggleToolPylint() function {{{3
function! saloon#prospector#ToggleToolPylint() abort
    call saloon#prospector#ToggleTool("pylint")
endfunction

"Function: saloon#prospector#ToggleToolPyroma() function {{{3
function! saloon#prospector#ToggleToolPyroma() abort
    call saloon#prospector#ToggleTool("pyroma")
endfunction

"Function: saloon#prospector#ToggleToolVulture() function {{{3
function! saloon#prospector#ToggleToolVulture() abort
    call saloon#prospector#ToggleTool("vulture")
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
