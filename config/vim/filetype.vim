" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  "au! BufRead,BufNewFile *_spec.js.coffee  set filetype=jasmine.coffee syntax=jasmine
  au! BufRead,BufNewFile *.rst,*.rest setfiletype rest
  au! BufRead,BufNewFile *.creole setfiletype creole
  au! BufRead,BufNewFile *.txt,*.text,*.TXT  setfiletype text
  au! BufRead,BufNewFile *.t     setfiletype perl
  au! BufRead,BufNewFile *.moin  setfiletype moin
  "au! BufRead,BufNewFile *.html  setfiletype html
  au! BufRead,BufNewFile *.docbook,*.docbk,*.db, setfiletype docbook
  au! BufRead,BufNewFile *.sass         setfiletype sass
  au! BufRead,BufNewFile *.scss         setfiletype scss
  au! BufRead,BufNewFile *.mkd,*.md,*.markdown,*.ron,*.ronn  setfiletype markdown
  au! BufRead,BufNewFile *.eo  setfiletype eo
  au! BufRead,BufNewFile *.cljs  setfiletype clojure
  au Bufenter,Bufnewfile *.clj setl complete+=k~/.clj_completions
  " Zsh's syntax file is inferior to sh. Also need to make it think it's
  " more than just sh (bash removes some errors). This actually does no
  " good since system syntax files are read before this.
  au! BufRead,BufNewFile *.zsh  set filetype=sh | let b:is_bash = 1
  "au! BufWrite *.sass         !compass
augroup END
