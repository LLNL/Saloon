syn match SaloonHeader #^" Saloon#
syn match SaloonHeader #^" ==\+#
syn match SaloonSubHeader "^  .\+:$"
syn match SaloonToolHeader "^[A-Z].\+:$"
syn match SaloonToggleOn  "(on)"ms=e-2,me=e-1
syn match SaloonToggleOff "(off)"ms=e-3,me=e-1
syn match ProspectorStrictnessRange "\[[,0-9 ]\+\]"ms=s+1,me=e-1
syn match ProspectorStrictnessUpdate "([di])"ms=s+1,me=e-1

hi def link SaloonHeader Statement
hi def link SaloonToolHeader Title
hi def link SaloonSubHeader String

hi def link SaloonToggleOn Question
hi def link SaloonToggleOff WarningMsg
hi def link ProspectorStrictnessRange DiffAdd
hi def link ProspectorStrictnessUpdate DiffAdd
