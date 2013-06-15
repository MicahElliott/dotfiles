# Zsh-specific aliases (not supported by bash)
#print "in aliases.zsh"

### Programs to auto-run per extension.
# So just putting "foo.txt" on CLI will expand to "vim foo.txt"
# See ~/.dircolors for many more
alias -s txt=vim
alias -s mkd=vim
alias -s csv=vim
alias -s html=vim
alias -s haml=vim
alias -s vim=vim
alias -s sass=vim
alias -s scss=vim
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

# Places to cd
# Actually, these behave better using cdpath (see options.zsh)
#alias -g mb=~/proj/Membean

# I can't seem to get ESC-h working for run-help, so this'll have to do.
alias h=run-help

alias de='vared dirstack'
alias dired='vared dirstack'

### Globals
alias -g A='| a'
alias -g B='| bcat'
alias -g C='| wc -l'
alias -g D='| dump'
alias -g G='| g -i'
alias -g H='| head'
alias -g J='| j2c'
alias -g L='| less'
alias -g P='| $PAGER'
alias -g S='| sort -n'
alias -g T='| tail'
alias -g U='| uniq'
alias -g TSV="|sed -rn '2,$ p' |csv2tsv.rb S"
#alias -g TSV='|sn "2,$p" |csv2tsv.rb'
