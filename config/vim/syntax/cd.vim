" Syntax for Teacher-Class List Files

""" Good things
syn region THead          start="^=" end="$" contains=BadSection oneline keepend
syn match Email           " <.*@.*>"
hi THead ctermfg=27
hi Email ctermfg=40 cterm=italic

syn match fretno     "^\s\s\?\d\d\?"
syn match root       "[♯♭♮]\?R"
syn match second     "[♯♭♮]\?2"
syn match third      "[♯♭♮]\?3"
syn match fourth     "[♯♭♮]\?4"
syn match fifth      "[♯♭♮]\?5"
syn match sixth      "[♯♭♮]\?6"
syn match seventh    "[♯♭♮]\?7"
syn match ninth      "[♯♭♮]\?9"
syn match eleventh   "[♯♭♮]\?11"
syn match thirteenth "[♯♭♮]\?13"
syn match barre "·"

hi fretno      ctermbg=166     ctermfg=232 cterm=bold
hi root        ctermfg=red     cterm=bold
hi second      ctermfg=blue    cterm=none
hi third       ctermfg=blue    cterm=none
hi fourth      ctermfg=yellow  cterm=bold
hi fifth       ctermfg=yellow  cterm=none
hi sixth       ctermfg=green   cterm=bold
hi seventh     ctermfg=green   cterm=bold
hi ninth       ctermfg=green   cterm=bold
hi eleventh    ctermfg=green   cterm=bold
hi thirteenth  ctermfg=green   cterm=bold
hi barre  ctermfg=cyan   cterm=none
