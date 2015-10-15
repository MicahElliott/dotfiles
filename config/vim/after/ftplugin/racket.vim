
" Hack to get around commentary adding a space
let b:commentary_format = ';%s'

"iunmap (
"inoremap [ (

"echo "even better commentstring"
setl commentstring=;%s

syn match racketGlobal /\C[A-Z]\+/ display
hi racketGlobal ctermfg=159
