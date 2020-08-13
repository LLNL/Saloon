syn match SaloonHeader #^" Saloon#
syn match SaloonHeader #^" ==*#
syn match SaloonSubHeader "^  .*:$"
syn match SaloonToolHeader "^[A-Z].*:$"
syn match SaloonToggleOn  "    (on)"ms=s+5,me=e-1
syn match SaloonToggleOff "    (off)"ms=s+5,me=e-1

hi def link SaloonHeader Statement
hi def link SaloonToolHeader Title
hi def link SaloonSubHeader String

hi def link SaloonToggleOn Question
hi def link SaloonToggleOff WarningMsg
