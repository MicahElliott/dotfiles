" Syntax for Teacher-Class List Files

""" Good things
syn region THead          start="^=" end="$" contains=BadSection oneline keepend
syn match Email           " <.*@.*>"
hi THead ctermfg=27
hi Email ctermfg=40 cterm=italic

""" Bad things
"syn region TeacherLine start="^=" end="$"
syn match AllCaps         ".*[A-Z][A-Z][A-Z].*"
syn match TooManyNames    "^[A-z,-]\+ [^ ]\+ \([A-z,-]\+\)"
syn match ExtraSpace      "\s\s\+"
syn match JunkInName     "^[^=][^A-z ,-]"
" http://vim.1045645.n5.nabble.com/highlighting-quot-weird-quot-characters-td1160262.html
syn match NonAsciiJunk    /[^ -~]/
syn match NameExtension   "\v,* (II|III|IV|V|Jr|Jr\.)$"
syn match NameJunk        "['.*]"
syn match BadSection  "[SP][0-9]$"
syn match MissingLastName "^[^ 	]*$"
syn match TabJunk "\t"
syn match SpecialStudent "^!.*$"
syn match BadEmail " <.*[A-Z]\+.*>"

hi TooManyNames    ctermbg=196 ctermfg=27  cterm=bold
hi JunkInName      ctermbg=27  ctermfg=88  cterm=bold
hi NonAsciiJunk    ctermbg=131 ctermfg=82  cterm=bold
hi NameExtension   ctermbg=184 ctermfg=232 cterm=bold
hi AllCaps         ctermbg=30  ctermfg=232 cterm=bold
hi NameJunk        ctermbg=166 ctermfg=232 cterm=bold
hi ExtraSpace      ctermbg=100
hi BadSection                  ctermfg=88  cterm=bold
hi MissingLastName             ctermfg=154 cterm=bold
hi TabJunk         ctermbg=207
hi SpecialStudent  ctermbg=253 ctermfg=233 cterm=bold
hi BadEmail        ctermbg=111 ctermfg=233 cterm=bold
