" Micah's python plugin.

"if exists("loaded_mde")
  "finish
"endif
"let loaded_mde = 1

source ~/.vim/ftplugin/comments.vim
source ~/gitcontainer/vim/Rainbow-Parenthesis/syntax/RainbowParenthsis.vim

set tabstop=4
set shiftwidth=4
"set nocindent
set autoindent
set expandtab
set textwidth=72

" For Codetag
"imap <Leader>f :r !date +\%F<CR>O# FIXME: . <MDE<Esc>JA><Esc>BBBi
"imap <Leader>f # FIXME: . <MDE<Esc>:r !date +\%F<CR>kJA><Esc>3Bi
"imap <Leader>t # TODO: . <MDE<Esc>:r !date +\%F<CR>kJA><Esc>3Bi
"imap <Leader>b # BUG: . <MDE<Esc>:r !date +\%F<CR>kJA><Esc>3Bi
"imap <Leader>n # NOTE: . <MDE<Esc>:r !date +\%F<CR>kJA><Esc>3Bi
"imap <Leader>g # GLOSS: . <MDE<Esc>:r !date +\%F<CR>kJA><Esc>3Bi
"imap <Leader>- <Esc>O<CR><Esc>70i-<Esc>0r#j

"nmap <Leader>m :make<CR>

" For Codetag
"pyfile ~/.vim/addon.py
"pyfile ~/sandbox/codetag1/examples/vimextend.py
"com -nargs=* Ctd python archiveCodetag(<f-args>)
"nmap \d :Ctd<CR>

"au BufNewFile *.py  0read ~/.vim/skel/skel.py
"au BufNewFile *.py r ~/.vim/skel/skel.test.py

let python_highlight_all = 1
