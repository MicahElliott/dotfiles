" Special non-standard comment types, to rainbow-ify your code.
" For languages that use #, like Ruby, Zsh, Python.

"echo "in syntax/comments.vim" | sleep 1

" Silly to have to add the starts-with-optional-spaces, but sh/zsh
" syntax seems to need it.
syn match CommentCode         "\s*##\w.*$"    display
syn match CommentKing         "\s*### .*$"    display
syn match CommentMajorSection "\s*####*$"     display
syn match CommentMiddleSection "\s*#===*$"     display
syn match CommentMinorSection "\s*#---*$"     display
syn match CommentSmart        "\s*###\w.*$"   display
syn match CommentInfo         "\s*#\s[A-Z][a-z]\+: \+.*$"   display
syn match CommentDisabled     "\s*#\w.*$"     display
syn match CommentJavadoc      ".* \+@\w\+:"  display
syn match CommentEpydoc       ".* \+:\w\+:.*"  display
syn match CommentRun          "\%^#!.*$"
syn match CommentDescription  "# [[:alpha:]-]\+ — \w.*$"    display
"syn region  CommentEol        start="\w.* \+# \w.*$" end="$" display excludenl

"echo "done with syntax/comments.vim" | sleep 1
