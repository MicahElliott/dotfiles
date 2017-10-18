" clojure

"echo "in ftplugin"

"source ~/.vim/syntax/comments.vim

" Fireplace should handle K
"set keywordprg=~/bin/mdeslime.zsh

abbr (p (println

"nmap <Leader>P :call PareditToggle()<CR>

" % is just too hard to frequently reach
"nmap ( %
"nmap ) %

" SLIMV: a video: http://vimeo.com/38372260
" But not going to use it.
" Problems with slimv repl:
" * completion doesn't really work
" * has some silly par* modes
" * overrides (or plays poorly with) lots of mappings
" * only way to get history is via up/down arrows
" * probably plays poorly with vimclojure
" * docs are generic to lisp; no real tutorial
"let g:slimv_swank_clojure = '! xterm -e lein swank &'

"imap <silent> <Leader-r> :ReplHere
nmap <Leader>r :ReplHere<CR>

" Not good with omnicompletion
"imap <silent> <C-S-P> <Plug>clj_repl_uphist.
"imap <silent> <C-S-N> <Plug>clj_repl_downhist.

" Work around sexp only honoring <BS>
imap <buffer> <C-h> <Plug>(sexp_insert_backspace)

"au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
