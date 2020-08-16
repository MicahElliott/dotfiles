# Zsh-specific aliases (not supported by bash)
#print "in aliases.zsh"

### Programs to auto-run per extension.
# So just putting "foo.txt" on CLI will expand to "vim foo.txt"
# See ~/.dircolors for many more
alias -s txt=$EDITOR
alias -s mkd=$EDITOR
alias -s csv=$EDITOR
alias -s html=$EDITOR
alias -s haml=$EDITOR
alias -s vim=$EDITOR
alias -s sass=$EDITOR
alias -s scss=$EDITOR
alias -s log=$EDITOR
alias -s png=feh
alias -s jpg=feh
alias -s flv=vp
alias -s mp4=vp
alias -s webm=$BROWSER
alias -s xcf=gimp
alias -s gz='tar xzvf'
alias -s bz2='tar xjvf'
alias -s pdf=evince
alias -s deb='sudo dpkg -i'
alias -s feature='cucumber'

### Globals
alias -g A='| a'
alias -g B='| bcat'
alias -g C='| wc -l'
alias -g D='| dump'
alias -g G='| ag'
alias -g F='| fzf'
alias -g H='| head'
alias -g J='| jq'
alias -g L='| less'
alias -g P='| $PAGER'
alias -g S='| sort -n'
alias -g T='| tail'
alias -g U='| uniq'
alias -g X='| xsel -b'
alias -g TSV="|sed -rn '2,$ p' |csv2tsv.rb S"
#alias -g TSV='|sn "2,$p" |csv2tsv.rb'
